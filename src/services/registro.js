import { supabase } from "@/lib/supabase";

export const registroService = {

  async getBySeries(serieIds) {
    const { data, error } = await supabase
      .from("registros")
      .select("*")
      .in("serie_id", serieIds);

    if (error) throw error;

    const registroMap = {};
    data?.forEach((r) => {
      if (!registroMap[r.serie_id]) {
        registroMap[r.serie_id] = r;
      }
    });
    return registroMap;
  },

  async save(serieId, peso) {
    const { data, error } = await supabase
      .from("registros")
      .insert({ serie_id: serieId, peso })
      .select()
      .single();

    if (error) throw error;
    return data;
  },

  async update(registroId, peso) {
    const { data, error } = await supabase
      .from("registros")
      .update({ peso })
      .eq("id", registroId)
      .select()
      .single();

    if (error) throw error;
    return data;
  },
};
