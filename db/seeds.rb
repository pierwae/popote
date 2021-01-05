puts '#1 Cleaning DB...'

BasketSuborder.delete_all
Basket.delete_all

Suborder.delete_all
Order.delete_all

Meal.delete_all
Category.delete_all
Cook.delete_all
User.delete_all

puts '#2 Creating some fake users...'

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

puts '#3 Creating some fake cooks...'

Cook.create(user: pierre)
Cook.create(user: olivia)

puts '#4 Creating some fake categories and meals...'

def create_some_meals(category, cook)
  Meal.create(name: 'Hamburger', price: 5.00, category: category, cook: cook, rank: 1)
  Meal.create(name: 'Tarte tatin', price: 10.00, category: category, cook: cook, rank: 2)
  Meal.create(name: 'Raclette', price: 15.00, category: category, cook: cook, rank: 3)
end

Cook.all.each do |cook|
  cat1 = Category.create(name: 'Plats asiatiques', cook: cook, rank: 1)
  cat2 = Category.create(name: 'Plats algériens', cook: cook, rank: 2)
  cat3 = Category.create(name: "L'Amérique dans l'assiette", cook: cook, rank: 3)

  create_some_meals(cat1, cook)
  create_some_meals(cat2, cook)
  create_some_meals(cat3, cook)
end


puts 'Finished !'
