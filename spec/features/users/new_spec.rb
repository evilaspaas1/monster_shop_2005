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
      fill_in :password_confirmation, with:("test")

      click_button('Create Profile')

      expect(current_path).to_not eq("/profile")
      expect(page).to have_content("Zip can't be blank")
    end
    it 'I am returned to the registration page if password_confirmation does not match password' do
      visit '/items'

      within ".topnav" do
        click_link "Register"
      end

      fill_in :name, with:("Mike Sully")
      fill_in :address, with:("123 Fake St")
      fill_in :city, with:("Denver")
      fill_in :state, with:("CO")
      fill_in :zip, with:("12345")
      fill_in :email, with:("msully@monster.inc")
      fill_in :password, with:("m$ully")
      fill_in :password_confirmation, with:("test")

      click_button('Create Profile')

      expect(page).to have_content("Password confirmation doesn't match Password")
    end
    it 'And I fill in an email that is not unique, I am returned to the registration page' do

      cactus = User.create!(
        name: "Cactus",
        address: "1234 Real St",
        city: "Denver",
        state: "CO",
        zip: "80000",
        email: "succulent_cactus@hotmail.com",
        password: "C@ctu$"
      )

      visit '/items'

      within ".topnav" do
        click_link "Register"
      end

      fill_in :name, with:("Mike Sully")
      fill_in :address, with:("123 Fake St")
      fill_in :city, with:("Denver")
      fill_in :state, with:("CO")
      fill_in :zip, with:("80001")
      fill_in :email, with:("succulent_cactus@hotmail.com")
      fill_in :password, with:("m$ully")
      fill_in :password_confirmation, with:("m$ully")

      click_button('Create Profile')

      expect(page).to have_content("Email has already been taken")
      expect(page).to have_field('Name', with: 'Mike Sully')
      expect(page).to have_field('Address', with: '123 Fake St')
      expect(page).to have_field('City', with: 'Denver')
      expect(page).to have_field('State', with: 'CO')
      expect(page).to have_field('Zip', with: '80001')
    end
  end

end
