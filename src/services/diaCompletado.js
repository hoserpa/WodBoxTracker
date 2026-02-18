import { supabase } from "@/lib/supabase";

export const diaCompletadoService = {
  async getByRutina(rutinaId) {
    const { data: semanas } = await supabase
      .from("semanas")
      .select("id")
      .eq("rutina_id", rutinaId);

    if (!semanas || semanas.length === 0) return [];

    const semanaIds = semanas.map((s) => s.id);

    const { data: dias } = await supabase
      .from("dias")
      .select("id, semana_id")
      .in("semana_id", semanaIds);

    if (!dias || dias.length === 0) return [];

    const diaIds = dias.map((d) => d.id);

    const { data, error } = await supabase
      .from("dias_completados")
      .select("dia_id")
      .in("dia_id", diaIds);

    if (error) throw error;

    const diaMap = {};
    dias.forEach((d) => (diaMap[d.id] = d.semana_id));

    return (
      data?.map((r) => ({
        dia_id: r.dia_id,
        semana_id: diaMap[r.dia_id],
      })) || []
    );
  },

  async getBySemana(semanaId) {
    const { data: dias } = await supabase
      .from("dias")
      .select("id")
      .eq("semana_id", semanaId);

    if (!dias || dias.length === 0) return [];

    const diaIds = dias.map((d) => d.id);

    const { data, error } = await supabase
      .from("dias_completados")
      .select("dia_id")
      .in("dia_id", diaIds);

    if (error) throw error;
    return data || [];
  },

  async getByDia(diaId) {
    const { data, error } = await supabase
      .from("dias_completados")
      .select("*")
      .eq("dia_id", diaId)
      .maybeSingle();

    if (error) throw error;
    return data;
  },

  async toggle(diaId) {
    const existing = await this.getByDia(diaId);

    if (existing) {
      const { error } = await supabase
        .from("dias_completados")
        .delete()
        .eq("id", existing.id);

      if (error) throw error;
      return null;
    } else {
      const { data, error } = await supabase
        .from("dias_completados")
        .insert({ dia_id: diaId, completado: true })
        .select()
        .single();

      if (error) throw error;
      return data;
    }
  },

  async resetAll() {
    const { error } = await supabase
      .from("dias_completados")
      .delete()
      .neq("id", 0);

    if (error) throw error;
  },
};
