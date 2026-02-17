import { supabase } from '@/lib/supabase'

export const diaService = {
  async getBySemana(semanaId) {
    const { data, error } = await supabase
      .from('dias')
      .select('*')
      .eq('semana_id', semanaId)
      .order('numero')
    
    if (error) throw error
    return data
  },

  async getById(id) {
    const { data, error } = await supabase
      .from('dias')
      .select('*')
      .eq('id', id)
      .single()
    
    if (error) throw error
    return data
  }
}
