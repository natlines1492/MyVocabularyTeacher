module Requester
  def main_menu
    options = %w[search add practice exit]
    input_with_options(options)
  end

  def add_menu
    options = %w[save delete back]
    input_with_options(options)
  end

  def practice_menu
    options = %w[start back]
    input_with_options(options)
  end

  def ask_save_menu
    options = %w[yes no]
    input_with_options(options)
  end

  def input_with_options(options)
    puts options.join(" | ")
    print "> "
    input = gets.chomp.strip
    until options.include?(input)
      puts "Invalid option"
      print "> "
      input = gets.chomp.strip
    end
    input
  end

  def input_user
    puts "Please enter the word or words to be searched:"
    gets.chomp.split
  end

  def input_for_deletion
    puts "Please enter the id of the word or words to delete from the list:"
    num_of_new_words = @new_vocabulary_words.size
    range_by_size = ("1"..num_of_new_words.to_s).to_a
    input = gets.chomp.split
    until input.difference(range_by_size).size.zero?
      puts "Only select by id separated by blank spaces"
      input = gets.chomp.split
    end
    input
  end

  def ask_question(question)
    puts question[:question]
    shuffled_options = question[:options].shuffle.each_with_index.map do |option, index|
      "#{index + 1}. #{option}"
    end
    puts shuffled_options
    print "> "
    input = gets.chomp.strip
    until %w[1 2 3 4].include?(input)
      puts "Invalid option"
      print "> "
      input = gets.chomp.strip
    end
    shuffled_options.find { |option| option.start_with? input }
  end
end
