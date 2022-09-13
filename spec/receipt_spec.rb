require 'spec_helper'
require_relative '../receipt'

describe Receipt do
  it 'returns a receipt with line items and totals' do
    receipt = Receipt.new([
      { 'Apple' => 1.00 },
      { 'Banana' => 2.00 }
    ])

    expect(receipt.generate).to eq(
      <<~HEREDOC
        1 Apple - $1.00
        1 Banana - $2.00

        Pretax Total - $3.00
        Sales Tax (6%) - $0.18
        Total - $3.60
      HEREDOC
    )
  end

  it 'handles multiple quantities' do
    receipt = Receipt.new([
      { 'Apple' => 1.00 },
      { 'Apple' => 1.00 },
      { 'Banana' => 2.00 }
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

  context 'with discount code' do
    xit 'applies discount code' do
      receipt = Receipt.new(
        [
          { 'Apple' => 1.00 },
          { 'Apple' => 1.00 },
          { 'Banana' => 2.00 }
        ],
        'SUMMER-10OFF'
      )

      expect(receipt.generate).to eq(
        <<~HEREDOC
          1 Apple - $1.00
          1 Banana - $2.00

          Pretax Total - $3.00
          Discount Code Applied: 'SUMMER-10OFF'
          Discount - ($-0.30)
          Sales Tax (6%) - $0.16
          Total - $2.86
        HEREDOC
      )
    end
  end
end