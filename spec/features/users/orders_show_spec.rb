require "rails_helper"

describe "As a registered user" do
  describe "When I visit my Profile Orders page, '/profile/orders'" do
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
      @order = Order.last
    end
    it "I see ever order w/ id, date order was made and updated, status, total quantity and grand total" do
      visit '/profile/orders'

      expect(page).to have_content(@order.id)
      expect(page).to have_content(@order.created_at)
      expect(page).to have_content(@order.updated_at)
      expect(page).to have_content(@order.status)
      expect(page).to have_content(@order.quantity)
      expect(@order.quantity).to eq(2)
      expect(page).to have_content(@order.grandtotal)
      expect(@order.grandtotal).to eq(22)
    end
    it "Has a link for each order directing to that specific orders show page" do
      visit '/profile/orders'
      expect(page).to have_link("View Order")

      click_link("View Order")
      expect(current_path).to eq("/profile/orders/#{@order.id}")
      save_and_open_page
    end
  end
end
