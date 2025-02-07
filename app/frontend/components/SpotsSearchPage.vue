<template>
  <div>
    <h1>Spots Search Page</h1>
    <div id="map" style="height: 500px; width: 100%"></div>
  </div>
</template>

<script>
export default {
  mounted() {
    this.initMap();
  },
  methods: {
    initMap() {
      const apiKey =
        document.getElementById("spots-search-page").dataset.googleMapsApiKey;
      const script = document.createElement("script");
      script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap`;
      script.async = true;
      script.defer = true;
      window.initMap = this.loadMap;
      document.head.appendChild(script);
    },
    loadMap() {
      const map = new google.maps.Map(document.getElementById("map"), {
        center: { lat: 35.6812362, lng: 139.7671248 }, // Default center (Tokyo Station)
        zoom: 10,
      });

      fetch("/spots/search.json")
        .then((response) => response.json())
        .then((spots) => {
          spots.forEach((spot) => {
            const marker = new google.maps.Marker({
              position: { lat: spot.latitude, lng: spot.longitude },
              map: map,
              title: spot.name,
            });

            const infoWindow = new google.maps.InfoWindow({
              content: `<h3>${spot.name}</h3><p>${spot.description}</p>`,
            });

            marker.addListener("click", () => {
              infoWindow.open(map, marker);
              console.log(`Marker clicked: ${spot.name}`); // Debugging line
            });
          });
        })
        .catch((error) => console.error("Error fetching spots:", error)); // Debugging line
    },
  },
};
</script>

<style scoped>
#map {
  height: 500px;
  width: 100%;
}
</style>
