import { supabase } from "@/lib/supabase";

export const serieService = {
  async getByDia(diaId) {
    const { data, error } = await supabase
      .from("series")
      .select("*")
      .eq("dia_id", diaId)
      .order("tipo_ejercicio", { ascending: true })
      .order("orden");

    if (error) throw error;

    const ejercicioIds = [...new Set(data.map((s) => s.ejercicio_id))];
    const { data: ejercicios } = await supabase
      .from("ejercicios")
      .select("id, nombre, url")
      .in("id", ejercicioIds);

    const ejercicioMap = {};
    ejercicios?.forEach((e) => {
      ejercicioMap[e.id] = e;
    });

    return data.map((s) => ({
      ...s,
      ejercicio: ejercicioMap[s.ejercicio_id],
    }));
  },
};
