require_relative "../helpers/presenter"
require_relative "../lists_practice/english_list_practice"

module Handler
  module Words
    def format_rows(word_data)
      word_rows = []
      word_rows << [word_data[:word], nil]
      word_rows << ["definition", word_data[:definition]]
      word_rows << ["example", word_data[:example]]

      word_rows
    end

    def random_words_for_game
      random_words = []
      vocabulary_sample = proc do
        selected = @vocabulary_list.shuffle.pop
        @vocabulary_list.delete(selected)
        random_words << selected[:word]
      end
      random_sample = proc { random_words << ListsPractice::ENGLISH_WORDS.sample }

      words_in_vocabulary = @vocabulary_list.length
      if words_in_vocabulary >= 5
        5.times(&vocabulary_sample)
        5.times(&random_sample)
      elsif words_in_vocabulary >= 2500
        10.times(&vocabulary_sample)
      else
        new_words_to_add = 10 - words_in_vocabulary
        words_in_vocabulary.times(&vocabulary_sample)
        new_words_to_add.times(&random_sample)
      end
      random_words
    end

    def match_options(char_option, word_exclude, options)
      word = ""
      until word.start_with?(char_option) && word != word_exclude && !options.include?(word)
        word = ListsPractice::ENGLISH_WORDS.sample
      end
      word
    end

    def generate_questions
      random_words = random_words_for_game.shuffle
      questions = []

      random_words.each do |word|
        word_data = @dictionary.look_up(word)
        old_word = @vocabulary_list.include?(word_data)

        question = word_data[:definition]
        options = [word]
        3.times { options << match_options(word[0], word, options) }

        questions << { question: question, options: options, correct_answer: word, data: word_data, new: !old_word }
      end
      questions
    end
  end
end
