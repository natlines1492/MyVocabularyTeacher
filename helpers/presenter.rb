require "terminal-table"

module Presenter
  def welcome
    [
      "#" * 36,
      "# Welcome to My Vocabulary Teacher #",
      "#" * 36
    ]
  end

  def goodbye
    [
      "#" * 36,
      "#    Thank you for prefering us    #",
      "#" * 36
    ]
  end

  def print_definition(word_data)
    title = word_data.first.first

    table = Terminal::Table.new do |t|
      t.title = title.capitalize
      t.add_row(word_data[1])
      word_data[2..-1].each do |row|
        t.add_separator if row[0] == "uses"
        t.add_row(row)
      end
    end

    puts table
  end
end
