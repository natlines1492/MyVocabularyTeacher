require_relative "../helpers/presenter"
require_relative "../services/store"

module Handler
  def search
    input = input_user
    return if input[0] == "--back" && input[1].nil?

    input.each do |word|
      puts "\n"
      print "searching #{word}...\r"
      word_data = @dictionary.look_up(word)
      next unless word_data

      word_in_array = format_rows(word_data)
      print_definition(word_data[:word], word_in_array)
      @new_vocabulary_words << word_data unless @vocabulary_list.include?(word_data)
    end
  end

  def add
    return puts "Nothing to add. Try searching some words" if @new_vocabulary_words.empty?

    print_new_vocabulary_words
    option = add_menu
    until option == "back"
      case option
      when "save" then save_vocabulary(@filename)
      when "delete" then delete_from_new_words
      end
      option = add_menu
    end
  end

  def practice
    option = practice_menu
    until option == "back"
      puts "\n"
      start_practice
      puts "\n"
      option = practice_menu
    end
  end

  # This will be used once multilanguage searches are available
  # def toggle
  #   language = @current_language
  #   @current_language = (language == "en_US" ? "es" : "en_US")
  # end

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
    puts "\n"
    puts "Do you want to save the new words in your vocabulary?"
    save_confirmation = ask_save_menu
    save_after_practice(questions) if save_confirmation == "yes"
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

  def save_after_practice(questions)
    new_words_to_add = questions.select { |question| question[:new] }
    new_words_to_add.each do |word|
      @new_vocabulary_words << word[:data]
    end
    save_vocabulary(@filename)
  end

  def delete_from_new_words
    ids = input_for_deletion
    @new_vocabulary_words.reject!.with_index do |_word, idx|
      ids.map(&:to_i).include?(idx + 1)
    end
    print_new_vocabulary_words
  end
end
