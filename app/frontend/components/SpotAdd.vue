<template>
  <div class="container mx-auto p-4">
    <div id="map" class="mb-4 h-[500px] w-full"></div>

    <form @submit.prevent="addSpot" class="space-y-4">
      <div>
        <label class="mb-2 block">Spot Name</label>
        <input
          v-model="spotName"
          type="text"
          class="w-full rounded-lg border px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
          required
        />
      </div>

      <div>
        <label class="mb-2 block">Description</label>
        <textarea
          v-model="spotDescription"
          class="w-full rounded-lg border px-3 py-2 focus:outline-none focus:ring-2 focus:ring-blue-500"
          rows="4"
          required
        ></textarea>
      </div>

      <div>
        <label class="mb-2 block">Images</label>
        <input
          type="file"
          @change="handleFileUpload"
          multiple
          accept="image/*"
          class="w-full rounded-lg border px-3 py-2"
        />
      </div>

      <button
        type="submit"
        class="w-full rounded-lg bg-green-500 py-2 text-white transition hover:bg-green-600"
      >
        Add Spot
      </button>
    </form>
  </div>
</template>

<script>
export default {
  data() {
    return {
      map: null,
      marker: null,
      spotName: "",
      spotDescription: "",
      selectedFiles: [],
      selectedLocation: null,
    };
  },
  mounted() {
    this.initMap();
  },
  methods: {
    initMap() {
      const apiKey = import.meta.env.VITE_GOOGLE_MAPS_API_KEY;
      if (!window.google) {
        const script = document.createElement("script");
        script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&libraries=places`;
        script.async = true;
        script.defer = true;
        script.onload = () => this.createMap();
        document.head.appendChild(script);
      } else {
        this.createMap();
      }
    },
    createMap() {
      this.map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 35.6762, lng: 139.6503 }, // Default to Tokyo
        zoom: 12,
      });

      this.map.addListener("click", (event) => {
        this.placeMarker(event.latLng);
      });
    },
    placeMarker(location) {
      if (this.marker) {
        this.marker.setMap(null);
      }
      this.marker = new google.maps.Marker({
        position: location,
        map: this.map,
      });
      this.selectedLocation = {
        lat: location.lat(),
        lng: location.lng(),
      };
    },
    handleFileUpload(event) {
      this.selectedFiles = Array.from(event.target.files);
    },
    async addSpot() {
      if (!this.selectedLocation) {
        alert("Please select a location on the map");
        return;
      }

      const formData = new FormData();
      formData.append("spot[name]", this.spotName);
      formData.append("spot[description]", this.spotDescription);
      formData.append("spot[latitude]", this.selectedLocation.lat);
      formData.append("spot[longitude]", this.selectedLocation.lng);

      this.selectedFiles.forEach((file, index) => {
        formData.append(`spot[images][]`, file);
      });

      try {
        const response = await fetch("/spots", {
          method: "POST",
          body: formData,
        });

        if (response.ok) {
          alert("Spot added successfully!");
          this.resetForm();
        } else {
          const errorData = await response.json();
          alert(`Error: ${errorData.message}`);
        }
      } catch (error) {
        console.error("Error:", error);
        alert("Failed to add spot");
      }
    },
    resetForm() {
      this.spotName = "";
      this.spotDescription = "";
      this.selectedFiles = [];
      this.selectedLocation = null;
      if (this.marker) {
        this.marker.setMap(null);
      }
    },
  },
};
</script>
