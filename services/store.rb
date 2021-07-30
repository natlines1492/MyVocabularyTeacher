require "csv"

class Store
  def self.save(vocabulary, _filename)
    # create file if doesnt exist
    data = vocabulary.map { |row| row.join(",") }.join("\n")
    File.write("vocabulary.csv", data)
  end

  def self.save_csv(vocabulary, _filename)
    CSV.open("vocabulary.csv", "w") do |csv|
      vocabulary.each do |row|
        csv << row
      end
    end
  end
end
