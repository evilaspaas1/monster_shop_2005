
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    it "I see a nav bar with links to all pages" do
      visit '/merchants'

      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')
    end

    it "I can see a cart indicator on all pages" do
      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end

      visit '/items'

      within 'nav' do
        expect(page).to have_content("Cart: 0")
      end
    end
    it "I can see a link returning to the home page" do

      visit '/merchants'

      within 'nav' do
        expect(page).to have_content("Home")
      end
    end
    it "I can see all Links required in nav" do
      visit root_path

      within 'nav' do
        expect(page).to have_link("Log In")
        expect(page).to have_link("All Merchants")
        expect(page).to have_link("All Items")
        expect(page).to have_link("Cart: 0")
        expect(page).to have_link("Register")
        expect(page).to have_link("Home")
      end
    end

    it "When I try to access any path '/merchant, /admin, /profile' I then see a 404 error" do
      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
