describe Review, :type => :model do
  
  let!(:user) { create_user }

  it "should be deleted if the restaurant is deleted" do
    restaurant = user.restaurants.create(id: 1, name: 'Pret', rating: '1', stars: '1', description: 'sucks')
    restaurant.reviews.create(thoughts: 'sucks', rating: '1')
    restaurant.destroy
    expect(restaurant.reviews.empty?).to eq true
  end

  it "is invalid if the rating is more than five" do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end
  
  def create_user
     user = User.new(email: 'example@test.com', password: 'password',
                         password_confirmation: 'password')
     user.save
     user 
  end

end
