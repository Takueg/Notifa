import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        const popup = new mapboxgl.Popup().setHTML(marker.info_window);
        const element = document.createElement('div');
        element.className = 'price-tag'
        element.innerHTML = marker.post.price;
        new mapboxgl.Marker(element)
          .setLngLat([ marker.lng, marker.lat ])
          .setPopup(popup)
          .addTo(map);
      });

    fitMapToMarkers(map, markers);
  }
};

export { initMapbox };

// markers.forEach( => {
//       const element = document.createElement('div');
//       element.innerHTML = post.price;
//       element.style.width = '40px';
//       element.style.height = '40px';
//       new mapboxgl.Marker(element)
//         .setLngLat([post.lng, post.lat])
//         .setPopup(popup)
//         .addTo(map);
//     });
