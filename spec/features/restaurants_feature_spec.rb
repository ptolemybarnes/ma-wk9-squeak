feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants'
      expect(page).to have_link    'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'The Fat Duck')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('The Fat Duck')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating a restaurant' do
    scenario 'prompts user to fill out a form, then display the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'The Fat Duck'
      click_button 'Create Restaurant'
      expect(page).to have_content 'The Fat Duck'
      expect(current_path).to eq  '/restaurants'
    end
  end

  context 'viewing restaurants' do

    let!(:tfd) { Restaurant.create(name:'The Fat Duck')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'The Fat Duck'
      expect(page).to have_content 'The Fat Duck'
      expect(current_path).to eq "/restaurants/#{tfd.id}"
    end
  end

  context 'editing restaurants' do
    before {Restaurant.create name: 'The Fat Duck'}

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link "Edit The Fat Duck"
      fill_in 'Name', with: "The Fat Squirrel"
      click_button 'Update Restaurant'
      expect(page).to have_content 'The Fat Squirrel'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before {Restaurant.create name: 'Hummus Bros'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Hummus Bros'
      expect(page).not_to have_content 'Hummus Bros'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end
end

