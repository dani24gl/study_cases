# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ocr::GuessingService do
  let(:guessing_service) { described_class.new(line) }
  let(:line) { Ocr::Line.new(numbers) }
  let(:numbers) do
    [digit_1, digit_2, digit_3, digit_4, digit_5, digit_6, digit_7, digit_8, digit_9]
  end

  describe '.guess' do
    subject { guessing_service.guess }

    let(:digit_1) { build(:numbers, :one) }
    let(:digit_2) { build(:numbers, :two) }
    let(:digit_3) { build(:numbers, :three) }
    let(:digit_4) { build(:numbers, :four) }
    let(:digit_5) { build(:numbers, :five) }
    let(:digit_6) { build(:numbers, :six) }
    let(:digit_7) { build(:numbers, :seven) }
    let(:digit_8) { build(:numbers, :eight) }
    let(:digit_9) { build(:numbers, :nine) }

    context 'when invalid number' do
      context 'recoverable' do
        let(:digit_4) { build(:numbers, :invalid_recoverable) }

        it { is_expected.to eq(['123456789']) }
      end

      context 'non recoverable' do
        let(:digit_4) { build(:numbers, :invalid_recoverable) }
        let(:digit_7) { build(:numbers, :six) }
        let(:digit_8) { build(:numbers, :invalid_recoverable) }

        it { is_expected.to eq([]) }
      end
    end

    context 'when invalid checksum' do
      context 'recoverable' do
        let(:digit_1) { build(:numbers, :seven) }

        it { is_expected.to eq(['123456789']) }
      end

      context 'no alternative' do
        let(:digit_1) { build(:numbers, :three) }
        let(:digit_2) { build(:numbers, :three) }
        let(:digit_3) { build(:numbers, :three) }
        let(:digit_4) { build(:numbers, :three) }
        let(:digit_5) { build(:numbers, :three) }
        let(:digit_6) { build(:numbers, :three) }
        let(:digit_7) { build(:numbers, :three) }
        let(:digit_8) { build(:numbers, :three) }
        let(:digit_9) { build(:numbers, :three) }

        it { is_expected.to eq([]) }
      end

      context 'more than one alternative' do
        let(:digit_1) { build(:numbers, :zero) }
        let(:digit_2) { build(:numbers, :zero) }
        let(:digit_3) { build(:numbers, :zero) }
        let(:digit_4) { build(:numbers, :zero) }
        let(:digit_5) { build(:numbers, :two) }
        let(:digit_6) { build(:numbers, :zero) }
        let(:digit_7) { build(:numbers, :zero) }
        let(:digit_8) { build(:numbers, :eight) }
        let(:digit_9) { build(:numbers, :one) }

        it { is_expected.to eq(%w[800020081 000020001 000020087]) }
      end
    end
  end
end
