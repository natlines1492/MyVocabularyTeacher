require_relative './helpers/presenter'
require_relative './helpers/requester'

class Vocabulary
  def initialize
    @vocabulary_list = ''
  end

  def start
    puts "This is the Vocabulary Teacher App"
  end
end

vocabulary = Vocabulary.new
vocabulary.start
