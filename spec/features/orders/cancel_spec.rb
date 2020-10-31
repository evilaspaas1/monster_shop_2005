require "rails_helper"

describe "user cancels order" do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@paper.id}"
    click_on "Add To Cart"
    visit "/items/#{@tire.id}"
    click_on "Add To Cart"
    visit "/items/#{@pencil.id}"
    click_on "Add To Cart"

    @fred = User.create(name: "Fred Savage",
                 address: "666 Devil Ave",
                 city: "Mesatown",
                 state: "AZ",
                 zip: '80085',
                 email: "rando@gmail.com",
                 password: "test",
                 role: 0)

    visit root_path

    within "nav" do
      click_link "Log In"
    end

    fill_in :email, with: "rando@gmail.com"
    fill_in :password, with: @fred.password
    click_button "Log In"

    visit "/cart"
    click_on "Checkout"

    name = "Bert"
    address = "123 Sesame St."
    city = "NYC"
    state = "New York"
    zip = 10001

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button "Create Order"
  end

  it "Order page has a cancel link that updates the status of the orders
  and returns me back to the profile page" do
    visit '/profile/orders'

    new_order = Order.last

    within(id="#Order-#{new_order.id}") do
      click_link "Cancel order"
    end

    expect(page).to have_content('Order is now cancelled')

    visit '/profile/orders'
    
    within(id="#Order-#{new_order.id}") do
      expect(page).to have_content('Current Status: cancelled')
    end
  end
end
