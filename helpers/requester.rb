module Requester
  def main_menu
    options = %w[search add practice toggle exit]
    puts options.join(" | ")
    print "> "
    STDIN.gets.chomp
  end
end
