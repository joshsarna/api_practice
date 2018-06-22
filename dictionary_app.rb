require 'unirest'
require './../api_key/api_key.rb'
variable = Api.new
api_key = variable.temp_api_key

condition = true
while condition == true

  # ask user for a word
  puts "What word would you like to learn? Type 'q' to exit this dictionary."
  word = gets.chomp

  if word == "q"
    condition = false
  else
    # get a result and find definition data within the result
    definition_response = Unirest.get("https://api.wordnik.com/v4/word.json/#{word}/definitions?limit=200&includeRelated=false&useCanonical=false&includeTags=false&api_key=#{api_key}")
    definitions_array = definition_response.body
    definitions = ""
    count = 0
    definitions_array.each do |definition|
      definitions << "#{count + 1}) " + definition["text"] + "\n"
      count += 1
    end

    # get a result and find pronunciation data within the result
    pronunciation_response = Unirest.get("https://api.wordnik.com/v4/word.json/#{word}/pronunciations?useCanonical=false&limit=50&api_key=#{api_key}")
    pronunciation = pronunciation_response.body[0]["raw"]

    # get a result and find example data within the result
    example_response = Unirest.get("https://api.wordnik.com/v4/word.json/#{word}/topExample?useCanonical=false&api_key=#{api_key}")
    example = example_response.body["text"]

    # print out a sentence with the desired information
    if count == 1
      puts "The definition of #{word} is: #{definitions}It is pronounced #{pronunciation}. An example sentence containing this word is: '#{example}.'"
    else
      puts "#{word.capitalize} can mean:\n#{definitions}\nIt is pronounced #{pronunciation}. An example sentence containing this word is: '#{example}.'"
    end
  end

end