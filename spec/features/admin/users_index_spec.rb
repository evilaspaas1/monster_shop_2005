require "rails_helper"

describe "As an admin" do
  describe "When I click the 'All Users' link in the nav" do
    before :each do
      @fred = User.create(name: "Fred Savage",
                         address: "666 Devil Ave",
                         city: "Mesatown",
                         state: "AZ",
                         zip: '80085',
                         email: "rando@gmail.com",
                         password: "test",
                         role: 0)

     @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203, active_status: true)

     @roz = @bike_shop.users.create(name: "Roz Peterson",
                                  address: "Monster Inc.",
                                  city: "Monster Town",
                                  state: "Monster State",
                                  zip: '80000',
                                  email: "fright@gmail.com",
                                  password: "test",
                                  role: 1)


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
    it "I can see all users in the system with their name, register date, and what type of user they are" do
      click_link "All Users"

      expect(current_path).to eq("/admin/users")

      within "#user-#{@fred.id}" do
        expect(page).to have_link(@fred.name)
        expect(page).to have_content(@fred.created_at)
        expect(page).to have_content(@fred.role)
        click_link "#{@fred.name}"
      end

      expect(current_path).to eq("/admin/users/#{@fred.id}")
      click_link "All Users"

      within "#user-#{@roz.id}" do
        expect(page).to have_link(@roz.name)
        expect(page).to have_content(@roz.created_at)
        expect(page).to have_content(@roz.role)
        click_link "#{@roz.name}"
      end

      expect(current_path).to eq("/admin/users/#{@roz.id}")
      click_link "All Users"

      within "#user-#{@tim.id}" do
        expect(page).to have_link(@tim.name)
        expect(page).to have_content(@tim.created_at)
        expect(page).to have_content(@tim.role)
        click_link "#{@tim.name}"
      end

      expect(current_path).to eq("/admin/users/#{@tim.id}")
    end
  end
end
