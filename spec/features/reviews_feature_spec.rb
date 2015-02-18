feature 'reviewing' do
  let!(:mamathai) {Restaurant.create name: 'Mama Thai' }

  scenario 'users can leave a review' do
    visit '/restaurants'
    click_link 'Review Mama Thai'
    fill_in 'Thoughts', with: "Some things in life I will never get thai'd of..."
    select '3', from: 'Rating'
    click_button 'Squeak squeak!'

    expect(current_path).to eq('/restaurants')
    expect(page).to have_content("Some things in life I will never get thai'd of...")
  end



end
