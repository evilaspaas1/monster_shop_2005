require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a merchant employee' do
    it 'I see the name and address of the merchant I work for' do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      roz = bike_shop.users.create(name: "Roz Peterson",
                   address: "Monster Inc.",
                   city: "Monster Town",
                   state: "Monster State",
                   zip: '80000',
                   email: "fright@gmail.com",
                   password: "test",
                   role: 1)

      visit "/login"
      fill_in :email, with: roz.email
      fill_in :password, with: roz.password
      click_button "Log In"  

      expect(page).to have_content(bike_shop.name)
      expect(page).to have_content(bike_shop.address)
      expect(page).to have_content(bike_shop.city)
      expect(page).to have_content(bike_shop.state)
      expect(page).to have_content(bike_shop.zip)
    end 
  end
end 