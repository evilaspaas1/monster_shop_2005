require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      @dog_chew_toy = @brian.items.create(name: "Dog Chew Toy", description: "They'll really love it!", price: 22, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 23)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
      expect(page).to_not have_link(@dog_bone.name)
      expect(page).to have_link(@dog_bone.merchant.name)
    end

    it "I can see a list of all of the items" do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).to_not have_css("#item-#{@dog_bone.id}")
  
    end
    it 'I can only see items that are not disabled' do

      visit '/items'

      expect(page).to_not have_content("#{@dog_chew_toy.name}")
      expect(page).to_not have_content("#{@dog_chew_toy.description}")
      expect(page).to_not have_content("#{@dog_chew_toy.price}")
    end

    it 'I see area statistics' do

      pokemon_shop = Merchant.create(name: "Brett's Pokemon Shop", address: "5465 Fireball ln", city: "Alaska", state: "CO", zip: 90054)
      barbie_shop = Merchant.create(name: "Austin's Barbie Shop", address: "9898 Pink Flower Ave", city: "Delaware", state: "FL", zip: 8432)
      legos_shop = Merchant.create(name: "Nico's & Robertos Lego Shop", address: "1232 Building Block ln", city: "LA", state: "CA", zip: 90210)
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      scuba_shop = Merchant.create(name: "Jacks Scuba Shop", address: '8976 Ocean Ave', city: 'San Diego', state: 'CA', zip: 91191)
      
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      picachu = pokemon_shop.items.create(name: "Picachu", description: "Cute and sweet", price: 500, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT4PewcMiE3DBPshmdW_t5oRULoBoyxNrTE7Q&usqp=CAU", inventory: 20)
      charazard = pokemon_shop.items.create(name: "Charazard", description: "Very rude", price: 7, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSNpBmAK50aHhPZMCw1B3o-Xvgm9Ocd0yCOUg&usqp=CAU", inventory: 5)
      barbie_1 = barbie_shop.items.create(name: "Falechia", description: "beautiful in pink", price: 300, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRdYkyQHS6trfq325x8kEocYhptd-3pxKpyCA&usqp=CAU", inventory:69)
      barbie_2 = barbie_shop.items.create(name: "Dave", description: "Handy man", price: 5, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRPz5kbl4Qc6P2SOKLi0A63lRTrorW6vyidjA&usqp=CAU", inventory: 43)
      tower = legos_shop.items.create(name: "Castle", description: "epic and glorious", price: 22, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSKUZDbGra_dHzHxPzD-_8Sk3JjB6u9EpaXqQ&usqp=CAU", inventory: 4)
      car = legos_shop.items.create(name: "Car", description: "fast and loud", price: 56, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRl2KCh6ytGsRsHImL1gkNeEr6d_nz8yBejmg&usqp=CAU", inventory: 100)
      scuba_steve = scuba_shop.items.create(name: "Bathtub Buddy", description: "He can dive deep", price: 2000, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQpqzsLgDQ5egPZpF-M1aNcgkK9WZiB5CVv8w&usqp=CAU", inventory: 101)
      goggles = scuba_shop.items.create(name: "Goggles", description: "Cheap and not worth the buy", price: 3, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSl4pO86Z6zPk530M4bmZHxqmgPZcO-nc8qCw&usqp=CAU", inventory: 150)
     
      visit '/items'

      
    end
  end
end
