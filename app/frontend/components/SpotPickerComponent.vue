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

    <div ref="mapContainer" class="mb-4 h-96 w-full rounded-lg shadow-lg"></div>

    <div v-if="selectedLocation" class="mb-4 rounded-lg bg-green-100 p-4">
      <p class="text-green-800">
        選択された位置：緯度 {{ selectedLocation.lat.toFixed(6) }}, 経度
        {{ selectedLocation.lng.toFixed(6) }}
      </p>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from "vue";

const searchQuery = ref("");
const mapContainer = ref(null);
const map = ref(null);
const marker = ref(null);
const selectedLocation = ref(null);

const initMap = () => {
  const defaultLocation = { lat: 35.6812362, lng: 139.7671248 }; // 東京駅

  map.value = new google.maps.Map(mapContainer.value, {
    zoom: 15,
    center: defaultLocation,
    mapTypeControl: false,
    streetViewControl: false,
  });

  marker.value = new google.maps.Marker({
    map: map.value,
    position: defaultLocation,
    draggable: true,
  });

  // マーカーのドラッグ終了時のイベント
  google.maps.event.addListener(marker.value, "dragend", () => {
    const position = marker.value.getPosition();
    selectedLocation.value = {
      lat: position.lat(),
      lng: position.lng(),
    };
    updateFormFields();
  });

  // マップのクリックイベント
  map.value.addListener("click", (event) => {
    marker.value.setPosition(event.latLng);
    selectedLocation.value = {
      lat: event.latLng.lat(),
      lng: event.latLng.lng(),
    };
    updateFormFields();
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

    selectedLocation.value = {
      lat: location.lat(),
      lng: location.lng(),
    };

    updateFormFields();
  } catch (error) {
    console.error("検索エラー:", error);
    alert("場所の検索に失敗しました");
  }
};

// フォームのフィールドを更新
const updateFormFields = () => {
  if (selectedLocation.value) {
    const latitudeInput = document.getElementById("spot_latitude");
    const longitudeInput = document.getElementById("spot_longitude");

    if (latitudeInput && longitudeInput) {
      latitudeInput.value = selectedLocation.value.lat;
      longitudeInput.value = selectedLocation.value.lng;
    }
  }
};

onMounted(() => {
  // DOM から API キーを取得
  const apiKey =
    document.getElementById("spot-map-picker").dataset.googleMapsApiKey;

  // Google Maps API の読み込み
  const script = document.createElement("script");
  script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=Function.prototype`;
  script.async = true;
  script.defer = true;

  // スクリプトの読み込み完了後にマップを初期化
  script.onload = () => {
    setTimeout(initMap, 100);
  };

  document.head.appendChild(script);
});
</script>
