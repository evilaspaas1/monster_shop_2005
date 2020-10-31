require "rails_helper"

describe "As a registered user" do
  describe "When I visit my Profile Orders page" do
    before :each do
      @fred = User.create(name: "Fred Savage",
                           address: "666 Devil Ave",
                           city: "Mesatown",
                           state: "AZ",
                           zip: '80085',
                           email: "rando@gmail.com",
                           password: "test",
                           role: 0)
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)


      visit "/login"

      fill_in :email, with: @fred.email
      fill_in :password, with: @fred.password
      click_button "Log In"

      visit "/items/#{@paper.id}"
      click_on "Add To Cart"

      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"

      within 'nav' do
        click_link("Cart: 2")
      end
      click_link "Checkout"

      fill_in :name, with: @fred.name
      fill_in :address, with: @fred.address
      fill_in :city, with: @fred.city
      fill_in :state, with: @fred.state
      fill_in :zip, with: @fred.zip

      click_button "Create Order"
      @order = Order.first
      @paper_order = ItemOrder.where(item_id: @paper.id)
      @pencil_order = ItemOrder.where(item_id: @pencil.id)

      visit "/profile/orders/#{@order.id}"
    end

    it "I see all information about the order: id, created date, updated date, status, each item (with name, description, thumbnail, quantity, price and subtotal), total quantity of items and grand total" do

      within "#item-#{@paper.id}"do
        expect(page).to have_content(@paper.name)
        expect(page).to have_content(@paper.description)
        expect(page).to have_xpath("//img[@src='#{@paper.image}']")
        expect(page).to have_content(@paper.price)
        expect(page).to have_content(@paper_order.first.subtotal)
        expect(page).to have_content(@paper_order.first.quantity)
      end

      within "#item-#{@pencil.id}"do
      expect(page).to have_content(@pencil.name)
      expect(page).to have_content(@pencil.description)
      expect(page).to have_xpath("//img[@src='#{@pencil.image}']")
      expect(page).to have_content(@pencil.price)
      expect(page).to have_content(@pencil_order.first.subtotal)
      expect(page).to have_content(@pencil_order.first.quantity)
      end
      expect(page).to have_content(@order.quantity)
      expect(page).to have_content(@order.grandtotal)
    end
  end
end
