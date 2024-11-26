<script>
document.addEventListener("DOMContentLoaded", function () {
  const mapElement = document.getElementById("spot-map");
  const apiKey = mapElement.dataset.googleMapsApiKey;
  const latitude = parseFloat(mapElement.dataset.latitude);
  const longitude = parseFloat(mapElement.dataset.longitude);

  const script = document.createElement("script");
  script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}&callback=initMap`;
  script.async = true;
  script.defer = true;

  window.initMap = function () {
    const map = new google.maps.Map(mapElement, {
      center: { lat: latitude, lng: longitude },
      zoom: 15,
      mapTypeControl: false,
      streetViewControl: false,
    });

    new google.maps.Marker({
      position: { lat: latitude, lng: longitude },
      map: map,
    });
  };

  document.head.appendChild(script);
});
</script>
