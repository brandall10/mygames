require 'rails_helper'

RSpec.describe 'user flows', type: :request do
  before { visit '/' }

  it 'displays list of categories and search bar on homepage' do
    expect(page).to have_content 'Categories'
    expect(page).to have_content 'Search Games'
    expect(page).to have_selector('.category', count: 13)
  end

  it 'searches for games' do
    page.fill_in 'Search Games', with: 'the'
    page.click_on 'Search'

    expect(page).to have_selector('.game', count: 5)
  end

  it 'shows category' do
    within first('.category') do
      click_link 'Show'
    end

    expect(page).to have_selector('.game', count: 5)
  end

  it 'downloads category' do
    within first('.category') do
      click_link 'Download'
    end

    expect(page.response_headers['Content-Disposition']).to include 'Action Adventure.zip'
  end

  it 'creates category' do
    page.click_on 'New Category'
    page.fill_in 'Name', with: 'Chuck Norris Games'
    page.click_on 'Create Category'

    expect(page).to have_content 'Category was successfully created'
  end

  it 'deletes empty category' do
    categories = page.all('.category')

    within(categories[10]) do
      click_link 'Destroy'
    end

    expect(page).to have_content 'Category was successfully destroyed.'
  end

  it 'denies deleting category with games' do
    within first('.category') do
      click_link 'Destroy'
    end

    expect(page).to have_content 'Cannot delete record because dependent games exist'
  end

  it 'shows game' do
    within first('.category') do
      click_link 'Show'
    end

    within first('.game') do
      click_link 'Show'
    end

    expect(page).to have_content 'Action Adventure'
    expect(page).to have_content 'The Last of Us'
  end

  it 'creates game' do
    within first('.category') do
      click_link 'Show'
    end

    click_link 'New Game'
    expect(page).to have_content 'New Game'

    page.fill_in 'Title', with: 'Mario Tennis'
    page.fill_in 'Description', with: 'Itsa Maario Tennis!'
    page.fill_in 'Author', with: 'Nintendo'
    page.fill_in 'Status', with: 1

    page.click_on 'Create Game'

    expect(page).to have_content 'Game was successfully created'
  end

  it 'edits game' do
    within first('.category') do
      click_link 'Show'
    end

    within first('.game') do
      click_link 'Edit'
    end

    expect(page).to have_content 'Editing Game'
    page.fill_in 'Title', with: 'New title not same as the old title'

    page.click_on 'Update Game'

    expect(page).to have_content 'Game was successfully updated'
  end

  it 'deletes game' do
    within first('.category') do
      click_link 'Show'
    end

    within first('.game') do
      click_link 'Destroy'
    end
    
    expect(page).to have_content 'Game was successfully destroyed.'
  end
end