require "rails_helper"

describe "Root page"do
  it "Has a nav bar" do
    visit '/'

    expect(page).to have_css('.topnav')
  end
end
