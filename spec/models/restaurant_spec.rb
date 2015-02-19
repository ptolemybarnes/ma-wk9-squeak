require 'spec_helper'

describe Restaurant, :type => :model do

  let!(:user) { create_user } 

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

  def create_user
     user = User.new(email: 'example@test.com', password: 'password',
                         password_confirmation: 'password')
     user.save
     user 
  end

end

