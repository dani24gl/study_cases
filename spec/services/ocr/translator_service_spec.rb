# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ocr::TranslatorService do
  let(:translator_service) { Ocr::TranslatorService.new(file_content) }
  let(:file_content) do
    "_       _   _   _   _   _   _   _ \n" \
    "_| |_| |_  |_| |_|  _| |_| |_  |_ \n" \
    "_|   |  _| |_| |_| |_  |_| |_|  _|\n" \
    "\n" \
    "   _  _       _                   \n" \
    "|  _| _| |_| |_  | | | |          \n" \
    "| |_  _|   |  _| | | | |          \n" \
    "\n" \
    " _   _   _   _  _                 \n" \
    "|_| |_| | | |_   | | | | |        \n" \
    "|_|  _| |_| |_|  | | | | |        \n" \
    "\n" \
    " _   _   _      _                 \n" \
    "|_| ||| | |  _   | | | | |        \n" \
    "|_|  _| |_| |_|  | | | | |        \n" \
    "\n"
  end

  describe '.to_numbers' do
    subject { translator_service.to_numbers }

    it 'expects to return the numbers translated' do
      expect(subject).to eq(
        "345882865\n123451111 (ERR)\n890671111 (ERR)\n8?0?71111 (ILL)"
      )
    end
  end
end
