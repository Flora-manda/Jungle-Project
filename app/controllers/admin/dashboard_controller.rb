class Admin::DashboardController < ApplicationController
  def show
  end

  def product_count
    Product.count(:all)
  end
  helper_method :product_count

  def category_count
    Category.count(:all)
  end
  helper_method :category_count
  
end
