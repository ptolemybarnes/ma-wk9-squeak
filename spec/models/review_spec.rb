describe "review" do

  it "should be deleted if the restaurant is deleted" do
    restaurant = Restaurant.create(id: 1, name: 'Pret', rating: '1', stars: '1', description: 'sucks')
    restaurant.reviews.create(thoughts: 'sucks', rating: '1')
    restaurant.destroy
    expect(restaurant.reviews.empty?).to eq true
  end

end