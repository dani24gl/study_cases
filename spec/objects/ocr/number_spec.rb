require 'rails_helper'

RSpec.describe Ocr::Number do
  let(:number) { described_class.new(lines) }
  
  describe '.empty?' do
    subject { number.empty? }
    
    context 'when number is empty' do
      let(:lines) do
        ['', '', '']
      end
  
      it { is_expected.to eq(true) }
    end

    context 'when number is not empty' do
      let(:lines) do
        [' ', '|', '|']
      end

      it { is_expected.to eq(false) }
    end
  end

  describe '.value' do
    subject { number.value }

    context 'when is empty' do
      let(:lines) { ['', '', ''] }

      it { is_expected.to eq(nil) }
    end

    context 'when it is value 0' do
      let(:lines) do
        [
          ' _ ',
          '| |',
          '|_|'
        ]
      end

      it { is_expected.to eq(0) }
    end

    context 'when it is value 1' do
      let(:lines) do
        [
          ' ',
          '|',
          '|'
        ]
      end

      it { is_expected.to eq(1) }
    end

    context 'when it is value 2' do
      let(:lines) do
        [
          ' _ ',
          ' _|',
          '|_ '
        ]
      end

      it { is_expected.to eq(2) }
    end

    context 'when it is value 3' do
      let(:lines) do
        [
          '_ ',
          '_|',
          '_|'
        ]
      end

      it { is_expected.to eq(3) }
    end

    context 'when it is value 4' do
      let(:lines) do
        [
          '   ',
          '|_|',
          '  |'
        ]
      end

      it { is_expected.to eq(4) }
    end

    context 'when it is value 5' do
      let(:lines) do
        [
          ' _ ',
          '|_ ',
          ' _|'
        ]
      end

      it { is_expected.to eq(5) }
    end

    context 'when it is value 6' do
      let(:lines) do
        [
          ' _ ',
          '|_ ',
          '|_|'
        ]
      end

      it { is_expected.to eq(6) }
    end

    context 'when it is value 7' do
      let(:lines) do
        [
          '_ ',
          ' |',
          ' |'
        ]
      end

      it { is_expected.to eq(7) }
    end

    context 'when it is value 8' do
      let(:lines) do
        [
          ' _ ',
          '|_|',
          '|_|'
        ]
      end

      it { is_expected.to eq(8) }
    end

    context 'when it is value 9' do
      let(:lines) do
        [
          ' _ ',
          '|_|',
          ' _|'
        ]
      end

      it { is_expected.to eq(9) }
    end

    context 'when it is unknown' do
      let(:lines) do
        [
          '_||',
          '|||',
          '| |'
        ]
      end

      it { is_expected.to eq(nil) }
    end
  end
end
