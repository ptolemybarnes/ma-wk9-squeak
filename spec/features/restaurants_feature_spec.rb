feature 'Restaurants' do

  context 'when I am on the restaurants page' do

    scenario 'I see a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link    'Add a restaurant'
    end

  end

  context 'when restaurants have been added' do
    before do
      create(:restaurant, name: 'The Fat Duck')
    end

    scenario 'I can see restaurant information' do
      visit '/restaurants'
      expect(page).to have_content('The Fat Duck')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'when I want to create a restaurant' do
 
    before do
      user = create(:user)
      sign_in_as(user)
    end

    scenario 'I fill out a form, then I see the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'The Fat Duck'
      click_button 'Create Restaurant'

      expect(page).to have_content 'The Fat Duck'
      expect(current_path).to eq  '/restaurants'
    end

    scenario 'I see an error message if I input a short name' do
      visit '/restaurants'

      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'

      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end

    scenario 'I have to be logged in to do so' do
      visit '/restaurants'
      click_link 'Sign out'

      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content('Log in')
    end

  end

  context 'when I want to see restaurant information' do

    scenario 'I can click on individual restaurants' do 
      restaurant = create(:restaurant, name: 'The Fat Duck')
      visit '/restaurants'

      click_link 'The Fat Duck'

      expect(page).to have_content 'The Fat Duck'
      expect(current_path).to eq "/restaurants/#{restaurant.id}"
    end

  end

  context 'when I want to edit a restaurant' do
    
    scenario 'I can access a form to do so' do
      user       = create(:user, email: 'example@email.com' )
      restaurant = create(:restaurant, name: 'Flying Dutchman', user: user)
      sign_in_as(user)

      visit '/restaurants'
      click_link "Edit Flying Dutchman"
      fill_in 'Name', with: "The Fat Squirrel"
      click_button 'Update Restaurant'

      expect(page).to have_content 'The Fat Squirrel'
      expect(current_path).to eq '/restaurants'
    end

    scenario "I can't if I'm not the author" do
      user     = create(:user, email: 'anotherexample@email.com')
      new_user = create(:user, email: 'superuser@gmail.com')
      create(:restaurant, name: 'Sunny Picnic', user: user)
      
      sign_in_as(new_user)
      visit '/restaurants'

      click_link 'Edit Sunny Picnic'
      expect(page).to have_content 'Error:'
    end
  end

  context 'when I want to delete a restaurant' do

    scenario 'I can click delete and have it removed' do
      user       = create(:user)
      restaurant = create(:restaurant, user: user, name: 'Hummus Bros')
      
      sign_in_as(user)
      visit '/restaurants'
      click_link 'Delete Hummus Bros'

      expect(page).not_to have_content 'Hummus Bros'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

    scenario 'I see an error if I try to delete a restaurant I did not author' do
      user     = create(:user)
      create(:restaurant, name: 'The Jolly Sailor', user: user)
      new_user = create(:user, email: "john@email.com")

      sign_in_as(new_user)
      visit '/restaurants'
      click_link 'Delete The Jolly Sailor'

      expect(page).to have_content 'Error:'
    end
  end

  def sign_in_as(user)
    visit '/restaurants'
    click_link 'Sign in'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end

end


