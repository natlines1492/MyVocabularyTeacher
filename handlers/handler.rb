require_relative "../helpers/presenter"
require_relative "../services/store"

module Handler
  def search
    word = input_user
    print "searching #{word}...\r"
    word_data = @dictionary.look_up(word)
    return unless word_data

    word_in_array = format_rows(word_data)
    print_definition(word_data[:word], word_in_array)
    @new_vocabulary_words << word_data unless @vocabulary_list.include?(word_data)
  end

  def add
    return puts "Nothing to add for the moment. Try searching some words" if @new_vocabulary_words.empty?

    print_new_vocabulary_words
    option = add_menu
    until option == "back"
      case option
      when "save" then save_vocabulary(@filename)
      when "delete" then puts "delete"
      end
      option = add_menu
    end
  end

  def practice
    option = practice_menu
    until option == "back"
      start_practice
      option = practice_menu
    end
  end

  def toggle
    language = @current_language
    @current_language = (language == "en_US" ? "es" : "en_US")
  end

  def start_practice
    print "loading questions...\r"
    questions = generate_questions
    puts "Please select each correct answer by it's number:"

    score = 0
    questions.each do |question|
      answer = ask_question(question)
      result = print_result(question[:correct_answer], answer)
      score += 10 if result
    end

    puts "Well done! Your score is #{score}" if score.positive?
    puts "No problem, you can try again. Your score is 0" if score.zero?

    puts "Do you want to save the new words in your vocabulary?"
    puts "New words saved!" if ask_save_menu == "yes"
  end

  def update_vocabulary_list
    @new_vocabulary_words.each { |word| @vocabulary_list << word }
    @new_vocabulary_words.clear
    @vocabulary_list
  end

  def save_vocabulary(_filename)
    vocabulary_list = update_vocabulary_list
    formatted_vocabulary = vocabulary_list.map { |vocabulary| format_rows(vocabulary) }
    Store.save_csv(formatted_vocabulary)
    puts "Successfully saved!"
  end
end
