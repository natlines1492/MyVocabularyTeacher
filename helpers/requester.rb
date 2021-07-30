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
end
