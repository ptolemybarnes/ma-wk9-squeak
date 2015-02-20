feature 'Reviewing' do

  scenario 'I can review a restaurant I created the entry for' do
    mamathai = create(:restaurant, name: 'Mama Thai') 
    sign_in_as(mamathai.user)

    visit '/restaurants'
    click_link 'Review Mama Thai'
    fill_in 'Thoughts', with: "Some things in life I will never get thai'd of..."
    select '3', from: 'Rating'
    click_button 'Squeak squeak!'

    expect(current_path).to eq('/restaurants')
    expect(page).to have_content("Some things in life I will never get thai'd of...")
  end

  context 'I can see reviews of a restaurant' do

    scenario 'include the average rating of a restaurant' do
      pizza_palace = create(:restaurant, name: 'Pizza Palace', user: create(:user))
      create(:review, rating: 3, restaurant: pizza_palace)
      create(:review, rating: 5, restaurant: pizza_palace)

      visit '/restaurants'

      expect(page).to have_content('Average Rating: 4')
    end
  end
end
