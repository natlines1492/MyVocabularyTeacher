require "csv"

class Store
  def self.save_csv(vocabulary)
    CSV.open("vocabulary.csv", "w") do |csv|
      vocabulary.each do |word|
        word.each do |row|
          csv << row
        end
        csv << [""]
      end
    end
  end
end
