import { supabase } from "@/lib/supabase";

export const exerciseDetailService = {
  async getById(id) {
    const { data, error } = await supabase
      .from("exercise_details")
      .select("*")
      .eq("id", id)
      .single();
    if (error) throw error;
    return data;
  },
};
