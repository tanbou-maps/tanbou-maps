<template>
  <div class="mx-auto max-w-4xl">
    <div class="mb-4">
      <input
        type="text"
        v-model="searchQuery"
        @keyup.enter="handleSearch"
        placeholder="場所を検索..."
        class="w-full rounded-lg border px-4 py-2 shadow-sm focus:border-blue-500 focus:ring-2 focus:ring-blue-500"
      />
    </div>

    <div ref="mapContainer" class="h-96 w-full rounded-lg shadow-lg"></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const searchQuery = ref("");
const mapContainer = ref(null);
const map = ref(null);
const marker = ref(null);

// Google Maps の初期化
const initMap = () => {
  const defaultLocation = { lat: 35.6812362, lng: 139.7671248 }; // 東京駅

  map.value = new google.maps.Map(mapContainer.value, {
    zoom: 15,
    center: defaultLocation,
  });

  marker.value = new google.maps.Marker({
    map: map.value,
    position: defaultLocation,
  });
};

// 検索処理
const handleSearch = async () => {
  if (!searchQuery.value) return;

  const geocoder = new google.maps.Geocoder();

  try {
    const { results } = await new Promise((resolve, reject) => {
      geocoder.geocode({ address: searchQuery.value }, (results, status) => {
        if (status === "OK") {
          resolve({ results });
        } else {
          reject(new Error("Geocoding failed"));
        }
      });
    });

    const location = results[0].geometry.location;

    map.value.setCenter(location);
    marker.value.setPosition(location);
  } catch (error) {
    console.error("検索エラー:", error);
    alert("場所の検索に失敗しました");
  }
};

onMounted(() => {
  // Google Maps APIの読み込み
  const script = document.createElement("script");
  script.src = `https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY`;
  script.async = true;
  script.defer = true;
  script.onload = initMap;
  document.head.appendChild(script);
});
</script>
