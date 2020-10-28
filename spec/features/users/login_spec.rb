require "rails_helper"

describe "as a visitor" do
  describe "When I visit the login path" do
    it "I see a form to login and am redirected to '/profile' if im a default user" do
      #regular user
      fred = User.create(name: "Fred Savage",
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

      expect(current_path).to eq("/login")

      fill_in :email, with: fred.email
      fill_in :password, with: fred.password
      click_button "Log In"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("Logged in as #{fred.name}")
    end
    it "I see a form to login and am redirected to '/merchant' if im an employee" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      roz = bike_shop.users.create(name: "Roz Peterson",
                         address: "Monster Inc.",
                         city: "Monster Town",
                         state: "Monster State",
                         zip: '80000',
                         email: "fright@gmail.com",
                         password: "test",
                         role: 1)
      visit root_path

      within "nav" do
        click_link "Log In"
      end

      expect(current_path).to eq("/login")

      fill_in :email, with: roz.email
      fill_in :password, with: roz.password
      click_button "Log In"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("Logged in as #{roz.name}")
    end
    it "I see a form to login and am redirected to '/admin' if i'm an admin" do
      tim = User.create(name: "Tim",
                         address: "Ya Hate To See It Dr.",
                         city: "Denver",
                         state: "CO",
                         zip: '80205',
                         email: "tim@gmail.com",
                         password: "test",
                         role: 2)

     visit root_path

     within "nav" do
       click_link "Log In"
     end

     expect(current_path).to eq("/login")

     fill_in :email, with: tim.email
     fill_in :password, with: tim.password
     click_button "Log In"

     expect(current_path).to eq("/admin")
     expect(page).to have_content("Logged in as #{tim.name}")
    end

    it "Will display a flash message if i try and login with wrong info" do
      fred = User.create(name: "Fred Savage",
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

      expect(current_path).to eq("/login")

      fill_in :email, with: "funbucket13@gmail.com"
      fill_in :password, with: fred.password
      click_button "Log In"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Either email or password were incorrect")
    end
    it "Will let a default user know if they are alredy logged in" do
      fred = User.create(name: "Fred Savage",
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

      expect(current_path).to eq("/login")

      fill_in :email, with: fred.email
      fill_in :password, with: fred.password
      click_button "Log In"

      visit "/login"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are already logged in!")
    end
    it "Will let a employee user know if they are alredy logged in" do
      bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      roz = bike_shop.users.create(name: "Roz Peterson",
                         address: "Monster Inc.",
                         city: "Monster Town",
                         state: "Monster State",
                         zip: '80000',
                         email: "fright@gmail.com",
                         password: "test",
                         role: 1)

      visit root_path

      within "nav" do
        click_link "Log In"
      end

      expect(current_path).to eq("/login")

      fill_in :email, with: roz.email
      fill_in :password, with: roz.password
      click_button "Log In"

      visit "/login"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("You are already logged in!")
    end
    it "Will let a admin user know if they are alredy logged in" do
      tim = User.create(name: "Tim",
                         address: "Ya Hate To See It Dr.",
                         city: "Denver",
                         state: "CO",
                         zip: '80205',
                         email: "tim@gmail.com",
                         password: "test",
                         role: 2)

      visit root_path

      within "nav" do
        click_link "Log In"
      end

      expect(current_path).to eq("/login")

      fill_in :email, with: tim.email
      fill_in :password, with: tim.password
      click_button "Log In"

      visit "/login"

      expect(current_path).to eq("/admin")
      expect(page).to have_content("You are already logged in!")
    end
  end
end
