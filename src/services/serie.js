import { supabase } from '@/lib/supabase'

export const serieService = {
  async getByDia(diaId) {
    const { data, error } = await supabase
      .from('series')
      .select(`
        *,
        ejercicio:ejercicios(nombre, tipo_id)
      `)
      .eq('dia_id', diaId)
      .order('orden')
    
    if (error) throw error
    return data
  }
}
