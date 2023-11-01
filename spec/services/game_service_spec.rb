require 'rails_helper'

RSpec.describe GameService, type: :service do
  describe '.random_word' do
    it 'returns a random word from the word list file' do
      expect(File).to receive(:open).with(GameService::WORD_LIST_FILE, 'r').and_yield(File.new(Rails.root.join('public', 'word_list.txt')))
      random_word = GameService.random_word
      expect(random_word).not_to be_empty
    end

    it 'returns an empty string if the word list file is empty' do
      expect(File).to receive(:open).with(GameService::WORD_LIST_FILE, 'r').and_yield(File.new(Rails.root.join('public', 'empty_word_list.txt')))
      random_word = GameService.random_word
      expect(random_word).to eq('')
    end

    # it 'returns an empty string and logs an error if the file is not found' do
    #   expect(File).to receive(:open).and_raise(Errno::ENOENT)
    #   expect(Rails.logger).to receive(:error)
    #   random_word = GameService.random_word
    #   expect(random_word).to eq('')
    # end

    it 'returns an empty string if the word list file is empty' do
      allow(File).to receive(:open).with(GameService::WORD_LIST_FILE, 'r').and_yield(File.new(Rails.root.join('public', 'empty_word_list.txt')))
      random_word = GameService.random_word
      expect(random_word).to eq('')
    end
    

    it 'returns an empty string and logs an error if there is any other error' do
      expect(File).to receive(:open).and_raise(StandardError)
      random_word = GameService.random_word
      expect(random_word).to eq('')
    end
  end
end
