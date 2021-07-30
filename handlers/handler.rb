require_relative "../helpers/presenter"

module Handler
  def vocab_word(input)
    word = DictionaryService.words(@current_language, input)[0]
    word_data = []
    word_data << [word[:word], nil]

    word[:meanings].each do |meaning|
      word_data << ["uses", meaning[:partOfSpeech]]
      word_data << ["definition", meaning[:definitions][0][:definition]]
      word_data << ["example", meaning[:definitions][0][:example]]
    end

    print_definition(word_data)
    @vocabulary_list << word_data
  end

  def save_vocabulary(vocabulary)
    first_definitions = nth_group(vocabulary, 2)
    Store.save(first_definitions, filename)
  end

  def nth_group(arr, num_elements)
    new_arr = []
    count = 0
    condition = false
    arr.each do |element|
      if element[0] == "uses" # to be yield
        count = 0
        condition = true
      end
      next unless count <= num_elements && condition

      new_arr << element
      count += 1
      condition = false if count == num_elements
    end
    new_arr
  end
end
