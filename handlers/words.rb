require_relative "../helpers/presenter"

module Handler
  module Words
    def vocabulary_word(input)
      word = DictionaryService.words(@current_language, input)[0]
      word_data = {}
      word_data[:word] = word[:word]
      word_data[:definitions] = []

      word[:meanings].each do |meaning|
        definition = {
          uses: meaning[:partOfSpeech],
          definition: meaning[:definitions][0][:definition],
          example: meaning[:definitions][0][:example]
        }
        word_data[:definitions] << definition
      end

      word_data
    end

    def format_rows(word_data)
      word_rows = []
      word_rows << [word_data[:word], nil]

      word_data[:definitions].each do |definition|
        word_rows << ["uses", definition[:uses]]
        word_rows << ["definition", definition[:definition]]
        word_rows << ["example", definition[:example]]
      end

      word_rows
    end

    def random_word_for_game
      if @vocabulary_list.length <= 5
        RandomWord.adjs.next.split("_")[0]
      else
        @vocabulary_list.sample[:word]
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

    def make_question
      options = []
      random_word = random_word_for_game
      options << random_word
      size = (random_word.size < 5 ? 5 : random_word.size)
      3.times { options << match_options(random_word[0..1], size, random_word) }

      definition = vocabulary_word(random_word)[:definitions].sample[:definition]
      puts "Select the correct word:"
      puts definition

      options.shuffle.each_with_index do |option, index|
        puts "#{index + 1}. #{option}"
      end
    end
  end
end
