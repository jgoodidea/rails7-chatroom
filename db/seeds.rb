# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
james = User.create(email: 'james@email.com',
                    username: 'James',
                    password: 'abcdef',
                    password_confirmation: 'abcdef',
                    role: 'admin')
jean = User.create(email: 'jean@email.com',
            username: 'Jean',
            password: 'abcdef',
            password_confirmation: 'abcdef')
ravi = User.create(email: 'ravi@email.com',
            username: 'Ravi',
            password: 'abcdef',
            password_confirmation: 'abcdef')
james.joined_rooms << Room.create(name: 'General', is_private: false)
james.joined_rooms << Room.create(name: 'Testing', is_private: false)