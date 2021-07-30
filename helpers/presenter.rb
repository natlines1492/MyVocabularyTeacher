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
          text = row[1].to_s.scan(/(.{1,60})(?: |$)/).flatten
          header = [row[0]]
          (text.length - 1).times { header << "\n" }
          multiline_row = header.zip(text)

          multiline_row.each do |line_row|
            t.add_row(line_row)
          end
        end
      end
    end

    puts table
  end

  def print_new_vocabulary_words
    table = Terminal::Table.new
    table.title = "New words learned"
    table.rows = @new_vocabulary_words.map { |word| [word[:word]] }

    puts table
  end

  def print_result(correct_answer, player_answer)
    result = player_answer.match? correct_answer
    if result
      puts "#{player_answer}... Correct!"
    else
      puts "#{player_answer}... Incorrect!"
      puts "The correct answer was: #{correct_answer}"
    end
    result
  end
end
