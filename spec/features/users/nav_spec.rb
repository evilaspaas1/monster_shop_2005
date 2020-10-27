require 'rails_helper'

describe "As a user" do
  it "Has the same links as a visitor, plus links to log out and my profile" do
    
    visit root_path

    within 'nav' do
      expect(page).to have_link("Log In")
      expect(page).to have_link("All Merchants")
      expect(page).to have_link("All Items")
      expect(page).to have_link("Cart: 0")
      expect(page).to have_link("Register")
      expect(page).to have_link("Home")
      expect(page).to have_link("Log Out")
      expect(page).to have_link("Profile")
    end
  end
end
