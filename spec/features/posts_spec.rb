require 'rails_helper'

feature 'Posts' do
  scenario 'Displaying the posts on the homepage', js: true do
    post_1 = create :post
    post_2 = create :post

    visit root_path

    expect(page).to have_content post_1.title
    expect(page).to have_content post_2.title
  end

  scenario 'Displaying the post detail page', js: true do
    post = create :post

    visit root_path
    click_on post.title

    expect(page).to have_content 'comments'
    expect(page).to have_content(post.title), 'Not implemented yet. Implement as part of task 2.'
    expect(page).to have_content(post.tagline), 'Not implemented yet. Implement as part of task 2.'
  end
end
