require_relative "../helpers/presenter"
require_relative "../lists_practice/english_list_practice"

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

    def random_words_for_game
      random_words = []
      vocabulary_sample = proc { random_words << @new_vocabulary_words.sample[:word] }
      random_sample = proc { random_words << ListsPractice::ENGLISH_WORDS.sample }

      words_in_vocabulary = @new_vocabulary_words.length
      if words_in_vocabulary >= 5
        5.times(&vocabulary_sample)
        5.times(&random_sample)
      else
        new_words_to_add = 10 - words_in_vocabulary
        words_in_vocabulary.times(&vocabulary_sample)
        new_words_to_add.times(&random_sample)
      end
      random_words
    end

    def match_options(char_option, size, word_exclude)
      word = ""
      until word.start_with?(char_option) && word.size <= size && word != word_exclude
        begin
          word = ListsPractice::ENGLISH_WORDS.sample
        rescue NoMethodError
          retry
        end
      end
      word
    end

    def generate_questions(practice_type)
      random_words = random_words_for_game
      questions = []

      random_words.each do |word|
        size = (word.size < 5 ? 5 : word.size)
        word_data = vocabulary_word(word)
        available_definitions = vocabulary_word(word)[:definitions]

        case practice_type
        when "definitions"
          question = available_definitions.sample[:definition]
        when "examples"
          question = available_definitions.sample[:example]
          question = available_definitions.sample[:example] while question.nil?
        end
        options = [word]
        3.times { options << match_options(word[0..1], size, word) }

        questions << { question: question, options: options, correct_answer: word }
        @new_vocabulary_words << word_data unless @vocabulary_list.include? word_data
      end
      questions
    end
  end
end
