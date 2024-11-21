<template>
  <div class="container mx-auto p-4">
    <h1 class="mb-4 text-2xl font-bold">Spots</h1>
    <div v-if="loading" class="text-center">Loading...</div>
    <div v-else-if="spots.length === 0" class="text-center">No spots found</div>
    <div v-else class="grid grid-cols-1 gap-4 md:grid-cols-2 lg:grid-cols-3">
      <div
        v-for="spot in spots"
        :key="spot.id"
        class="rounded-lg border p-4 shadow-md transition hover:shadow-lg"
      >
        <div v-if="spot.images && spot.images.length > 0" class="mb-4">
          <img
            :src="spot.images[0].url"
            :alt="spot.name"
            class="h-48 w-full rounded-lg object-cover"
          />
        </div>
        <h2 class="mb-2 text-xl font-semibold">{{ spot.name }}</h2>
        <p class="mb-2 text-gray-600">{{ spot.description }}</p>
        <div class="flex items-center justify-between">
          <span class="text-sm text-gray-500">
            Lat: {{ spot.latitude.toFixed(4) }}, Lng:
            {{ spot.longitude.toFixed(4) }}
          </span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      spots: [],
      loading: true,
    };
  },
  mounted() {
    this.fetchSpots();
  },
  methods: {
    async fetchSpots() {
      try {
        const response = await fetch("/spots");
        const data = await response.json();
        this.spots = data;
        this.loading = false;
      } catch (error) {
        console.error("Error fetching spots:", error);
        this.loading = false;
      }
    },
  },
};
</script>
