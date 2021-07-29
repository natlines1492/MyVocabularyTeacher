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

  def print_definition(title, word_data)
    table = Terminal::Table.new do |t|
      t.title = title.capitalize
      t.add_row(word_data[1])

      word_data[2..-1].each do |row|
        if row[0] == "uses"
          t.add_separator
          t.add_row(row)
        else
          text = row[1].scan(/(.{1,60})(?: |$)/).flatten
          row_multiline_height = text.length - 1
          header = [row[0]]
          row_multiline_height.times { header << "\n" }
          multiline_row = header.zip(text)

          multiline_row.each do |line_row|
            t.add_row(line_row)
          end
        end
      end
    end

    puts table
  end
end
