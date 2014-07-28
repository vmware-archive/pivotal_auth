require 'spec_helper'

describe "logging in" do
  it "sends you to the root page" do
    visit '/login'
    click_link 'Okta'
    expect(page).to have_content 'You are signed in as user@test.com'
  end

  it 'takes you to /login when you log out' do
    visit '/login'
    click_link 'Okta'
    click_link 'Sign out'
    expect(page).to have_content 'Please log in'
  end
end
