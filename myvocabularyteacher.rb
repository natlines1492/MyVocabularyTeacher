require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/dictionary"

class Vocabulary
  include Presenter
  include Requester

  def initialize
    @vocabulary_list = ""
  end

  def start
    puts welcome
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
    variable = DictionaryService.words("en_US", word) # "en_US" = language
    meanings = variable[0][:meanings]

    def_uses = meanings.map do |part_of_speech|
      { 
        :uses => part_of_speech[:partOfSpeech], 
        :definitions => part_of_speech[:definitions].map do |definitions|
          { 
            :definition => definitions[:definition],
            :example => definitions[:example]
          } 
        end
      }
    end

    @def_uses = def_uses
  end
end

vocabulary = Vocabulary.new
vocabulary.start
