<script setup>
import { useRouter } from "vue-router";

const props = defineProps({
  to: {
    type: String,
    default: null,
  },
  fallback: {
    type: Function,
    default: null,
  },
  variant: {
    type: String,
    default: "white",
  },
});

const router = useRouter();

const goBack = () => {
  if (props.fallback) {
    props.fallback();
    return;
  }
  if (props.to) {
    router.push(props.to);
    return;
  }
  router.back();
};
</script>

<template>
  <button
    @click="goBack"
    class="flex items-center gap-2 transition-colors"
    :class="
      variant === 'violet'
        ? 'text-violet-400 font-medium hover:text-violet-300'
        : 'text-white/60 hover:text-white'
    "
  >
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class="h-5 w-5"
      fill="none"
      viewBox="0 0 24 24"
      stroke="currentColor"
    >
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        stroke-width="2"
        d="M15 19l-7-7 7-7"
      />
    </svg>
    Volver
  </button>
</template>
