require 'rails_helper'

feature 'I can endorse reviews' do

  before do
    rest = create(:restaurant, name: 'Spaghetti Monster')
    create(:review, restaurant: rest, thoughts: 'Omnishambles')
  end

  scenario "which updates the review's endorsement count" do
    visit '/restaurants'
    click_link 'Endorse this review of Spaghetti Monster'
    expect(page).to have_content('1 Endorsement')
  end
end


