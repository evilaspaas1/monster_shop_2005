require "rails_helper"

describe "As an admin" do
  describe "When I visit the merchant's index page at '/admin/merchants'" do
    before :each do
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

      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, active_status: true)
      @dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210, active_status: false)

    end
    it "I see some merchant info and a enable or disable button" do
      visit "/admin/merchants"

      within "#merchant-#{@bike_shop.id}" do
        expect(page).to have_link(@bike_shop.name)
        expect(page).to have_content(@bike_shop.state)
        expect(page).to have_content(@bike_shop.city)
        expect(page).to have_button("Disable")
        click_link "#{@bike_shop.name}"
      end

      expect(current_path).to eq("/admin/merchants/#{@bike_shop.id}")
      visit "/admin/merchants"

      within "#merchant-#{@dog_shop.id}" do
        expect(page).to have_link(@dog_shop.name)
        expect(page).to have_content(@dog_shop.state)
        expect(page).to have_content(@dog_shop.city)
        expect(page).to have_button("Enable")
        click_link "#{@dog_shop.name}"
      end

      expect(current_path).to eq("/admin/merchants/#{@dog_shop.id}")
    end
  end
end
