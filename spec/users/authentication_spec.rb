require 'rails_helper'

describe "Logging In" do
  it "logs the user in and goest to the todo lists" do
    user = create(:user)
    visit "/"
    click_link "Sign IN"
    fill_in "Email Address", with: user.email
    fill_in "Password", with: "password"
    click_button "Sign In"

    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in")
  end

  it "displays the email address in the event of a failed login" do
    visit new_user_session_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: "incorrect"
    click_button "Sign In"

    expect(page).to have_content("Please check your email and password")
    expect(page).to have_field("Email Address", with: user.email)
  end
end
