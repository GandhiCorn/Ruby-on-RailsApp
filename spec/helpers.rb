
module Helpers

	require 'simplecov'
	SimpleCov.start('rails')

  def sign_in(credentials)
    visit signin_path
    fill_in('username', with:credentials[:username])
    fill_in('password', with:credentials[:password])
    click_button('Log in')
  end

  def create_n_random_ratings(user, n)
    n.times do
      beer = Beer.where(id: rand(1...Beer.count)).first
      FactoryGirl.create(:rating, score:rand(1..50), beer:beer, user:user)
    end
  end

  def create_n_random_beers(n)
    n.times do
      style = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"].sample
      FactoryGirl.create(:beer, style:style)
    end
  end

  def create_n_random_beers_with_breweries(n)
    n.times do
      brewery = Brewery.all.sample
      beer = Beer.where(id: rand(1...Beer.count)).first
      FactoryGirl.create(:beer, brewery: brewery)
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
end