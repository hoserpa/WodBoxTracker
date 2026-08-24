import { computed } from "vue";
import { useQuery } from "@tanstack/vue-query";
import { supabase } from "@/lib/supabase";
import wodsData from "@/data/wods.json";

export function useWodDelDia() {
  const query = useQuery({
    queryKey: ["wod-del-dia"],
    queryFn: async () => {
      const { data, error: rpcError } = await supabase.rpc("obtener_wod_del_dia");
      if (rpcError) throw rpcError;
      const row = Array.isArray(data) ? data[0] : data;
      if (!row) throw new Error("El WOD del día no está disponible");
      return Number(row.wod_elegido);
    },
    staleTime: 1000 * 60 * 30,
  });

  const wod = computed(() => {
    if (query.data.value == null) return null;
    return wodsData.find((w) => w.id === query.data.value) ?? null;
  });

  return { wod, isLoading: query.isLoading, error: query.error };
}
