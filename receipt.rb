require 'byebug'

class Receipt
  def initialize(items)
    @items = items
  end

  def generate
    result = ""
    pretax_total = 0
    @items.each do |item|
      result += "1 #{item[:item]} - $#{to_currency(item[:price])}\n"
      pretax_total += item[:price]
    end

    sales_tax = pretax_total * 0.06

    result += "\n"
    result += "Pretax Total - $#{to_currency(pretax_total)}\n"
    result += "Sales Tax (6%) - $#{to_currency(sales_tax)}\n"
    result += "Total - $#{to_currency(pretax_total + sales_tax)}\n"
    result
  end

  def to_currency(num)
    sprintf('%.2f', num)
  end
end
