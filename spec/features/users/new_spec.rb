require 'rails_helper'

RSpec.describe "As a visitor" do 
  describe "When I visit the user registration page" do
    it 'I can register as a user with details' do
      visit '/items'

      within ".topnav" do 
        click_link "Register"
      end

      expect(current_path).to  eq('/register')

      fill_in :name, with:("Mike Sully")
      fill_in :address, with:("123 Fake St")
      fill_in :city, with:("Denver")
      fill_in :state, with:("CO")
      fill_in :zip, with:("80000")
      fill_in :email, with:("msully@monster.inc")
      fill_in :password, with:("m$ully")
      fill_in :password_confirmation, with:("m$ully")

      click_button('Create Profile')

      expect(current_path).to eq('/profile')
      expect(page).to have_content("You have successfully registered and logged in.")
    end
    it 'I am returned to the registration page if information is not all filled in' do
      visit '/items'

      within ".topnav" do 
        click_link "Register"
      end

      fill_in :name, with:("Mike Sully")
      fill_in :address, with:("123 Fake St")
      fill_in :city, with:("Denver")
      fill_in :state, with:("CO")
      fill_in :zip, with:("")
      fill_in :email, with:("msully@monster.inc")
      fill_in :password, with:("m$ully")
      fill_in :password_confirmation, with:("m$ully")

      click_button('Create Profile')

      expect(current_path).to_not eq("/profile")
      expect(page).to have_content("Zip can't be blank") 
    end
  end
  
end