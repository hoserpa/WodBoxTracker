import { supabase } from '@/lib/supabase'

export const semanaService = {
  async getByRutina(rutinaId) {
    const { data, error } = await supabase
      .from('semanas')
      .select('*')
      .eq('rutina_id', rutinaId)
      .order('numero')
    
    if (error) throw error
    return data
  },

  async getById(id) {
    const { data, error } = await supabase
      .from('semanas')
      .select('*')
      .eq('id', id)
      .single()
    
    if (error) throw error
    return data
  }
}
