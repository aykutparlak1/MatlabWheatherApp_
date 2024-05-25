function weathers = getWeathersForFiveDay(city, api)
    baseUrl = 'http://api.openweathermap.org/data/2.5/forecast';
    getUrl = sprintf('%s?q=%s&appid=%s&units=metric', baseUrl, city, api);
    
    % Web options to manage read operations
    options = weboptions('ContentType', 'json', 'Timeout', 20);
    try
        gettedData = webread(getUrl, options);
    catch ME
        % If there is an error, show an error message
        errorMessage = sprintf('Error accessing API:\n%s', ME.message);
        errordlg(errorMessage, 'API Access Error', 'modal');
        weathers = []; % Return an empty value or handle the error as needed
        return;
    end
    
    % Initialize weather structure
    weathers.time = {};
    weathers.temp = [];
    weathers.humidity = [];
    weathers.windSpeed = [];
    
    for i = 1:length(gettedData.list)
        forecast = gettedData.list{i};

        % Convert dt_txt to datetime format
        dt = datetime(forecast.dt_txt, 'InputFormat', 'yyyy-MM-dd HH:mm:ss');
        
        % Store data in the structure
        weathers.time{end+1} = dt;
        weathers.temp(end+1) = forecast.main.temp;
        weathers.humidity(end+1) = forecast.main.humidity;
        weathers.windSpeed(end+1) = forecast.wind.speed;
    end
end
