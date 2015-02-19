feature 'restaurants' do

  let!(:user) { create_user } 

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link    'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      user.restaurants.create(name: 'The Fat Duck')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('The Fat Duck')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating a restaurant' do
    scenario 'prompts user to fill out a form, then display the new restaurant' do
      user
      sign_in
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'The Fat Duck'
      click_button 'Create Restaurant'
      expect(page).to have_content 'The Fat Duck'
      expect(current_path).to eq  '/restaurants'
    end

    context 'is invalid when' do

      scenario 'submitted name is too short' do
        sign_in
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end

    end
  end

  context 'viewing restaurants' do

    let!(:tfd) { user.restaurants.create(name:'The Fat Duck')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'The Fat Duck'
      expect(page).to have_content 'The Fat Duck'
      expect(current_path).to eq "/restaurants/#{tfd.id}"
    end

  end

  context 'editing restaurants' do
    before { user.restaurants.create name: 'The Fat Duck' }

    scenario 'let a user edit a restaurant' do
      sign_in
      visit '/restaurants'
      click_link "Edit The Fat Duck"
      fill_in 'Name', with: "The Fat Squirrel"
      click_button 'Update Restaurant'
      expect(page).to have_content 'The Fat Squirrel'
      expect(current_path).to eq '/restaurants'
    end

    scenario 'not allowed if user is not author' do
      user = User.new(email: 'stevejobs@apple.com', password: 'imstevejobsyo',
                      password_confirmation: 'imstevejobsyo')
      user.save
      visit '/restaurants'
      click_link 'Sign in'
      fill_in 'Email', with: user.email 
      fill_in 'Password', with: 'imstevejobsyo'  
      click_button 'Log in'

      click_link 'Edit The Fat Duck'
      expect(page).to have_content 'Error:'
    end
  end

  context 'deleting restaurants' do
    before { user.restaurants.create name: 'Hummus Bros'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_in
      visit '/restaurants'
      click_link 'Delete Hummus Bros'
      expect(page).not_to have_content 'Hummus Bros'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'retaurants can be created' do

    scenario 'only when user is logged in' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(page).to have_content('Log in')
    end
  end

  def sign_in
    visit '/restaurants'
    click_link 'Sign in'
    fill_in 'Email', with: 'example@test.com'
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

end


