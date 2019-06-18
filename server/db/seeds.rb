# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
User.create!([{fist_name: 'Mary', last_name: 'Brown',email: 'mary@email.com', mentor: 'True', mentee: 'False'},{fist_name: 'Nuala', last_name: 'May',email: 'nuala@email.com', mentor: 'False', mentee: 'True'},{fist_name: 'Bob', last_name: 'Brown',email: 'bob@email.com', mentor: 'True', mentee: 'False'}])
