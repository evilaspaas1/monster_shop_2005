require 'rails_helper'

describe 'As a registered user' do
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
  describe  'When I click on the link to edit my profile data' do
    it "I see a link" do
      click_link "Edit Profile Information"

      expect(current_path).to eq('/profile/edit')
    end

    it "I seea form prepopulated with all my current information" do
      visit '/profile/edit'

      expect(page).to have_field('name', with: 'Fred Savage')
      expect(page).to have_field('address', with: '666 Devil Ave')
      expect(page).to have_field('city', with: 'Mesatown')
      expect(page).to have_field('state', with: 'AZ')
      expect(page).to have_field('zip', with: '80085')
      expect(page).to have_field('email', with: 'rando@gmail.com')
      expect(page).to_not have_field('password', with: 'test')
      expect(page).to have_button("Submit")
    end

    it "When i change any or all of thae information and submit it
    i am returned to the profile page" do
      visit '/profile/edit'

      fill_in 'city', with: 'Miami'
      fill_in 'zip', with: '352'

      click_button "Submit"

      expect(current_path).to eq('/profile')

      expect(page).to have_content('Miami')
      expect(page).to have_content('352')
      expect(page).to_not have_content('Mesatown')
      expect(page).to_not have_content('80085')

      expect(page).to have_content('Data has been updated')
    end

    it "When i dont fill in all the fields i get sent back to edit and get an error" do
      visit '/profile/edit'

      fill_in 'city', with: ''

      click_button "Submit"
      expect(page).to have_content("City can't be blank")
    end
  end
end
