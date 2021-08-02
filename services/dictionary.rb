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

      description_element = definition_section.at_css("li")
      
      use_definition_example(word, description_element)
    end

    private

    def use_definition_example(word, description_element)
      node_definition = description_element.at_css(".rh_def")
      node_example = node_definition.at_css(".rh_ex")
      ul_condition = node_definition.at_css(".rh_sdef")
      if ul_condition
        definition = ul_condition.children.find { |node| node.name == "text" }.content
      else
        variable = node_definition.children.find { |node| node.name == "text" }
        definition = variable.content if variable && variable.text != "\r\n"
        unless variable && variable.text != "\r\n"
          src_condition = node_definition.at_css(".rh_sc")
          if src_condition
            definition = src_condition.content
          end
        end
      end
      example_element = node_example.children.find { |node| node.name == "text" } unless node_example.nil?
      example = (example_element.nil? ? nil : example_element.content)

      { word: word, definition: definition, example: example }
    end
  end
end
