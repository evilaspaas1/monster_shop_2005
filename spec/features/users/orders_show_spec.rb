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

        
      @order = Order.last
      binding.pry
    end
    it "I see ever order w/ id, date order was made and updated, status, total quantity and grand total" do
      visit '/profile/orders'
binding.pry
      expect(page).to have_content(order.id)
      expect(page).to have_content()
      expect(page).to have_content()
      expect(page).to have_content()
      expect(page).to have_content()
      expect(page).to have_content()
    end
  end

end
