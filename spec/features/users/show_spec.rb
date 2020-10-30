require 'rails_helper'

RSpec.describe "As a registered user" do
  describe "When I visit my profile page" do
    before(:each) do 
      @fred = User.create(name: "Fred Savage",
                   address: "666 Devil Ave",
                   city: "Mesatown",
                   state: "AZ",
                   zip: '80085',
                   email: "rando@gmail.com",
                   password: "test",
                   role: 0)
                   
      visit root_path

      within "nav" do
        click_link "Log In"
      end

      fill_in :email, with: "rando@gmail.com"
      fill_in :password, with: @fred.password
      click_button "Log In"
    end
    it 'I see all of my information except my password' do
      expect(page).to have_content("Fred Savage")
      expect(page).to have_content("666 Devil Ave")
      expect(page).to have_content("Mesatown")
      expect(page).to have_content("AZ")
      expect(page).to have_content("80085")
      expect(page).to have_content("rando@gmail.com")

      expect(page).to have_link("Edit Profile Information")
    end
  end
end