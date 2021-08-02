require "csv"

class Store
  def self.save_csv(vocabulary)
    CSV.open("vocabulary.csv", "w") do |csv|
      vocabulary.each do |word|
        word.each { |row| csv << row }
        csv << [""]
      end
    end
  end
end
