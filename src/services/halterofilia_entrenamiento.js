import { supabase } from "@/lib/supabase";
import { useAuthStore } from "@/stores/auth";

export const halterofiliaService = {
  async create(entrenamiento) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { notas, ejercicios } = entrenamiento;

    const { data: entrenamientoData, error: entrenamientoError } =
      await supabase
        .from("halterofilia_entrenamientos")
        .insert({
          user_id: userId,
          notas: notas || null,
        })
        .select()
        .single();

    if (entrenamientoError) {
      throw entrenamientoError;
    }

    if (ejercicios && ejercicios.length > 0) {
      for (let i = 0; i < ejercicios.length; i++) {
        const ejercicio = ejercicios[i];

        const { data: ejercicioData, error: ejercicioError } = await supabase
          .from("halterofilia_ejercicios")
          .insert({
            entrenamiento_id: entrenamientoData.id,
            ejercicio_id: ejercicio.ejercicio_id,
            orden: i,
          })
          .select()
          .single();

        if (ejercicioError) {
          throw ejercicioError;
        }

        if (ejercicio.rondas && ejercicio.rondas.length > 0) {
          const rondasData = ejercicio.rondas.map((ronda, j) => ({
            ejercicio_entrenamiento_id: ejercicioData.id,
            repeticiones: ronda.repeticiones,
            series: ronda.series,
            porcentaje: ronda.porcentaje,
            peso: ronda.peso || null,
            orden: j,
          }));

          const { error: rondasError } = await supabase
            .from("halterofilia_rondas")
            .insert(rondasData);

          if (rondasError) {
            throw rondasError;
          }
        }
      }
    }

    return entrenamientoData;
  },

  async getAll() {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { data: entrenamientos, error } = await supabase
      .from("halterofilia_entrenamientos")
      .select("*")
      .eq("user_id", userId)
      .order("fecha", { ascending: false });

    if (error) {
      throw error;
    }

    for (const entrenamiento of entrenamientos) {
      const { data: ejerciciosData, error: ejerciciosError } = await supabase
        .from("halterofilia_ejercicios")
        .select(
          `
          *,
          ejercicios (nombre)
        `,
        )
        .eq("entrenamiento_id", entrenamiento.id)
        .order("orden");

      if (!ejerciciosError && ejerciciosData) {
        for (const ejercicio of ejerciciosData) {
          const { data: rondasData, error: rondasError } = await supabase
            .from("halterofilia_rondas")
            .select("*")
            .eq("ejercicio_entrenamiento_id", ejercicio.id)
            .order("orden");

          if (!rondasError) {
            ejercicio.rondas = rondasData;
          }
        }
        entrenamiento.ejercicios = ejerciciosData.map((e) => ({
          ...e,
          nombre_ejercicio: e.ejercicios?.nombre,
        }));
      }
    }

    return entrenamientos;
  },

  async getById(id) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { data: entrenamiento, error } = await supabase
      .from("halterofilia_entrenamientos")
      .select("*")
      .eq("id", id)
      .eq("user_id", userId)
      .single();

    if (error) {
      throw error;
    }

    const { data: ejerciciosData, error: ejerciciosError } = await supabase
      .from("halterofilia_ejercicios")
      .select(
        `
        *,
        ejercicios (nombre)
      `,
      )
      .eq("entrenamiento_id", id)
      .order("orden");

    if (!ejerciciosError && ejerciciosData) {
      for (const ejercicio of ejerciciosData) {
        const { data: rondasData, error: rondasError } = await supabase
          .from("halterofilia_rondas")
          .select("*")
          .eq("ejercicio_entrenamiento_id", ejercicio.id)
          .order("orden");

        if (!rondasError) {
          ejercicio.rondas = rondasData;
        }
      }
      entrenamiento.ejercicios = ejerciciosData.map((e) => ({
        ...e,
        nombre_ejercicio: e.ejercicios?.nombre,
      }));
    }

    return entrenamiento;
  },

  async delete(id) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { error } = await supabase
      .from("halterofilia_entrenamientos")
      .delete()
      .eq("id", id)
      .eq("user_id", userId);

    if (error) {
      throw error;
    }
  },

  async update(id, entrenamiento) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { notas, ejercicios, fecha } = entrenamiento;

    const { error: updateError } = await supabase
      .from("halterofilia_entrenamientos")
      .update({
        notas: notas || null,
        fecha: fecha || null,
      })
      .eq("id", id)
      .eq("user_id", userId);

    if (updateError) {
      throw updateError;
    }

    const { data: ejerciciosExistentes, error: ejerciciosError } = await supabase
      .from("halterofilia_ejercicios")
      .select("id")
      .eq("entrenamiento_id", id);

    if (!ejerciciosError && ejerciciosExistentes) {
      const ejercicioIds = ejerciciosExistentes.map((e) => e.id);
      if (ejercicioIds.length > 0) {
        await supabase.from("halterofilia_rondas").delete().in("ejercicio_entrenamiento_id", ejercicioIds);
      }
      await supabase.from("halterofilia_ejercicios").delete().eq("entrenamiento_id", id);
    }

    if (ejercicios && ejercicios.length > 0) {
      for (let i = 0; i < ejercicios.length; i++) {
        const ejercicio = ejercicios[i];

        const { data: ejercicioData, error: ejercicioError } = await supabase
          .from("halterofilia_ejercicios")
          .insert({
            entrenamiento_id: id,
            ejercicio_id: ejercicio.ejercicio_id,
            orden: i,
          })
          .select()
          .single();

        if (ejercicioError) {
          throw ejercicioError;
        }

        if (ejercicio.rondas && ejercicio.rondas.length > 0) {
          const rondasData = ejercicio.rondas.map((ronda, j) => ({
            ejercicio_entrenamiento_id: ejercicioData.id,
            repeticiones: ronda.repeticiones,
            series: ronda.series,
            porcentaje: ronda.porcentaje,
            peso: ronda.peso || null,
            orden: j,
          }));

          const { error: rondasError } = await supabase
            .from("halterofilia_rondas")
            .insert(rondasData);

          if (rondasError) {
            throw rondasError;
          }
        }
      }
    }

    return { id, notas, ejercicios };
  },
};
