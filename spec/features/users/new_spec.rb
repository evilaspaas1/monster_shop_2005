require 'rails_helper'

RSpec.describe "As a visitor" do 
  describe "I can register as a user with details" do
    it 'I see a form where I input details' do
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
    
  end
  
end