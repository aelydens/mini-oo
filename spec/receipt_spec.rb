require 'spec_helper'
require_relative '../receipt'

describe Receipt do
  it 'returns a receipt with line items and totals' do
    receipt = Receipt.new([
      { item: 'Carrot', price: 1.00 },
      { item: 'Banana', price: 2.00 }
    ])

    expect(receipt.generate).to eq(
      <<~HEREDOC
        1 Carrot - $1.00
        1 Banana - $2.00

        Pretax Total - $3.00
        Sales Tax (6%) - $0.18
        Total - $3.18
      HEREDOC
    )
  end

  xit 'handles multiple quantities' do
    receipt = Receipt.new([
      { item: 'Apple', price: 1.00 },
      { item: 'Apple', price: 1.00 },
      { item: 'Banana', price: 2.00 }
    ])

    expect(receipt.generate).to eq(
      <<~HEREDOC
        2 Apples - $2.00
        1 Banana - $2.00

        Pretax Total - $4.00
        Sales Tax (6%) - $0.24
        Total - $4.24
      HEREDOC
    )
  end

  xit 'handles variable sales tax' do
  end

  context 'with discount code' do
    xit 'applies discount code' do
      receipt = Receipt.new(
        [
          { item: 'Apple', price: 1.00 },
          { item: 'Apple', price: 1.00 },
          { item: 'Banana', price: 2.00 }
        ],
        'SUMMER-10OFF'
      )

      expect(receipt.generate).to eq(
        <<~HEREDOC
          2 Apples - $2.00
          1 Banana - $2.00

          Item Total - $4.00
          Discount Code Applied: 'SUMMER-10OFF'
          Discount - ($-0.40)
          Pretax Total - $3.60
          Sales Tax (6%) - $0.22
          Total - $3.82
        HEREDOC
      )
    end
  end
end