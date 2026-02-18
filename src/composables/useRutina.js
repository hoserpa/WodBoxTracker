import { useQuery, useMutation, useQueryClient } from "@tanstack/vue-query";
import { rutinaService } from "@/services/rutina";

const QUERY_KEY = ["rutinas"];

export function useRutinas() {
  return useQuery({
    queryKey: QUERY_KEY,
    queryFn: () => rutinaService.getAll(),
  });
}

export function useRutina(id) {
  return useQuery({
    queryKey: ["rutina", id],
    queryFn: () => rutinaService.getById(id),
    enabled: !!id,
  });
}

export function useCreateRutina() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data) => rutinaService.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: QUERY_KEY });
    },
  });
}

export function useUpdateRutina() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: ({ id, data }) => rutinaService.update(id, data),
    onSuccess: (data) => {
      queryClient.invalidateQueries({ queryKey: QUERY_KEY });
      queryClient.invalidateQueries({ queryKey: ["rutina", data.id] });
    },
  });
}

export function useDeleteRutina() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (id) => rutinaService.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: QUERY_KEY });
    },
  });
}
