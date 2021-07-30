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

  def toggle
    language = @current_language
    @current_language = (language == "en_US" ? "es" : "en_US")
  end

  def random_word_for_game
    if @vocabulary_list.length <= 5
      RandomWord.adjs.next.split("_")[0]
    else
      @vocabulary_list.sample[:word]
    end
  end

  def make_question
    options = []
    random_word = random_word_for_game
    options << random_word
    size = random_word.size < 5 ? 5 : random_word.size
    3.times { options << match_options(random_word[0..1], size, random_word) }

    definition = Vocabulary.new.vocabulary_word(random_word)[:definitions].sample[:definition]
    puts "Select the correct word: #{definition}"

    options.shuffle.each_with_index do |option, index|
      puts "#{index + 1}. #{option}"
    end
  end

  def match_options(char_option, size, word_exclude)
    word = ""
    until word.start_with?(char_option) && word.size <= size && word != word_exclude
      begin
        word = RandomWord.adjs.next
      rescue NoMethodError
        retry
      end
    end
    word
  end

  def save_vocabulary(vocabulary)
    first_definitions = nth_group(vocabulary, 2)
    Store.save(first_definitions, filename)
  end

  def nth_group(arr, num_elements)
    new_arr = []
    count = 0
    condition = false
    arr.each do |element|
      if element[0] == "uses" # to be yield
        count = 0
        condition = true
      end
      next unless count <= num_elements && condition

      new_arr << element
      count += 1
      condition = false if count == num_elements
    end
    new_arr
  end
end
