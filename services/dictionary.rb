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
      return "No dictionary entry found for '#{word}'" unless definition_section

      definition_section_children = definition_section.children
      uses = definition_section_children.select { |node| node.matches?(".rh_empos") }
      description_element = definition_section_children.select { |node| node.name == "ol" }

      word_data = { word: word, definitions: [] }
      uses_count = uses.count
      uses_count.times do |i|
        word_data[:definitions].push(use_definition_example(uses[i], description_element[i]))
      end

      word_data
    end

    def use_definition_example(node_use, description_element)
      use = node_use.content
      node_definition = description_element.first_element_child.children.find { |node| node.matches?(".rh_def") }
      definition = node_definition.children.find { |node| node.name == "text" }.content[1..-2]
      node_example = node_definition.children.find { |node| node.matches?(".rh_ex") }
      example_element = node_example.children.find { |node| node.name == "text" }
      example = (example_element.nil? ? nil : example_element.content)

      { uses: use, definition: definition, example: example }
    end
  end
end
