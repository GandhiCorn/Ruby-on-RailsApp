require 'rails_helper'

RSpec.describe Beer, type: :model do
  let(:style){ FactoryGirl.create(:style) }
  
  it "is saved with proper details" do
    beer = Beer.create name:"Koe", style:style

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end
  
  it "is not saved without a name" do
    beer = Beer.create style:style

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
  
  it "is not saved without a style" do
    beer = Beer.create name:"bisse"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end