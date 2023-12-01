class GameService
  WORD_LIST_FILE = Rails.root.join('public', 'word_list.txt')

  def self.random_word
    begin
      words = read_words_from_file(WORD_LIST_FILE)
      if words.empty?
        Rails.logger.error("Word list file is empty")
        return ""
      end
      words.sample
    rescue StandardError => e
      Rails.logger.error("Error reading word list: #{e.message}")
      ""
    end
  end

  private

  def self.read_words_from_file(file_path)
    begin
      File.open(file_path, 'r') do |file|
        file.readlines.map(&:chomp)
      end
    rescue Errno::ENOENT => e
      # Handle file not found error
      Rails.logger.error("Word list file not found: #{e.message}")
      []
    rescue => e
      # Handle other exceptions
      Rails.logger.error("Error reading word list: #{e.message}")
      []
    end
  end
end

    # valid_words = words.select { |word| word.length == 5 } # Adjust the word length as needed
