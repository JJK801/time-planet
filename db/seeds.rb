# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AssociatesUpdate.destroy_all

AssociatesUpdate.create(
                  total_raised: 19,
                  total_associates: 9,
                  last_associate_name_1: 'Harry Potter',
                  last_associate_shares_1: 3,
                  last_associate_date_1: Date.today,
                  last_associate_name_2: 'Hermione Granger',
                  last_associate_shares_2: 2,
                  last_associate_date_2: Date.yesterday,
                  last_associate_name_3: 'Severus Snake',
                  last_associate_shares_3: 1,
                  last_associate_date_3: Date.yesterday
)