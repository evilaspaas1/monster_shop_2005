require 'rails_helper'

describe 'merchant show page', type: :feature do
  describe 'As a merchant employee' do
    describe 'When I visit my merchant dashboard' do
      before(:each) do
        @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @roz = @bike_shop.users.create(name: "Roz Peterson",
                    address: "Monster Inc.",
                    city: "Monster Town",
                    state: "Monster State",
                    zip: '80000',
                    email: "fright@gmail.com",
                    password: "test",
                    role: 1)

        @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        @pull_toy = @bike_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

        visit "/login"
        fill_in :email, with: @roz.email
        fill_in :password, with: @roz.password
        click_button "Log In"
      end
      it "Can edit an item in my merchant items page" do
        visit '/merchant/items'

        within "#item-#{@pull_toy.id}" do
          expect(page).to have_link('Edit Item')
          click_link 'Edit Item'
        end
        expect(current_path).to eq("/merchant/items/#{@pull_toy.id}/edit")

        #fill_in "Name", with: ""
        fill_in "Description", with: "Okay, pull toy"
        #fill_in "Image", with: ""
        #fill_in "Price", with: "two"
        #fill_in "Inventory", with: 50

        click_on "Update Item"

        @pull_toy.reload

        expect(current_path).to eq('/merchant/items')
        expect(@pull_toy.description).to eq("Okay, pull toy")
      end
      it "All data must be correct or the page renders with a flash message" do

        visit '/merchant/items'

        within "#item-#{@pull_toy.id}" do
          expect(page).to have_link('Edit Item')
          click_link 'Edit Item'
        end
        expect(current_path).to eq("/merchant/items/#{@pull_toy.id}/edit")

        fill_in "Name", with: ""
        #fill_in "Description", with: "Great pull toy!"
        #fill_in "Image", with: ""
        fill_in "Price", with: 10
        fill_in "Inventory", with: "Alot"

        click_on "Update Item"

        expect(current_path).to eq("/merchant/items/#{@pull_toy.id}/update")
        expect(page).to have_content("Name can't be blank and Inventory is not a number")
        expect(@pull_toy.description).to eq("Great pull toy!")
      end
    end
  end
end
