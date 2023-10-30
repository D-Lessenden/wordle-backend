# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# #   Character.create(name: "Luke", movie: movies.first)
# # db/seeds.rb

GameHistory.destroy_all
Game.destroy_all
Word.destroy_all
User.destroy_all

# Create two users
user1 = User.create!(username: "user1", email: "user1@example.com", password: "password1", password_confirmation: "password1")
user2 = User.create!(username: "user2", email: "user2@example.com", password: "password2", password_confirmation: "password2")

# Create words
word1 = Word.create(word: 'apple')
word2 = Word.create(word: 'track')

# Create game histories for user 1
game_history1 = GameHistory.create(user: user1, target_word: word1)
game_history2 = GameHistory.create(user: user2, target_word: word2)

# Create games associated with game histories
game1 = Game.create(word: word1, attempts: 6, status: 'won', game_history: game_history1)
game2 = Game.create(word: word2, attempts: 6, status: 'lost', game_history: game_history1)

game3 = Game.create(word: word1, attempts: 6, status: 'won', game_history: game_history2)
game4 = Game.create(word: word2, attempts: 6, status: 'lost', game_history: game_history2)

# Create guesses associated with games
# game1_guesses = ['a', 'p', 'p', 'l', 'e']
# game1_guesses.each do |letter|
#   Guess.create(game: game1, word: letter, correct: true)
# end

# game2_guesses = ['t', 'r', 'a', 'c', 'k']
# game2_guesses.each do |letter|
#   Guess.create(game: game2, word: letter, correct: true)
# end

# game3_guesses = ['a', 'p', 'p', 'l', 'e']
# game3_guesses.each do |letter|
#   Guess.create(game: game3, word: letter, correct: true)
# end

# game4_guesses = ['t', 'r', 'a', 'c', 'k']
# game4_guesses.each do |letter|
#   Guess.create(game: game4, word: letter, correct: true)
# end




# # Create two users
# user1 = User.create!(username: "user1", email: "user1@example.com", password: "password1", password_confirmation: "password1")
# user2 = User.create!(username: "user2", email: "user2@example.com", password: "password2", password_confirmation: "password2")


# word1 = Word.create!(word: 'apple')
# word2 = Word.create!(word: 'track')

# game1 = Game.create!(word: word1, attempts: 6)
# game2 = Game.create!(word: word2, attempts: 6)

# # Create GameHistories for user 1
# game_history1 = GameHistory.create(user: user1, game: game1, won: true)
# game_history2 = GameHistory.create(user: user1, game: game2, won: false)

# # Create GameHistories for user 2
# game_history3 = GameHistory.create(user: user2, game_id: game1.id, won: false)
# game_history4 = GameHistory.create(user: user2, game_id: game2.id, won: true)

# # game1_guess1 = ['a', 'p', 'p', 'l', 'e']

# # game1_guess1.each do |letter|
# #     Guess.create(game: game1, word: letter) # Assuming all letters are correct in this example
# # end

# # game2_guesses = ['s','m','i','r','k']
# # game2_guesses.each do |letter|
# #     Guess.create(game: game2, word: letter) # Assuming all letters are correct in this example
# # end


