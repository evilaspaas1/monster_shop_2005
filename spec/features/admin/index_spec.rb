require "rails_helper"

describe "As an admin" do
  describe "When I visit my admin dashboard ('/admin')" do
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


      @order1 = @fred.orders.create!(name: @fred.name, address: @fred.address, city: @fred.city, state: @fred.state, zip: @fred.zip, status: "pending")
      @order2 = @fred.orders.create!(name: "Brian", address: @fred.address, city: @fred.city, state: @fred.state, zip: @fred.zip, status: "packaged")
      @order3 = @fred.orders.create!(name: "Tim", address: @fred.address, city: @fred.city, state: @fred.state, zip: @fred.zip, status: "shipped")
      @order4 = @fred.orders.create!(name: "Alex", address: @fred.address, city: @fred.city, state: @fred.state, zip: @fred.zip, status: "cancelled")
      @tim = User.create(name: "Tim",
                         address: "Ya Hate To See It Dr.",
                         city: "Denver",
                         state: "CO",
                         zip: '80205',
                         email: "tim@gmail.com",
                         password: "test",
                         role: 2)
                         visit "/login"

       fill_in :email, with: @tim.email
       fill_in :password, with: @tim.password
       click_button "Log In"
    end
    it "I see all orders in the system with user who place the order, the order id, and date created" do
      expect(page).to have_content("Order id: #{@order1.id}")
      expect(page).to have_content("Users Name: #{@order1.name}")
      expect(page).to have_content("Date Created: #{@order1.created_at}")

      expect("#{@order2.id}").to appear_before("#{@order1.id}")
      expect("#{@order1.id}").to appear_before("#{@order3.id}")
      expect("#{@order3.id}").to appear_before("#{@order4.id}")
      expect("#{@order4.id}").to_not appear_before("#{@order2.id}")
    end

    it "admin can 'ship' an order" do
      within "#order-#{@order2.id}" do
        click_button "Ship"
      end

      expect(current_path).to eq(admin_path)

      @order2.reload
      expect(@order2.status).to eq("shipped")

      expect(page).to_not have_css("#packaged-#{@order2.id}")

      visit '/profile/orders'

      within "#Order-#{@order2.id}" do
        expect(page).to_not have_link("Cancel order")
      end
    end
  end
end
