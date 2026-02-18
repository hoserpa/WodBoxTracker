import { supabase } from "@/lib/supabase";

export const rutinaService = {
  async getAll() {
    const { data, error } = await supabase
      .from("rutinas")
      .select("*")
      .order("id");

    if (error) throw error;
    return data;
  },

  async getById(id) {
    const { data, error } = await supabase
      .from("rutinas")
      .select("*")
      .eq("id", id)
      .single();

    if (error) throw error;
    return data;
  },

  async create(rutina) {
    const { data, error } = await supabase
      .from("rutinas")
      .insert(rutina)
      .select()
      .single();

    if (error) throw error;
    return data;
  },

  async update(id, rutina) {
    const { data, error } = await supabase
      .from("rutinas")
      .update(rutina)
      .eq("id", id)
      .select()
      .single();

    if (error) throw error;
    return data;
  },

  async delete(id) {
    const { error } = await supabase.from("rutinas").delete().eq("id", id);

    if (error) throw error;
  },
};
