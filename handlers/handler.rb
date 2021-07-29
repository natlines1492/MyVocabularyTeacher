require_relative "../helpers/presenter"

module Handler
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
