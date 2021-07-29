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
end
