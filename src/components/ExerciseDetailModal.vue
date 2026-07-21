<script setup>
import { computed } from "vue";
import { useExerciseDetail } from "@/composables/useExerciseDetail";

const props = defineProps({
  exerciseDetailId: { type: String, required: true },
});

const emit = defineEmits(["close"]);

const { data: detail, isLoading, error } = useExerciseDetail(
  () => props.exerciseDetailId,
);

const hasGif = computed(() => detail.value?.gif_url);
const hasImage = computed(() => detail.value?.image && !hasGif.value);

const secondaryMuscles = computed(() => {
  if (!detail.value?.secondary_muscles) return [];
  if (Array.isArray(detail.value.secondary_muscles))
    return detail.value.secondary_muscles;
  try {
    return JSON.parse(detail.value.secondary_muscles);
  } catch {
    return [];
  }
});
</script>

<template>
  <Teleport to="body">
    <div
      class="fixed inset-0 z-50 flex items-center justify-center p-4"
      @click.self="emit('close')"
    >
      <div
        class="absolute inset-0 bg-black/60 backdrop-blur-sm"
        @click="emit('close')"
      ></div>

      <div
        class="relative w-full max-w-lg max-h-[85vh] overflow-y-auto rounded-2xl bg-gray-900/95 backdrop-blur-xl border border-white/10 p-6 shadow-2xl"
      >
        <div v-if="isLoading" class="flex justify-center py-12">
          <div
            class="animate-spin rounded-full h-10 w-10 border-4 border-violet-500 border-t-transparent"
          ></div>
        </div>

        <div
          v-else-if="error"
          class="text-red-400 text-center py-8"
        >
          No se pudieron cargar los detalles del ejercicio.
        </div>

        <template v-else-if="detail">
          <div class="flex items-start justify-between mb-4">
            <h3 class="text-xl font-bold text-white pr-4">
              {{ detail.name }}
            </h3>
            <button
              @click="emit('close')"
              class="shrink-0 text-white/50 hover:text-white transition-colors"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="h-6 w-6"
                fill="none"
                viewBox="0 0 24 24"
                stroke="currentColor"
              >
                <path
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  stroke-width="2"
                  d="M6 18L18 6M6 6l12 12"
                />
              </svg>
            </button>
          </div>

          <div
            v-if="hasGif || hasImage"
            class="mb-4 rounded-xl overflow-hidden bg-black/30"
          >
            <img
              v-if="hasGif"
              :src="detail.gif_url"
              :alt="detail.name"
              class="w-full h-auto object-contain"
            />
            <img
              v-else-if="hasImage"
              :src="detail.image"
              :alt="detail.name"
              class="w-full h-auto object-contain"
            />
          </div>

          <div class="flex flex-wrap gap-2 mb-4">
            <span
              class="px-3 py-1 rounded-full text-xs font-medium bg-violet-500/20 text-violet-300 border border-violet-500/30"
            >
              {{ detail.category }}
            </span>
            <span
              class="px-3 py-1 rounded-full text-xs font-medium bg-cyan-500/20 text-cyan-300 border border-cyan-500/30"
            >
              {{ detail.equipment }}
            </span>
            <span
              class="px-3 py-1 rounded-full text-xs font-medium bg-amber-500/20 text-amber-300 border border-amber-500/30"
            >
              {{ detail.target }}
            </span>
          </div>

          <div class="space-y-3">
            <div>
              <h4 class="text-sm font-semibold text-white/70 uppercase tracking-wider mb-1">
                Instrucciones
              </h4>
              <p class="text-white/80 text-sm leading-relaxed">
                {{ detail.instructions_es || detail.instructions_en }}
              </p>
            </div>

            <div>
              <h4 class="text-sm font-semibold text-white/70 uppercase tracking-wider mb-1">
                Músculos
              </h4>
              <div class="flex flex-wrap gap-1.5">
                <span
                  class="px-2.5 py-1 rounded-lg text-xs bg-white/10 text-white/70"
                >
                  {{ detail.muscle_group }}
                </span>
                <span
                  v-for="muscle in secondaryMuscles"
                  :key="muscle"
                  class="px-2.5 py-1 rounded-lg text-xs bg-white/10 text-white/50"
                >
                  {{ muscle }}
                </span>
              </div>
            </div>
          </div>
        </template>
      </div>
    </div>
  </Teleport>
</template>
