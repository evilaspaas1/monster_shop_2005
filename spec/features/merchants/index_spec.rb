require 'rails_helper'

RSpec.describe 'merchant index page', type: :feature do
  describe 'As a user' do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      @dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)
    end

    it 'I can see a list of merchants in the system' do
      visit '/merchants'

      expect(page).to have_link("Brian's Bike Shop")
      expect(page).to have_link("Meg's Dog Shop")
    end

    it 'I can see a link to create a new merchant' do
      visit '/merchants'

      expect(page).to have_link("New Merchant")

      click_on "New Merchant"

      expect(current_path).to eq("/merchants/new")
    end
  end
  describe 'As an admin' do 
    it 'I see a link to ' do
      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)
      dog_shop = Merchant.create(name: "Meg's Dog Shop", address: '123 Dog Rd.', city: 'Hershey', state: 'PA', zip: 80203)

      tim = User.create(name: "Tim",
                         address: "Ya Hate To See It Dr.",
                         city: "Denver",
                         state: "CO",
                         zip: '80205',
                         email: "timgmail.com",
                         password: "test",
                         role: 2)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
                  
      visit "/login"

      fill_in :email, with: tim.email
      fill_in :password, with: tim.password
      click_button "Log In"

      visit '/merchants'

      expect(page).to have_link("Brian's Bike Shop")
      expect(page).to have_link("Meg's Dog Shop")

      click_link "Mike's Print Shop"
      expect(current_path).to eq("/admin/merchants/#{mike.id}")

      expect(page).to have_content(mike.name)
      expect(page).to have_content(mike.address)
      expect(page).to have_content(mike.city)
      expect(page).to have_content(mike.state)
      expect(page).to have_content(mike.zip)

      expect(page).to have_link("All #{mike.name} Items")

      expect(page).to have_link("Update Merchant")
      expect(page).to have_link("Delete Merchant")
      
      expect(page).to have_content("Number of Items: #{mike.item_count}")
      expect(page).to have_content("Average Price of Items: $#{mike.average_item_price}")
      expect(page).to have_content("Cities that order these items:") 
    end 
  end 
end
