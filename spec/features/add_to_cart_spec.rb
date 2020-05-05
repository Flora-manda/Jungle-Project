require 'rails_helper'

RSpec.feature "Visitor can add to cart", type: :feature, js: true do

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

  scenario "They see cart updated with total number added" do
    # ACT
    visit root_path

    #Get all products in page
    product = Product.all.sample

    #Expect to find product in page
    expect(page).to have_text(product.name)

    click_button("Add")

    expect(page).to have_text("My Cart (1)")

    save_screenshot "clicked_after_add_to_cart.png"
    
  end
end