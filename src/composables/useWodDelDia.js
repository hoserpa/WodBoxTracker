import { ref } from "vue";
import { supabase } from "@/lib/supabase";

const CATALOGO_URL = `${import.meta.env.BASE_URL}data/wods.json`;

let catalogoPromise = null;

const cargarCatalogo = () => {
  catalogoPromise ??= fetch(CATALOGO_URL).then((res) => {
    if (!res.ok) throw new Error("No se pudo cargar el catálogo de WODs");
    return res.json();
  });
  return catalogoPromise;
};

export function useWodDelDia() {
  const wod = ref(null);
  const isLoading = ref(true);
  const error = ref(null);

  const load = async () => {
    try {
      isLoading.value = true;
      error.value = null;
      const [{ data, error: rpcError }, catalogo] = await Promise.all([
        supabase.rpc("obtener_wod_del_dia"),
        cargarCatalogo(),
      ]);
      if (rpcError) throw rpcError;
      const row = Array.isArray(data) ? data[0] : data;
      if (!row) throw new Error("El WOD del día no está disponible");
      const id = Number(row.wod_elegido);
      wod.value = catalogo.find((w) => w.id === id) ?? null;
    } catch (err) {
      error.value = err;
    } finally {
      isLoading.value = false;
    }
  };

  load();
  return { wod, isLoading, error };
}
