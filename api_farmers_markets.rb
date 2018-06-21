require 'unirest'
variable = Unirest.get("https://data.ny.gov/resource/xjya-f8ng.json")
puts JSON.pretty_generate(variable.body)