require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:beer1) { FactoryGirl.create :beer, name:"iso 3", brewery:brewery }
  let!(:beer2) { FactoryGirl.create :beer, name:"Karhu", brewery:brewery }
  let!(:user) { FactoryGirl.create :user }

  it "when select's are filled and Beer name is typed, Beer is created" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    select('IPA', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')
    fill_in('beer[name]', with:'Koff IV')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(2).to(3)
  end

  it "browser shows correct error message and beer is not saved when name is empty" do
    sign_in(username:"Pekka", password:"Foobar1")
    visit new_beer_path
    select('IPA', from:'beer[style]')
    select('Koff', from:'beer[brewery_id]')
    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
  end
end