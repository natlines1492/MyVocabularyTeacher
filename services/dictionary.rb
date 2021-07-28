require "httparty"
require "json"

class DictionaryService
  include HTTParty

  base_uri "https://api.dictionaryapi.dev/api/v2/entries"

  def self.words(language, word)
    definitions = get("/#{language}/#{word}")
    JSON.parse(definitions.body, symbolize_names: true) if definitions.body
  end
end
