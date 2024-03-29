#---
# Excerpted from "Agile Web Development with Rails 7",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contac t us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/rails7 for more book information.
#---
class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product)
    current_item = line_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product.id)
      current_item.price = product.price
    end
    current_item
  end

  def remove_product(product)
    current_item = line_items.find_by(product_id: product.id)

    if current_item && current_item.quantity > 1
      current_item.quantity -= 1
    elsif current_item
      current_item.destroy
    end   
    puts current_item
    current_item
  end

  def total_price
    line_items.sum { |item| item.total_price }
  end
end
