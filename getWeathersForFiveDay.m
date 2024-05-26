function weathers = getWeathersForFiveDay(city, api)
    baseUrl = 'http://api.openweathermap.org/data/2.5/forecast';
    getUrl = sprintf('%s?q=%s&appid=%s&units=metric', baseUrl, city, api);
    options = weboptions('ContentType', 'json', 'Timeout', 20);
    gettedData = webread(getUrl, options);
    weathers.time = {};
    weathers.temp = [];
    weathers.humidity = [];
    weathers.windSpeed = [];
    for i = 1:length(gettedData.list)
        forecast = gettedData.list{i};
        dt = datetime(forecast.dt_txt, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
        weathers.time{end+1} = dt;
        weathers.temp(end+1) = forecast.main.temp;
        weathers.humidity(end+1) = forecast.main.humidity;
        weathers.windSpeed(end+1) = forecast.wind.speed;
    end
end
