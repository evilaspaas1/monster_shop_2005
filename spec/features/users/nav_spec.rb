require 'rails_helper'

describe "As a user" do
  it "Has the same links as a visitor, plus links to log out and my profile" do

    fred = User.create(name: "Fred Savage",
                       address: "666 Devil Ave",
                       city: "Mesatown",
                       state: "AZ",
                       zip: '80085',
                       email: "rando@gmail.com",
                       password: "test",
                       role: 0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(fred)
    visit root_path

    within 'nav' do
      expect(page).to have_link("All Merchants")
      expect(page).to have_link("All Items")
      expect(page).to have_link("Cart: 0")
      expect(page).to have_link("Home")
      expect(page).to have_link("Log Out")
      expect(page).to have_link("Profile")
    end
  end
end
