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
      it "Has each item by merchant with name, description, price, image, active status, inventory and buttopn to diable" do

        visit '/merchant/items'

        within "#item-#{@tire.id}" do
          expect(page).to have_content(@tire.name)
          expect(page).to have_content(@tire.description)
          expect(page).to have_content(@tire.price)
          expect(page).to have_xpath("//img[@src='#{@tire.image}']")
          expect(page).to have_content(@tire.active?)
          expect(page).to have_content(@tire.inventory)
          expect(@tire.active?).to eq(true)
          expect(page).to have_button("Disable")
        end

        within "#item-#{@pull_toy.id}" do
          expect(page).to have_content(@pull_toy.name)
          expect(page).to have_content(@pull_toy.description)
          expect(page).to have_content(@pull_toy.price)
          expect(page).to have_xpath("//img[@src='#{@pull_toy.image}']")
          expect(page).to have_content(@pull_toy.active?)
          expect(page).to have_content(@pull_toy.inventory)
          expect(@pull_toy.active?).to eq(true)
          expect(page).to have_button("Disable")
        end
      end
      it "Can disable and Item by pressing the 'Diable' button" do

        visit '/merchant/items'

        within "#item-#{@tire.id}" do
          click_button "Disable"
        end

        @tire.reload
        within "#item-#{@tire.id}" do
          expect(page).to have_content("Active?: false")
        end
        expect(current_path).to eq('/merchant/items')
        expect(@tire.active?).to eq(false)
        expect(@pull_toy.active?).to eq(true)
        expect(page).to have_content("#{@tire.name} is no longer for Sale")
      end
    end
  end
end
