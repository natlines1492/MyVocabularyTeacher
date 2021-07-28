require_relative "./helpers/presenter"
require_relative "./helpers/requester"


class Vocabulary
  include Presenter
  include Requester

  def initialize
    @vocabulary_list = ""
    @current_language = ""
    input_array = ARGV
    puts "word : #{input_array[0]}"
    puts "language: #{input_array[1]}"

  end

  def start
    puts welcome
    option = main_menu
    until option == "exit"
      case option
      when "search" then puts "search option"
      when "add" then puts "add option"
      when "practice" then puts "practice option"
      when "toggle" then puts "toggle option"
      when "exit" then puts "exit option"
      end
      option = main_menu
    end
  end
end

vocabulary = Vocabulary.new
vocabulary.start
