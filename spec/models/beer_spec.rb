require 'rails_helper'

RSpec.describe Beer, type: :model do
it "is saved with proper style and name" do
	beer = Beer.create name: "olut", style: "IPA"

      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
  end

  it "is not saved without name" do
  	beer = Beer.create style: "IPA"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end

  it "is not saved without style" do
  	beer = Beer.create name: "nimi"

  	expect(beer).not_to be_valid
  	expect(Beer.count).to eq(0)
  end
end
