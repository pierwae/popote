puts '1/3 Cleaning DB...'

Cook.delete_all
User.delete_all

puts '2/3 Creating some fake users...'

pierre = User.new(first_name: 'Pierre',
                  last_name: 'Waechter',
                  email: 'pierre@gmail.com',
                  password: 'password')
pierre.save

olivia = User.create(first_name: 'Olivia',
                     last_name: 'Teko',
                     email: 'olivia@gmail.com',
                     password: 'password')
olivia.save

10.times do
  first_name = Faker::Name.first_name
  last_name  = Faker::Name.last_name

  somebody = User.create(first_name: first_name,
                         last_name: last_name,
                         email: "#{first_name}.#{last_name}@gmail.com",
                         password: 'password')

  Cook.create(user: somebody)
end

puts '3/3 Creating some fake cooks...'

Cook.create(user: pierre)
Cook.create(user: olivia)

puts 'Finished !'
