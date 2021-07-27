<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    html, body {
        height: 100%;
        width: 100%;
        
      }
      #map {
        height: 80%;
        width: 80%;
        display: flex;
        justify-content: center;

      }
</style>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAslkjoKdTG8kP9v47BpOssCN7VQ20oAFE&callback=initMap" async defer></script>
</head>
<body>


<div><h3>Let's Show All So Easy Maps</h3></div>   
<div id="map"></div>  


<script>
var map;
var markers = [];
var position = [
  {label:'1',lat:25.038644735174145,lng:121.51948345530062}, 
  {label:'2',lat:25.0390672564532,lng:121.509871283183},
  {label:'3',lat:25.0476608,lng:121.5067638},
  {label:'4',lat:25.02207361,lng:121.5067318},
  {label:'5',lat:25.02207361,lng:121.5067318},
  {label:'6',lat:25.02082072,lng:121.54574},
  {label:'7',lat:25.02289828,lng:121.5356686},
  {label:'8',lat:25.03121642,lng:121.5355627},
  {label:'9',lat:25.0247905,lng:121.5462804},
  {label:'10',lat:25.01342204,lng:121.540205},
  {label:'11',lat:24.99736765,lng:121.5592647},
  {label:'12',lat:24.98715283,lng:121.5604168},
  {label:'13',lat:24.99024539,lng:121.5598142},
  {label:'14',lat:25.03187456,lng:121.5667817},
  {label:'15',lat:25.02613813,lng:121.5704288},
  {label:'16',lat:25.02597036,lng:121.5616911},
  {label:'17',lat:25.02598008,lng:121.5616911},
  {label:'18',lat:25.04905532,lng:121.5817973},
  {label:'19',lat:25.04296751,lng:121.6178838},
  {label:'20',lat:25.04296401,lng:121.5848328},
  {label:'21',lat:25.05534678,lng:121.6036616},
  {label:'22',lat:25.0471241,lng:121.6139101},
  {label:'23',lat:25.08957743,lng:121.52149},
  {label:'24',lat:25.09254198,lng:121.5172493},
  {label:'25',lat:25.11342948,lng:121.5330396},
  {label:'26',lat:25.10809268,lng:121.5219103},
  {label:'27',lat:25.08612179,lng:121.5211944},
  {label:'28',lat:25.11087685,lng:121.5315604},
  {label:'29',lat:25.11666747,lng:121.5097726},
  {label:'30',lat:25.13658619,lng:121.5012822},
  {label:'31',lat:25.05512275,lng:121.5213503},
  {label:'33',lat:25.07043091,lng:121.5287224},
  {label:'34',lat:25.06512496,lng:121.5161826},
  {label:'35',lat:25.04993147,lng:121.5138007},
  {label:'36',lat:25.07372866,lng:121.510443},
  {label:'37',lat:25.05818368,lng:121.5155188},
  {label:'38',lat:25.04880138,lng:121.5503383},
  {label:'39',lat:25.0613648,lng:121.5664167},
  {label:'40',lat:25.05156091,lng:121.5508591},
  {label:'41',lat:25.0498979,lng:121.5524425},
  {label:'42',lat:25.07837987,lng:121.5750078},
  {label:'43',lat:25.08293651,lng:121.5829353},
  {label:'44',lat:25.06661251,lng:121.574362},
  {label:'45',lat:25.06244523,lng:121.6045965},
  {label:'46',lat:25.02290242,lng:121.4577281},
  {label:'47',lat:24.99325477,lng:121.4874544},
  {label:'49',lat:25.04000848,lng:121.4483854},
  {label:'50',lat:25.02044232,lng:121.4336521},
  {label:'51',lat:25.02362075,lng:121.4440153},
  {label:'52',lat:25.02632434,lng:121.4240012},
  {label:'53',lat:25.04163099,lng:121.4464303},
  {label:'54',lat:25.04077787,lng:121.4518275},
  {label:'55',lat:25.18757548,lng:121.4428718},
  {label:'56',lat:25.05474423,lng:121.4879564},
  {label:'57',lat:25.06156203,lng:121.4862319},
  {label:'58',lat:25.088398,lng:121.4903423},
  {label:'59',lat:25.05993588,lng:121.4809068},
  {label:'60',lat:25.09531313,lng:121.4484301},
  {label:'61',lat:25.08658865,lng:121.3805174},
  {label:'62',lat:25.07810922,lng:121.3691106},
  {label:'63',lat:25.06823069,lng:121.3997148},
  {label:'64',lat:25.09133104,lng:121.462328},
  {label:'65',lat:24.98572468,lng:121.4571864},
  {label:'66',lat:25.00344901,lng:121.5244646},
  {label:'67',lat:25.01098334,lng:121.508727},
  {label:'68',lat:24.96740109,lng:121.5424829}

];

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: {
      lat: 25.04993147,
      lng: 121.5138007     
    }
  });

  for (var i = 0; i < position.length; i++) {
    addMarker(i);
  }
}

function addMarker(e) {
  markers[e] = new google.maps.Marker({
    position: {
      lat: position[e].lat,
      lng: position[e].lng
    },
    map: map,
    animation: google.maps.Animation.BOUNCE,
    // label: 'SoEasy',
    label: position[e].label,
    icon:'images/Vege.jpg'
  });
}

</script>

</body>
</html>