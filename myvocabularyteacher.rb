require_relative './helpers/presenter'
require_relative './helpers/requester'

class Vocabulary
  include Presenter

  def initialize
    @vocabulary_list = ''
  end

  def start
    puts welcome
  end
end

vocabulary = Vocabulary.new
vocabulary.start
