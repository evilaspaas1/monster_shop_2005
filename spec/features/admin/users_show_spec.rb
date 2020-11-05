require "rails_helper"

describe "as an admin" do
  describe "When I visit a user's profile page" do
    before(:each) do
      @fred = User.create(name: "Fred Savage",
                   address: "666 Devil Ave",
                   city: "Mesatown",
                   state: "AZ",
                   zip: '80085',
                   email: "rando@gmail.com",
                   password: "test",
                   role: 0)
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

    it "I see the same information the user would see themselves except an edit profile link" do

      visit "/admin/users"

      within "#user-#{@fred.id}" do
        expect(page).to have_link(@fred.name)
        expect(page).to have_content(@fred.created_at)
        expect(page).to have_content(@fred.role)
        click_link "#{@fred.name}"
      end

      expect(page).to have_content("Fred Savage")
      expect(page).to have_content("666 Devil Ave")
      expect(page).to have_content("Mesatown")
      expect(page).to have_content("AZ")
      expect(page).to have_content("80085")
      expect(page).to have_content("rando@gmail.com")
    end
  end
end
