require "nokogiri"
require "open-uri"

module Scrapper
  class Dictionary
    def initialize
      @base_uri = "https://www.wordreference.com/definition"
    end

    def look_up(word)
      doc = Nokogiri::HTML(URI.parse("#{@base_uri}/#{word}").open)
      definition_section = doc.at_css("#otherDicts .entryRH")
      return puts "No dictionary entry found for '#{word}'" unless definition_section

      description_element = definition_section.children.find do |node|
        node.name == "ol" && node.children.text != "\r\n"
      end

      use_definition_example(word, description_element)
    end

    private

    def use_definition_example(word, description_element)
      node_definition = description_element.first_element_child.children.find { |node| node.matches?(".rh_def") }
      node_example = node_definition.children.find { |node| node.matches?(".rh_ex") }

      definition = node_definition.children.find { |node| node.name == "text" }.content
      example_element = node_example.children.find { |node| node.name == "text" }
      example = (example_element.nil? ? nil : example_element.content)

      { word: word, definition: definition, example: example }
    end
  end
end
