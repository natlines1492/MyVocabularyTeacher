module Requester
  def main_menu
    options = %w[search add practice toggle exit]
    puts options.join(" | ")
    print "> "
    $stdin.gets.chomp
  end

  def input_user
    puts "Word: "
    print "> "
    $stdin.gets.chomp.strip
  end
end
