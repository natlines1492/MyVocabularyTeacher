require "csv"
require "nokogiri"
require "open-uri"
require "terminal-table"
require_relative "./handlers/handler"
require_relative "./handlers/words"
require_relative "./helpers/presenter"
require_relative "./helpers/requester"
require_relative "./services/dictionary"

class Vocabulary
  include Handler
  include Presenter
  include Requester
  include Handler::Words

  def initialize
    # @current_language = "en_US"
    @search_words = ARGV.select { |word| word.match?(/\w+/) }
    @vocabulary_list = []
    @new_vocabulary_words = []
    @dictionary = Scrapper::Dictionary.new
    @filename = nil

    # unless ARGV.empty?
    #   if ARGV[-1].match?(/english|spanish/i)
    #     @current_language = "es" if ARGV[-1].casecmp?("spanish")
    #     @search_words = ARGV[0..-2]
    #   else
    #     @search_words = ARGV.select { |word| word.match?(/\w+/) }
    #   end
    # end
    ARGV.clear
  end

  def start
    puts welcome
    # puts "language: #{@current_language}"
    start_search(@search_words) unless @search_words.empty?
    option = main_menu
    until option == "exit"
      case option
      when "search" then search
      when "add" then add
      when "practice" then practice
      when "toggle" then toggle
      end
      # puts "language: #{@current_language}"
      option = main_menu
    end
    puts goodbye
  end

  private

  def start_search(words)
    words.each do |word|
      print "searching #{word}...\r"
      word_data = @dictionary.look_up(word)
      next unless word_data

      word_in_array = format_rows(word_data)
      print_definition(word_data[:word], word_in_array)
      @new_vocabulary_words << word_data
    end
  end
end

vocabulary = Vocabulary.new
vocabulary.start
