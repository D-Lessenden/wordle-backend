# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# db/seeds.rb

# Create two users
user1 = User.create!(username: "user1", email: "user1@example.com", password: "password1", password_confirmation: "password1")
user2 = User.create!(username: "user2", email: "user2@example.com", password: "password2", password_confirmation: "password2")

# Create game histories for user 1
GameHistory.create(user: user1, target_word: "word1", status: "won")
GameHistory.create(user: user1, target_word: "word2", status: "lost")

# Create game histories for user 2
GameHistory.create(user: user2, target_word: "word3", status: "won")
GameHistory.create(user: user2, target_word: "word4", status: "lost")
