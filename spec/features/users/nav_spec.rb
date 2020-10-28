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
      expect(page).to have_content("Logged in as #{fred.name}")
    end

    within 'nav' do
      click_link ("All Merchants")
    end
    expect(current_path).to eq('/merchants')

    within 'nav' do
      click_link ("All Items")
    end
    expect(current_path).to eq('/items')

    within 'nav' do
      click_link ("Home")
    end
    expect(current_path).to eq('/')

    within 'nav' do
      click_link ("Profile")
    end
    expect(current_path).to eq('/profile')

    within 'nav' do
      click_link ("Cart: 0")
    end
    expect(current_path).to eq('/cart')

    within 'nav' do
      click_link ("Log Out")
    end
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Good Bye")

    within 'nav' do
      expect(page).to_not have_link("Log In")
      expect(page).to_not have_link("Register")
    end
  end
end
