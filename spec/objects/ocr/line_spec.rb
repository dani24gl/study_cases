require 'rails_helper'

RSpec.describe Ocr::Line do
  let(:line) { described_class.new(numbers) }
  let(:numbers) do
    [digit_1, digit_2, digit_3, digit_4, digit_5, digit_6, digit_7, digit_8, digit_9]
  end
  
  describe '.valid?' do
    subject { line.valid? }

    context 'when the checksum is correct' do
      let(:digit_1) { build(:numbers, :three) }
      let(:digit_2) { build(:numbers, :four) }
      let(:digit_3) { build(:numbers, :five) }
      let(:digit_4) { build(:numbers, :eight) }
      let(:digit_5) { build(:numbers, :eight) }
      let(:digit_6) { build(:numbers, :two) }
      let(:digit_7) { build(:numbers, :eight) }
      let(:digit_8) { build(:numbers, :six) }
      let(:digit_9) { build(:numbers, :five) }

      it { is_expected.to eq(true) }
    end

    context 'when the checksum is incorrect' do
      let(:digit_1) { build(:numbers, :one) }
      let(:digit_2) { build(:numbers, :four) }
      let(:digit_3) { build(:numbers, :five) }
      let(:digit_4) { build(:numbers, :eight) }
      let(:digit_5) { build(:numbers, :eight) }
      let(:digit_6) { build(:numbers, :two) }
      let(:digit_7) { build(:numbers, :eight) }
      let(:digit_8) { build(:numbers, :six) }
      let(:digit_9) { build(:numbers, :five) }

      it { is_expected.to eq(false) }
    end
  end

  describe '.value' do
    subject { line.value }

    let(:digit_1) { build(:numbers, :three) }
    let(:digit_2) { build(:numbers, :four) }
    let(:digit_3) { build(:numbers, :five) }
    let(:digit_4) { build(:numbers, :eight) }
    let(:digit_5) { build(:numbers, :eight) }
    let(:digit_6) { build(:numbers, :two) }
    let(:digit_7) { build(:numbers, :eight) }
    let(:digit_8) { build(:numbers, :six) }
    let(:digit_9) { build(:numbers, :five) }

    it { is_expected.to eq('345882865') }
  end
end
