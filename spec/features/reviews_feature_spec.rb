feature 'reviewing' do
  let!(:mamathai) { create_user.restaurants.create name: 'Mama Thai' }

  scenario 'users can leave a review' do
    visit '/restaurants'
    click_link 'Review Mama Thai'
    fill_in 'Thoughts', with: "Some things in life I will never get thai'd of..."
    select '3', from: 'Rating'
    click_button 'Squeak squeak!'

    expect(current_path).to eq('/restaurants')
    expect(page).to have_content("Some things in life I will never get thai'd of...")
  end

  def create_user
     user = User.new(email: 'example@test.com', password: 'password',
                         password_confirmation: 'password')
     user.save
     user 
  end
 

end
