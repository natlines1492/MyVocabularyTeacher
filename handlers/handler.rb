require_relative "../helpers/presenter"

module Handler
  def vocabulary_word(input)
    print "searching #{input}...\r"
    word = DictionaryService.words(@current_language, input)[0]
    word_data = {}
    word_data[:word] = word[:word]
    word_data[:definitions] = []

    word[:meanings].each do |meaning|
      definition = {
        uses: meaning[:partOfSpeech],
        definition: meaning[:definitions][0][:definition],
        example: meaning[:definitions][0][:example]
      }
      word_data[:definitions] << definition
    end

    word_in_array = format_rows(word_data)
    print_definition(word_data[:word], word_in_array)
    @new_vocabulary_words << word_data
  end

  def format_rows(word_data)
    word_rows = []
    word_rows << [word_data[:word], nil]

    word_data[:definitions].each do |definition|
      word_rows << ["uses", definition[:uses]]
      word_rows << ["definition", definition[:definition]]
      word_rows << ["example", definition[:example]]
    end

    word_rows
  end

  def search
    word = input_user
    vocabulary_word(word)
  end

  def add
    return puts "Nothing to add for the moment. Try searching some words" if @new_vocabulary_words.empty?

    print_new_vocabulary_words
    option = add_menu
    until option == "back"
      case option
      when "save" then puts "save"
      when "delete" then puts "delete"
      end
      option = add_menu
    end
  end

  def toggle
    language = @current_language
    @current_language = (language == "en_US" ? "es" : "en_US")
  end
end
