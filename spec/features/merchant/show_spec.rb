require 'rails_helper'

RSpec.describe 'merchant show page', type: :feature do
  describe 'As a merchant employee' do
    describe 'When I visit my merchant dashboard' do
      before(:each) do
        @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
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
        @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 20, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
        
        @order_1 = @roz.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: "pending")
        @order_2 = @roz.orders.create!(name: 'Brian', address: '123 Zanti St', city: 'Denver', state: 'CO', zip: 80204, status: "pending")
        
        @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
        @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3)
        @order_1.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2)
        @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)

        visit "/login"
        fill_in :email, with: @roz.email
        fill_in :password, with: @roz.password
        click_button "Log In" 
      end  
      it 'I see the name and address of the merchant I work for' do
        expect(page).to have_content(@bike_shop.name)
        expect(page).to have_content(@bike_shop.address)
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_content(@bike_shop.state)
        expect(page).to have_content(@bike_shop.zip)
      end 
      it 'Any pending orders are listed with info' do
        within "#order-#{@order_1.id}" do
          expect(page).to have_link("#{@order_1.id}")
          expect(page).to have_content("Date Created: #{@order_1.created_at}")
          expect(page).to have_content("Order Quantity: #{@order_1.quantity_by_merchant(@bike_shop.id)}")
          expect(page).to have_content("Total Price: #{@order_1.grandtotal_by_merchant(@bike_shop.id)}")
        end
      end 
      it 'I see a link to view my own items' do
        expect(page).to have_link("View My Items")
        click_link("View My Items")
        expect(current_path).to eq("/merchant/items")
      end 
    end 
  end
end 