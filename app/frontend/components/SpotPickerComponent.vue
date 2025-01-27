<template>
  <div class="space-y-4">
    <input
      type="text"
      v-model="searchQuery"
      @keyup.enter="handleSearch"
      placeholder="場所を検索..."
      class="w-full rounded-md border border-gray-300 px-3 py-2 shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
    />

    <div
      ref="mapContainer"
      class="h-64 w-full rounded-lg border border-gray-200 shadow-md"
    ></div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

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
  const apiKey = document.getElementById("spot-picker-component").dataset
    .googleMapsApiKey;

  // Google Maps API の読み込み
  const script = document.createElement("script");
  script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=Function.prototype&loading=async`;
  script.async = true;
  script.defer = true;

  // スクリプトの読み込み完了後にマップを初期化
  script.onload = () => {
    // APIが完全に読み込まれるまで少し待つ
    setTimeout(initMap, 100);
  };

  document.head.appendChild(script);
});
</script>
