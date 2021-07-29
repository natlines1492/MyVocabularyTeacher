require_relative "./handlers/handler"
require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/dictionary"

class Vocabulary
  include Handler
  include Presenter
  include Requester

  def initialize
    @current_language = "en_US"
    @search_words = []
    @vocabulary_list = []
    @new_vocabulary_words = []

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
    start_search(@search_words) unless @search_words.empty?
    option = main_menu
    until option == "exit"
      case option
      when "search" then search
      when "add" then puts "add option"
      when "practice" then puts "practice option"
      when "toggle" then toggle
      end
      puts "language: #{@current_language}"
      option = main_menu
    end
    puts goodbye
  end

  def search
    word = input_user
    vocabulary_word(word)
  end

  def start_search(words)
    words.each do |word|
      vocabulary_word(word)
    end
  end

  def toggle
    language = @current_language
    @current_language = (language == "en_US" ? "es" : "en_US")
  end
end

vocabulary = Vocabulary.new
vocabulary.start
