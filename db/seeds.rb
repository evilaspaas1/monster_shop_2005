# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
User.destroy_all
Merchant.destroy_all

#merchants
monster_shop = Merchant.create(name: "Monsters Inc Knickknack's", address: '800 Monster way', city: 'Monstropolis', state: 'Boo', zip: 54321)
dunder_mifflin = Merchant.create(name: "Dunder Mifflin", address: '1725 Slough Ave.', city: 'Scranton', state: 'PA', zip: 18540)

#regular users
george = User.create(name: "George Sanderson",
                   address: "666 Devil Ave",
                   city: "Monstropolis",
                   state: "Boo",
                   zip: '54323',
                   email: "2319@gmail.com",
                   password: "test",
                   role: 0)

#merchant employee
roz = monster_shop.users.create(name: "Roz Peterson",
                   address: "Monster Inc.",
                   city: "Monster Town",
                   state: "Monster State",
                   zip: '80000',
                   email: "fright@gmail.com",
                   password: "test",
                   role: 1)


dwight = dunder_mifflin.users.create(name: "Dwight Shrute",
                   address: "6 beet lane",
                   city: "Homesdale",
                   state: "PA",
                   zip: '18431',
                   email: "dwight@dundermifflin.com",
                   password: "test",
                   role: 1)



#admins
mr_waternoose = User.create(name: "Henry J. Waternoose",
                   address: "800 scream dr",
                   city: "Monstropolis",
                   state: "Boo",
                   zip: '54321',
                   email: "waternoose@boomail.com",
                   password: "test",
                   role: 2)

michael_scott = User.create(name: "Michael Scott",
                   address: "126 Kellum Court",
                   city: "Scranton",
                   state: "PA",
                   zip: '18540',
                   email: "mscott@dundermifflin.com",
                   password: "test",
                   role: 2)

#monster_shop items
sock = monster_shop.items.create(name: "2319", description: "IT'S A 2319!!!!", price: 200, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSug3_GiOESSCMiJ3LevabTQHUxsrfsk2h8C0NaVAooGFNHo25dsiHdvelg8-6U_6avISqzFLJ6&usqp=CAc", inventory: 75)
scream_canister = monster_shop.items.create(name: "Scream Canister", description: "Power Your Home", price: 1000, image: "https://static.wikia.nocookie.net/disney/images/0/0c/Scream_Canister.jpg/revision/latest?cb=20180308210649", inventory: 25)
scare_dvd = monster_shop.items.create(name: "Scare Tutorial", description: "Scare for the future!", price: 50, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRoTNFYuGP3Lm6tqGcA27L4Bp_nYcx993W5hg1DygWZqFC8i6rUXSP0A2-ii2U2sq2bY-dUAlSR&usqp=CAc", inventory: 327)


#dunder_mifflin items
paper = dunder_mifflin.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
pencil = dunder_mifflin.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
stapler = dunder_mifflin.items.create(name: "Stapler", description: "You can staple your paper with it!(staples not included)", price: 15, image: "https://i.redd.it/qbwb6g4ahev21.jpg", inventory: 500)
staples = dunder_mifflin.items.create(name: "Staples", description: "You can load your staplerwith these!(Stapler not included)", price: 9, image: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTbI_eLqs0We4pSBq5URmGW2rcOhN3kX8svU9AkRhBtedRzZar4r6ZfQ7vj4iWrKAGopJCXYgDnbcySuiFeXlG9rU3MVmUqARoXDmE8EFpb2l8b0KLL800I&usqp=CAY", inventory: 200)
