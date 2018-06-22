require 'unirest'

response = Unirest.get("https://data.ny.gov/resource/xjya-f8ng.json")
puts JSON.pretty_generate(response.body)