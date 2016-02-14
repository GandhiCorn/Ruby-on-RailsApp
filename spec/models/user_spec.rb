require 'rails_helper'

RSpec.describe User, type: :model do

  describe "favorite_brewery" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining the favorite_brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end

    it "method returns nil if there are no ratings" do
      expect(user.favorite_brewery).to eq(nil)
    end

    it "method correct brewery with just 1 brewery" do
      create_n_random_breweries(1)
      create_n_random_beers_with_breweries(10)
      create_n_random_ratings(user, 50)
      expect(user.favorite_brewery).to eq(Brewery.first)
    end

    it "method works with large numbers of random generated data" do
      create_n_random_breweries(5)
      create_n_random_beers_with_breweries(20)
      create_n_random_ratings(user, 50)
      expect(user.favorite_brewery).to be_kind_of(Brewery)
    end
  end

  describe "favorite style" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining the favorite_style" do
      expect(user).to respond_to(:favorite_style)
    end

    it "without ratings for beers, user does not have a favourite style" do
      expect(user.favorite_style).to eq(nil)
    end

    it "selects correct style with premade 2 styles" do
      create_two_beers_with_ratings(user)
      expect(user.favorite_style).to eq("IPA")
    end

    it "does user have a favourite style with rng-data and the style is a string" do
      create_n_random_beers(10)
      create_n_random_ratings(user, 50)
      expect(user.favorite_style).to be_kind_of(String)
    end
  end

  describe "favorite beer" do
    let(:user){FactoryGirl.create(:user)}

    it "has method for determining the favorite_beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      beer = FactoryGirl.create(:beer)
      rating = FactoryGirl.create(:rating, beer:beer, user:user)
      expect(user.favorite_beer).to eq(beer)
    end

    it "is the one with highest rating if several rated" do
      create_beer_with_rating(user, 10)
      best = create_beer_with_rating(user, 25)
      create_beer_with_rating(user, 7)
      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "with a proper password" do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      user.ratings << FactoryGirl.create(:rating)
      user.ratings << FactoryGirl.create(:rating2)

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "will not accept a new user that has a password that is too short" do
    user = User.create username:"Testi", password:"abc", password_confirmation:"abc"
    expect(User.count).to eq(0)
  end

  it "will not save a new user without proper password formatting" do
    user1 = User.create username:"pienillakirjaimilla", password:"abcedfg", password_confirmation:"abcedfg"
    user2 = User.create username:"ilmannumeroa", password:"Abcedfg", password_confirmation:"Abcedfg"
    user3 = User.create username:"ilmancapsia", password:"abcedfg1", password_confirmation:"abcedfg1"

    expect(User.count).to eq(0)
  end

  it "validation has not been succesful" do
    user = User.create username:"Testi", password:"abc", password_confirmation:"abc"
    user1 = User.create username:"pienillakirjaimilla", password:"abcedfg", password_confirmation:"abcedfg"
    user2 = User.create username:"ilmannumeroa", password:"Abcedfg", password_confirmation:"Abcedfg"
    user3 = User.create username:"ilmancapsia", password:"abcedfg1", password_confirmation:"abcedfg1"
    expect(user).not_to be_valid
    expect(user1).not_to be_valid
    expect(user2).not_to be_valid
    expect(user3).not_to be_valid
  end

  def create_beer_with_rating(user, score)
    beer = FactoryGirl.create(:beer)
    FactoryGirl.create(:rating, score:score, beer:beer, user:user)
    beer
  end

  def create_beers_with_ratings(user, *scores)
    scores.each do |score|
      create_beer_with_rating(user, score)
    end
  end

  def create_two_beers_with_ratings(user)
    beer1 = Beer.create(name: "Brewdog IPA3", style:"IPA")
    beer2 = Beer.create(name: "Lapin Pissa III", style:"Lager")
    FactoryGirl.create(:rating, score:30, beer:beer1, user:user)
    FactoryGirl.create(:rating, score:10, beer:beer2, user:user)
  end

  def create_n_random_beers(n)
    n.times do
      style = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"].sample
      FactoryGirl.create(:beer, style:style)
    end
  end

  def create_n_random_breweries(n)
    n.times do
      FactoryGirl.create(:brewery)
    end
  end

  def create_n_random_beers_with_breweries(n)
    n.times do
      brewery = Brewery.all.sample
      beer = Beer.where(id: rand(1...Beer.count)).first
      FactoryGirl.create(:beer, brewery: brewery)
    end
  end

  def create_n_random_ratings(user, n)
    n.times do
      beer = Beer.where(id: rand(1...Beer.count)).first
      FactoryGirl.create(:rating, score:rand(1..50), beer:beer, user:user)
    end
  end


end