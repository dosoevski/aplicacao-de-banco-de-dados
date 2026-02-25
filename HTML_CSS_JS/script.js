const searchBtn = document.getElementById('searchBtn');
const cityInput = document.getElementById('cityInput');

searchBtn.addEventListener('click', () => {
    const cityName = cityInput.value;
    if (cityName) {
        getCoordinates(cityName);
    } else {
        alert("Por favor, digite o nome de uma cidade.");
    }
});

async function getCoordinates(city) {
    const geoURL = `https://geocoding-api.open-meteo.com/v1/search?name=${city}&count=1&language=pt&format=json`;
    
    try {
        const response = await fetch(geoURL);
        const data = await response.json();
        
        if (!data.results) {
            alert("Cidade não encontrada!");
            return;
        }

        const { latitude, longitude, name } = data.results[0];
        
        const display = document.getElementById('displayCityName');
        if(display) display.innerText = name;
        
       
        fetchWeatherData(latitude, longitude);
        
    } catch (error) {
        console.error("Erro na geocodificação:", error);
    }
}


async function fetchWeatherData(lat, lon) {
   
    const weatherURL = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true`;

    try {
        const response = await fetch(weatherURL);
        const data = await response.json();
        
        const temp = data.current_weather.temperature;
        const code = data.current_weather.weathercode; // O código da condição

   
        const weatherMap = {
            0: "Céu limpo ☀️",
            1: "Principalmente limpo 🌤️",
            2: "Parcialmente nublado ⛅",
            3: "Encoberto ☁️",
            45: "Neblina 🌫️",
            51: "Chuvisco 🌧️",
            61: "Chuva leve 🌧️",
            80: "Pancadas de chuva 🌦️",
            95: "Trovoada ⛈️"
        };

      
        document.getElementById('temperature').innerText = `Temperatura: ${temp}°C`;
        document.getElementById('condition').innerText = `Condição: ${weatherMap[code] || "Desconhecida"}`;
        
    } catch (error) {
        console.error("Erro ao buscar clima:", error);
    }
}