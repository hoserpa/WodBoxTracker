import { supabase } from "@/lib/supabase";

export const ejercicioService = {
  async getAll() {
    const { data, error } = await supabase
      .from("ejercicios")
      .select("*, tipos_ejercicio(nombre)")
      .order("nombre");

    if (error) throw error;
    return data;
  },

  async getByTipo(tipoNombre) {
    const { data, error } = await supabase
      .from("ejercicios")
      .select("*, tipos_ejercicio(nombre)")
      .eq("tipos_ejercicio.nombre", tipoNombre)
      .order("nombre");

    if (error) throw error;
    return data;
  },
};
