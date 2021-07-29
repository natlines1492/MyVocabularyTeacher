require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/dictionary"

class Vocabulary
  include Presenter
  include Requester

  def initialize(word, language = "en_US")
    @vocabulary_list = ""
    @current_language = language
    @search_word = word
    @definition_word = nil
  end

  def start
    puts welcome
    puts "language: #{@current_language}"
    start_search(@current_language, @search_word)
    option = main_menu
    until option == "exit"
      case option
      when "search" then search
      when "add" then puts "add option"
      when "practice" then puts "practice option"
      when "toggle" then puts "toggle option"
      when "exit" then puts "exit option"
      end
      option = main_menu
    end
  end

  def search
    word = input_user
    variable = DictionaryService.words(@current_language, word) # "en_US" = language
    meanings = variable[0][:meanings]

    definition_word = meanings.map do |part_of_speech|
      {
        uses: part_of_speech[:partOfSpeech],
        definitions: part_of_speech[:definitions].map do |definitions|
          {
            definition: definitions[:definition],
            example: definitions[:example]
          }
        end
      }
    end

    @definition_word = definition_word
    pp definition_word
  end

  def start_search(language, word)
    variable = DictionaryService.words(language, word) # "en_US" = language
    meanings = variable[0][:meanings]

    definition_word = meanings.map do |part_of_speech|
      {
        uses: part_of_speech[:partOfSpeech],
        definitions: part_of_speech[:definitions].map do |definitions|
          {
            definition: definitions[:definition],
            example: definitions[:example]
          }
        end
      }
    end

    @definition_word = definition_word
    pp definition_word
  end
end

input_array = ARGV
word = input_array.first
language = nil
language = input_array[-1] if input_array.length > 1
# puts "language: #{language}"
# puts "word : #{word}"

if language.nil?
  vocabulary = Vocabulary.new(word)
else
  vocabulary = Vocabulary.new(word, language) unless language.nil?
end
vocabulary.start
