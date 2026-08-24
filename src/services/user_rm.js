import { supabase } from "@/lib/supabase";
import { useAuthStore } from "@/stores/auth";

export const userRmService = {
  async getByUser () {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    const { data, error } = await supabase
      .from("user_rm")
      .select("*")
      .eq("user_id", userId)
      .order("fecha", { ascending: false });

    if (error) throw error;
    return data;
  },

  async getMapByEjercicioIds (ejercicioIds) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId || !ejercicioIds || ejercicioIds.length === 0) {
      return {};
    }

    const { data, error } = await supabase
      .from("user_rm")
      .select("ejercicio_id, rm, fecha")
      .eq("user_id", userId)
      .in("ejercicio_id", ejercicioIds);

    if (error) {
      console.error("Error fetching rm map:", error);
      throw error;
    }

    const rmMap = {};
    data?.forEach((r) => {
      rmMap[r.ejercicio_id] = { rm: r.rm, fecha: r.fecha };
    });

    return rmMap;
  },

  async getByTipo (tipoNombre) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    const tipoMap = {
      calentamiento: 1,
      principal: 2,
      secundario: 3,
      core: 4,
      halterofilia: 5,
    };

    const tipoId = tipoMap[tipoNombre];
    if (!tipoId) {
      return [];
    }

    const { data: ejercicios, error: errorEjercicios } = await supabase
      .from("ejercicios")
      .select("id, nombre, tipo_id, user_id")
      .eq("tipo_id", tipoId)
      .order("nombre");

    if (errorEjercicios) {
      console.error("Error fetching ejercicios:", errorEjercicios);
      throw errorEjercicios;
    }

    const ejercicioIds = ejercicios.map((e) => e.id);

    if (ejercicioIds.length === 0) {
      return [];
    }

    let rms = [];
    if (userId) {
      const { data: rmsData, error: errorRms } = await supabase
        .from("user_rm")
        .select("*")
        .eq("user_id", userId)
        .in("ejercicio_id", ejercicioIds);

      if (errorRms) {
        console.error("Error fetching rms:", errorRms);
        throw errorRms;
      }
      rms = rmsData || [];
    }

    return ejercicios.map((ejercicio) => {
      const rm = rms.find((r) => r.ejercicio_id === ejercicio.id);
      return {
        ...ejercicio,
        rm: rm?.rm || null,
        fecha: rm?.fecha || null,
        notas: rm?.notas || null,
      };
    });
  },

  async getHalterofilia () {
    // Query 1: Ejercicios con tipo_id = 5 (halterofilia)
    const { data: halterofiliaEjercicios, error: errorHalterofilia } =
      await supabase
        .from("ejercicios")
        .select("id, nombre, tipo_id, user_id")
        .eq("tipo_id", 5)
        .order("nombre");

    if (errorHalterofilia) {
      console.error("Error fetching halterofilia ejercicios:", errorHalterofilia);
      throw errorHalterofilia;
    }

    // Query 2: Ejercicios con nombres "BACK SQUAT" y "FRONT SQUAT" (tipo_id = 2 - principal)
    const { data: squatEjercicios, error: errorSquat } = await supabase
      .from("ejercicios")
      .select("id, nombre, tipo_id, user_id")
      .eq("tipo_id", 2)
      .in("nombre", ["BACK SQUAT", "FRONT SQUAT"])
      .order("nombre");

    if (errorSquat) {
      console.error("Error fetching squat ejercicios:", errorSquat);
      throw errorSquat;
    }

    // Combinar listas eliminando duplicados por id
    const combinedMap = new Map();
    halterofiliaEjercicios.forEach((e) => combinedMap.set(e.id, e));
    squatEjercicios.forEach((e) => {
      if (!combinedMap.has(e.id)) {
        combinedMap.set(e.id, e);
      }
    });

    const allEjercicios = Array.from(combinedMap.values());
    const ejercicioIds = allEjercicios.map((e) => e.id);

    if (ejercicioIds.length === 0) {
      return [];
    }

    // Obtener RM del usuario para estos ejercicios
    const rmMap = await this.getMapByEjercicioIds(ejercicioIds);

    // Enriquecer con RM y retornar
    return allEjercicios.map((ejercicio) => {
      const rmData = rmMap[ejercicio.id];
      return {
        ...ejercicio,
        rm: rmData?.rm || null,
        fecha: rmData?.fecha || null,
        notas: rmData?.notas || null,
      };
    });
  },

  async upsert (ejercicioId, rm, notas = null) {
    const authStore = useAuthStore();
    const userId = authStore.user?.id;

    if (!userId) {
      throw new Error("User not authenticated");
    }

    const { data, error } = await supabase
      .from("user_rm")
      .upsert(
        {
          user_id: userId,
          ejercicio_id: ejercicioId,
          rm,
          notas,
          fecha: new Date().toISOString(),
        },
        { onConflict: "user_id,ejercicio_id" },
      )
      .select()
      .single();

    if (error) throw error;
    return data;
  },
};
