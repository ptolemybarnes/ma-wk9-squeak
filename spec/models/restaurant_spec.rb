require 'spec_helper'

describe Restaurant, :type => :model do
  
  it 'is invalid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).not_to be_valid
  end
end

