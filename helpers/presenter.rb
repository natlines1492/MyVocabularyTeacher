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
end
