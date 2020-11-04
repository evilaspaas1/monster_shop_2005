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
      it "Can create a new item" do

        visit '/merchant/items'

        expect(page).to have_link('New Item')
        click_link 'New Item'

        fill_in "Name", with: "Bell"
        fill_in "Description", with: "Ding Ding"
        fill_in "Image", with: ""
        fill_in "Price", with: 2
        fill_in "Inventory", with: 50

        click_on "Create Item"

        @bell = Item.last
        expect(current_path).to eq('/merchant/items')
        expect(page).to have_css("#item-#{@bell.id}")
        expect(page).to have_content("#{@bell.name} is Saved")
      end
      it "items need all information above (except image) and wont be created until all information is filled in and correct" do

        visit '/merchant/items'

        expect(page).to have_link('New Item')
        click_link 'New Item'

        fill_in "Name", with: "Bell"
        fill_in "Description", with: ""
        fill_in "Image", with: ""
        fill_in "Price", with: "two"
        fill_in "Inventory", with: 50

        click_on "Create Item"

        expect(page).to have_field("Image", placeholder: "Put image here")
        expect(current_path).to eq('/merchant/items')
        expect(page).to have_content("Description can't be blank and Price is not a number")
      end
    end
  end
end
