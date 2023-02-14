require 'rails_helper'

RSpec.describe "User Log in" do
  
  it 'has a link on the landing page' do 
    
    visit root_path
    click_link "Log In"
    
    expect(current_path).to eq(login_path)
  end
  it 'takes me to the users dashboard after succesfully entering credentials' do
    user = User.create(name: "Stan", email: "StanTheMan123@g.com", password: "test")
    visit login_path

    fill_in :name, with: user.name
    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq(root_path)

    expect(page).to have_content("Welcome, #{user.name}")
  end

  it 'takes me back to the log in page when credentials are incorrect' do
    user = User.create(name: "Stan", email: "StanTheMan123@g.com", password: "test")
    visit login_path

    fill_in :name, with: user.name
    fill_in :email, with: user.email
    fill_in :password, with: "tess"

    click_on "Log In"

    expect(current_path).to eq(login_path)

    expect(page).to have_content("Password incorrect")
  end
end