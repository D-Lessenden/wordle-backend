class WordService
  def self.random_word
    words = File.open('../../public/word_list.txt', 'r').readlines.map(&:chomp)
    valid_words = words.select { |word| word.length == 5 } # Adjust the word length as needed
    valid_words.sample
  end
end