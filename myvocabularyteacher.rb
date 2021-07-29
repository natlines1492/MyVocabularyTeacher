require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/dictionary"

class Vocabulary
  include Presenter
  include Requester

  def initialize
    @current_language = "en_US"
    @search_words = []
    @vocabulary_list = []

    unless ARGV.empty?
      if ARGV[-1].match?(/english|spanish/i)
        @current_language = "es" if ARGV[-1].downcase == "spanish"
        @search_words = ARGV[0..-2]
      else
        @search_words = *ARGV
      end
    end
    ARGV.clear
  end

  def start
    puts welcome
    puts "language: #{@current_language}"
    start_search(@current_language, @search_words) unless @search_words.empty?
    option = main_menu
    until option == "exit"
      case option
      when "search" then search
      when "add" then puts "add option"
      when "practice" then puts "practice option"
      when "toggle" then toggle 
      when "exit" then puts "exit option"
      end
      puts "language: #{@current_language}"
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

    @vocabulary_list << { word.to_sym => definition_word }
    pp @vocabulary_list
  end

  def start_search(language, words)
    words.each do |word|
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

      @vocabulary_list << { word.to_sym => definition_word }
    end
    pp @vocabulary_list
  end

  def toggle
    language = @current_language
    @current_language = (language == "en_US" ? "es" : "en_US")
  end
end

vocabulary = Vocabulary.new
vocabulary.start
