require 'rails_helper'

RSpec.feature "Visitor navigates to product detail page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    1.times do |n|
      @p = @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see product detail" do
    # ACT
    visit root_path

    #Get all products in page
    product = Product.all.sample

    #Expect to find product in page
    expect(page).to have_text(product.name)

    #Find specific path in page
    product_article_elt = page.find(:xpath, '//a/h4', text: product.name)

    #Click on specific path
    product_article_elt.click

    save_screenshot 'clicked_before_expect.png'

    expect(page).to have_selector 'section.products-show'

    expect(page).to have_text product.name

    save_screenshot 'clicked_after_expect.png'
  end
end