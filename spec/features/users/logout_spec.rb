require "rails_helper"

describe "as a registered user" do
  it "I can logout" do
    fred = User.create(name: "Fred Savage",
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

    expect(current_path).to eq("/login")

    fill_in :email, with: fred.email
    fill_in :password, with: fred.password
    click_button "Log In"

    within "nav" do
      click_link "Log Out"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("You have logged out")
  end
end
