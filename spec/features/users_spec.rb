
require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can signin with right credentials" do
      sign_in(username:"Pekka", password:"Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      sign_in(username:"Pekka", password:"wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path
    fill_in('user_username', with:'Brian')
    fill_in('user_password', with:'Secret55')
    fill_in('user_password_confirmation', with:'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  it "we can see ratings from the user's page" do
      user = User.first
      create_n_random_breweries(3)
      create_n_random_beers_with_breweries(10)
      create_n_random_ratings(user, 5)
      visit user_path(user)
      user.ratings do |r|
        expect(page).to have_content "#{r.name}"
      end
  end

  #Tee testi, joka varmistaa että käyttäjän poistaessa oma reittauksensa, se poistuu tietokannasta.
  it "when user deletes a rating, it is removed from the db also" do
    sign_in(username:"Pekka", password:"Foobar1")
    user = User.first
    create_n_random_breweries(3)
    create_n_random_beers_with_breweries(10)
    create_n_random_ratings(user, 5)
    visit user_path(user)
    click_link("delete", :match => :first)
    expect(user.ratings.count).to eq(4)
  end

  it "shows the users favourite brewery correctly" do
    user = User.first
    create_n_random_breweries(3)
    create_n_random_beers_with_breweries(10)
    create_n_random_ratings(user, 5)
    visit user_path(user)
    expect(page).to have_content "Favourite Brewery: #{user.favorite_brewery.name}"
  end

  it "shows the users favourite beer style correctly" do
    user = User.first
    create_n_random_breweries(3)
    create_n_random_beers_with_breweries(10)
    create_n_random_ratings(user, 5)
    visit user_path(user)
    expect(page).to have_content "Favourite Beer Style: #{user.favorite_style}"
  end
end