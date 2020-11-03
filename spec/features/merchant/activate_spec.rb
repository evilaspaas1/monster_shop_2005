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

        #@order_1 = @roz.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: "pending")
        #@order_2 = @roz.orders.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, status: "pending")

        visit "/login"
        fill_in :email, with: @roz.email
        fill_in :password, with: @roz.password
        click_button "Log In"
      end
      it "If an item is disabled, it will have a button to enable that item" do
        visit '/merchant/items'

        within "#item-#{@tire.id}" do
          click_button "Disable"
        end

        within "#item-#{@tire.id}" do
          expect(page).to have_button("Activate")
          click_button("Activate")
        end

        within "#item-#{@tire.id}" do
          expect(page).to have_content("Active?: true")
        end
        expect(page).to have_content("#{@tire.name} is Available for Sale")
      end
    end
  end
end
