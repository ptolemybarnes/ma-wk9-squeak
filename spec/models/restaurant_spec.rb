require 'spec_helper'

describe Restaurant, :type => :model do

  let!(:user) { create(:user) } 

  context 'is invalid ' do
    it 'with a name of less than three characters' do
      restaurant = user.restaurants.create(name: "kf")
      expect(restaurant).not_to be_valid
    end

    it 'unless it has a unique name' do
      user.restaurants.create(name: "Moe's Tavern")
      restaurant = user.restaurants.create(name: "Moe's Tavern")
      expect(restaurant).to have(1).error_on(:name)
    end

    it 'unless it has an author' do
      restaurant = Restaurant.create(name: 'The Spinning Plate', rating: 1, stars: 5)
      expect(restaurant.valid?).to eq(false)
    end

  end

  context 'is valid' do

    it 'when it has an author' do
      restaurant = user.restaurants.create(name: 'Duke of Wellington', rating: 3, stars: 5)
      expect(restaurant.valid?).to eq(true)
    end

  end

  describe '#average_rating' do

      let(:restaurant) { create(:restaurant, name: 'The Ivy', 
                                user: create(:user, email: 'user@hotmail.com'))}

    context 'when there are no reviews' do

      it "returns 'N/A'" do
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context 'when there are reviews' do

      it "returns the average" do
        create(:review, restaurant: restaurant, rating: 3 ) 
        create(:review, restaurant: restaurant, rating: 1 )

        expect(restaurant.average_rating).to eq 2
      end
    end
  end
end

