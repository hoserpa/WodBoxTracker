import { useQuery } from "@tanstack/vue-query";
import { toValue } from "vue";
import { exerciseDetailService } from "@/services/exerciseDetail";

export function useExerciseDetail(id) {
  return useQuery({
    queryKey: ["exerciseDetail", toValue(id)],
    queryFn: () => exerciseDetailService.getById(toValue(id)),
    enabled: () => !!toValue(id),
  });
}
