# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ocr::TranslatorService do
  let(:translator_service) { Ocr::TranslatorService.new(file_content) }
  let(:file_content) do
    " _     _  _  _  _  _  _  _ \n" \
    " _||_||_ |_||_| _||_||_ |_ \n" \
    " _|  | _||_||_||_ |_||_| _|\n" \
    "\n" \
    "    _  _     _  _  _  _  _ \n" \
    "  | _| _||_||_ |_   ||_||_|\n" \
    "  ||_  _|  | _||_|  ||_| _|\n" \
    "\n" \
    "    _  _     _  _  _  _  _ \n" \
    "  | _| _| _||_ |_   ||_||_|\n" \
    "  ||_  _|  | _||_|  ||_| _|\n" \
    "\n" \
    "    _  _     _  _  _  _  _ \n" \
    "  | _| _||_||_ |_   ||_||_|\n" \
    "  ||_  _|    _||_|  ||_| _|\n" \
    "\n" \
    "    _  _     _  _  _  _  _ \n" \
    "  | _| _||_ |_ |_   ||_||_|\n" \
    "  ||_  _|  | _||_|  ||_| _|\n" \
    "  \n" \
    " _  _  _  _  _             \n" \
    "|_||_|| ||_   |  |  |  |  |\n" \
    "|_| _||_||_|  |  |  |  |  |\n" \
    "  \n" \
    " _  _  _  _  _  _  _  _  _ \n" \
    " _| _| _| _| _| _| _| _| _|\n" \
    " _| _| _| _| _| _| _| _| _|\n" \
    "\n" \
    " _  _  _  _  _  _  _  _    \n" \
    "| || || || | _|| || ||_|  |\n" \
    "|_||_||_||_||_ |_||_||_|  |\n" \
    "\n" \
    " _  _  _     _             \n" \
    "|_||||| | _   |  |  |  |  |\n" \
    "|_| _||_||_|  |  |  |  |  |\n" \
    "\n"
  end

  describe '.to_numbers' do
    subject { translator_service.to_numbers }

    it 'expects to return the numbers translated' do
      expect(subject).to eq(
        "345882865\n" \
        "123456789\n" \
        "123?56789\n" \
        "123?56789\n" \
        "123?56789\n" \
        "890671117\n" \
        "333333333 (ERR)\n" \
        "000020081 (AMB)\n" \
        '8?0?71111 (ILL)'
      )
    end
  end
end
