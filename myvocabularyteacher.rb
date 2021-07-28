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
    # pp variable = DictionaryService.words("en_US", "Hello")
    # word = variable[0]
    # puts "-----------------"exit
    # pp word[:word]
    # puts "-----------------"
    # meaning =  word[:meanings][0][:definitions][0][:definition]
    # puts "-----------------"
    # pp meaning[:definitions][0][:definition]
  end
end

vocabulary = Vocabulary.new
vocabulary.start
