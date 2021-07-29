module Requester
  def main_menu
    options = %w[search add practice toggle exit]
    puts options.join(" | ")
    print "> "
    gets.chomp
  end

  def input_user
    puts "Word: "
    print "> "
    gets.chomp.strip
  end
end
