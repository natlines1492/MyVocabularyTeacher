module Requester
  def main_menu
    options = %w[search add practice toggle exit]
    input_with_options(options)
  end

  def add_menu
    options = %w[save delete back]
    input_with_options(options)
  end

  def practice_menu
    options = %w[definitions examples back]
    input_with_options(options)
  end

  def ask_save_menu
    options = %w[yes no]
    input_with_options(options)
  end

  def input_with_options(options)
    puts options.join(" | ")
    print "> "
    input = gets.chomp
    until options.include?(input)
      puts "Invalid option"
      print "> "
      input = gets.chomp
    end
    input
  end

  def input_user
    print "Please enter the word to be searched: "
    gets.chomp.strip
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
