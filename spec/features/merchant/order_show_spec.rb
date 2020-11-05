require 'rails_helper'

describe 'As a merchant employee' do
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

    @item_order_1 = @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    @item_order_2 = @order_1.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 3, status: 'fulfilled')
    @order_1.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 2)
    @order_2.item_orders.create!(item: @pull_toy, price: @pull_toy.price, quantity: 2)

    visit "/login"
    fill_in :email, with: @roz.email
    fill_in :password, with: @roz.password
    click_button "Log In"
  end

  describe 'When i visit an order show page from my dashboard' do
    it "I see the recipients name and address that was used to
    create this order" do
      within id="#order-#{@order_1.id}" do
        click_link "#{@order_1.id}"
      end
      expect(page).to have_content(@order_1.name)
      expect(page).to have_content(@order_1.address)
    end

    it "I only see the items in the order that are bieng purchased
    from my merchant" do

      visit "/merchant/orders/#{@order_1.id}"

      within id="#item-#{@item_order_1.item_id}" do
        expect(page).to have_link(@item_order_1.item.name)
        expect(page).to have_xpath("//img[@src='#{@item_order_1.item.image}']")
        expect(page).to have_content(@item_order_1.price)
        expect(page).to have_content(@item_order_1.quantity)
      end

      within id="#item-#{@item_order_2.item_id}" do
        expect(page).to have_link(@item_order_2.item.name)
        expect(page).to have_xpath("//img[@src='#{@item_order_2.item.image}']")
        expect(page).to have_content(@item_order_2.price)
        expect(page).to have_content(@item_order_2.quantity)
      end

      expect(page).to_not have_css("#item-#{@dog_bone.id}")
    end

    it "If the user's desired quantity is equal to or less than my current inventory quantity for that item
    And I have not already 'fulfilled' that item" do

      visit "/merchant/orders/#{@order_1.id}"
      expect(@tire.inventory).to eq(12)

      within id="#item-#{@item_order_1.item_id}" do
        click_button 'fulfill'
      end

      expect(page).to have_content("Item has been fulfilled")

      within id="#item-#{@item_order_2.item_id}" do
        expect(page).to_not have_button('fulfill')
        expect(page).to have_content("Item has already been fulfilled")
      end

      @tire.reload
      expect(@tire.inventory).to eq(10)
    end

    it "I  do not see a 'fulfill' button or link
    Instead I see a notice next to the item indicating I cannot fulfill this item" do
    @tire.update(inventory: 1)
    visit "/merchant/orders/#{@order_1.id}"
    save_and_open_page
      within id="#item-#{@item_order_1.item_id}" do
        expect(page).to have_content('Item cannot be fulfilled')
      end
    end
  end
end
