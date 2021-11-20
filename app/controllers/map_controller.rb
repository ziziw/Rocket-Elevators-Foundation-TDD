class MapController < ApplicationController
    def map_params
        params.permit(:building_id)
    end
    def load
        random_api = Array[ENV['WEATHER_API_1'], ENV['WEATHER_API_2'], ENV['WEATHER_API_3']]
        @building = Building.find(params[:building_id])
        nbColumns = 0
        nbElevators = 0
        nbFloors = 0
        
        @building.batteries.all.each do |battery|
            nbColumns = nbColumns + battery.columns.count
            battery.columns.all.each do |column|
                nbFloors = nbFloors + column.number_of_floors_served
                nbElevators = nbElevators + column.elevators.count
            end
        end
        random_num = rand(0..2)
        response = Faraday.get 'https://api.openweathermap.org/data/2.5/weather' do |req|
            req.params['APPID'] = random_api[random_num]
            req.params['lat'] = @building.address.latitude.to_f.round(2)
            req.params['lon'] = @building.address.longitude.to_f.round(2)
            req.params['units'] = 'metric'
        end
        body = JSON.parse(response.body)
        weatherTemp = body["main"]["temp"].to_json
        weatherStatus = body["weather"][0]["description"].to_json
        weatherHumidity = body["main"]["humidity"].to_json
        @buildingInfo = {
            'nbColumns' => nbColumns,
            'nbElevators' => nbElevators,
            'nbFloors' => nbFloors,
            'weatherTemp' => weatherTemp,
            'weatherStatus' => weatherStatus,
            'weatherHumidity' => weatherHumidity
        }
        
        render json: @buildingInfo
    end
    def show; end

end
