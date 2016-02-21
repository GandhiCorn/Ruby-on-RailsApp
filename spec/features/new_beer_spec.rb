
require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "can be added with a name" do
    visit new_beer_path
    fill_in('beer[name]', with:'Bisseys')
#    select('Koff', from:'beer[brewery_id]')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end
  
  it "can't be added without a name" do
    visit new_beer_path

    click_button "Create Beer"
    
    expect(page).to have_content "Name can't be blank"
    expect(Beer.count).to eq(0)
  end
end