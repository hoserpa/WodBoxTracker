import { ref } from "vue";
import { toValue } from "vue";
import { exerciseDetailService } from "@/services/exerciseDetail";

export function useExerciseDetail(id) {
  const data = ref(null);
  const isLoading = ref(true);
  const error = ref(null);

  const load = async () => {
    try {
      isLoading.value = true;
      error.value = null;
      const val = toValue(id);
      if (!val) return;
      data.value = await exerciseDetailService.getById(val);
    } catch (err) {
      error.value = err;
    } finally {
      isLoading.value = false;
    }
  };

  load();
  return { data, isLoading, error };
}
