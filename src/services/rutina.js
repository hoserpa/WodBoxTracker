import { supabase } from '@/lib/supabase'

export const rutinaService = {
  async getAll() {
    const { data, error } = await supabase
      .from('rutinas')
      .select('*')
      .order('id')
    
    if (error) throw error
    return data
  },

  async getById(id) {
    const { data, error } = await supabase
      .from('rutinas')
      .select('*')
      .eq('id', id)
      .single()
    
    if (error) throw error
    return data
  }
}
