require_relative "../helpers/presenter"

module Handler
  def search
    word = input_user
    print "searching #{word}...\r"
    word_data = vocabulary_word(word)
    word_in_array = format_rows(word_data)
    print_definition(word_data[:word], word_in_array)
    @new_vocabulary_words << word_data
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

  def practice
    option = practice_menu
    until option == "back"
      start_practice(option)
      option = practice_menu
    end
  end

  def toggle
    language = @current_language
    @current_language = (language == "en_US" ? "es" : "en_US")
  end

  def start_practice(practice_type)
    print "loading questions...\r"
    questions = generate_questions(practice_type)
    puts "Please select each correct answer by it's number:"

    score = 0
    questions.each do |question|
      answer = ask_question(question)
      result = print_result(question[:correct_answer], answer)
      score += 10 if result
    end

    puts "Well done! Your score is #{score}" if score.positive?
    puts "No problem, you can try again. Your score is 0" if score.zero?
  end
end
