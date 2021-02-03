# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ocr::Line do
  let(:line) { described_class.new(numbers) }
  let(:numbers) do
    [digit_1, digit_2, digit_3, digit_4, digit_5, digit_6, digit_7, digit_8, digit_9]
  end

  describe '.output' do
    subject { line.output }

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

      it { is_expected.to eq('345882865') }
    end

    context 'when the checksum is incorrect' do
      let(:digit_1) { build(:numbers, :three) }
      let(:digit_2) { build(:numbers, :three) }
      let(:digit_3) { build(:numbers, :three) }
      let(:digit_4) { build(:numbers, :three) }
      let(:digit_5) { build(:numbers, :three) }
      let(:digit_6) { build(:numbers, :three) }
      let(:digit_7) { build(:numbers, :three) }
      let(:digit_8) { build(:numbers, :three) }
      let(:digit_9) { build(:numbers, :three) }

      it { is_expected.to eq('333333333 (ERR)') }
    end

    context 'when there are several alternatives' do
      let(:digit_1) { build(:numbers, :one) }
      let(:digit_2) { build(:numbers, :four) }
      let(:digit_3) { build(:numbers, :five) }
      let(:digit_4) { build(:numbers, :eight) }
      let(:digit_5) { build(:numbers, :eight) }
      let(:digit_6) { build(:numbers, :two) }
      let(:digit_7) { build(:numbers, :eight) }
      let(:digit_8) { build(:numbers, :six) }
      let(:digit_9) { build(:numbers, :five) }

      it { is_expected.to eq('145882865 (AMB)') }
    end

    context 'when there are invalid digits' do
      let(:digit_1) { build(:numbers, :three) }
      let(:digit_2) { build(:numbers, :four) }
      let(:digit_3) { build(:numbers, :invalid) }
      let(:digit_4) { build(:numbers, :eight) }
      let(:digit_5) { build(:numbers, :eight) }
      let(:digit_6) { build(:numbers, :invalid) }
      let(:digit_7) { build(:numbers, :eight) }
      let(:digit_8) { build(:numbers, :six) }
      let(:digit_9) { build(:numbers, :five) }

      it { is_expected.to eq('34?88?865 (ILL)') }
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
