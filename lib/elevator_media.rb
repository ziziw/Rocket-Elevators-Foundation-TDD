require 'faraday'
require 'json'

module ElevatorMedia
    class Streamer
        def self.getContent()
            joke = get_joke()
            formatted_joke = format_div(joke)
            return formatted_joke
        end

        def self.api_call()
            res = Faraday.get("https://api.yomomma.info/")
        end

        def self.get_joke()
            res = api_call()
            json = JSON.parse(res.body)
            joke = json['joke']
            joke
        end

        def self.is_json?(json)
            JSON.parse(json)
            return true
          rescue JSON::ParserError => e
            return false
        end

        def self.format_div(text)
            "<div>#{text}</div>"
        end
    end
end