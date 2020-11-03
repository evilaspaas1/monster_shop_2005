require "rails_helper"

describe "As an admin" do
  describe "When I visit my admin merchant page" do
    before :each do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

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
    it "There is a button called 'Disable' next to any merchant not yet disabled. Afler clicking, returened to admin/merchant page w/ flash message 'Merchant now Disabled' " do

      visit '/admin/merchants'

      within "#merchant-#{@mike.id}" do
        expect(page).to have_content(@mike.name)
        expect(@mike.active_status).to eq(true)
        expect(page).to have_button("Disable")
      end

      click_button "Disable"

      @mike.reload

      within "#merchant-#{@mike.id}" do
        expect(current_path).to eq('/admin/merchants')
        expect(@mike.active_status).to eq(false)
      end
      expect(page).to have_content("Merchant #{@mike.name} is now Disabled")
    end
  end
end
