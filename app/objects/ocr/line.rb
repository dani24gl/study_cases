# frozen_string_literal: true

module Ocr
  class Line
    include ChecksumHelper

    attr_reader :numbers

    def initialize(numbers)
      @numbers = numbers
    end

    def value
      @value ||= numbers.map(&:value).join
    end

    def output
      if invalid_numbers?
        new_output = new_output_from_invalid_numbers
        return new_output unless new_output.nil?
      end

      if invalid_checksum?(value.to_i)
        new_output = new_output_from_invalid_checksum
        return new_output unless new_output.nil?
      end

      value
    end

    private

    def invalid_numbers?
      value.include?('?')
    end

    def guesses
      @guesses ||= Ocr::GuessingService.new(self).guess
    end

    def new_output_from_invalid_numbers
      return "#{value} (ILL)" if guesses.count.zero?

      return value.to_s if guesses.count == 1

      return "#{value} (AMB)" if guesses.count > 1

      nil
    end

    def new_output_from_invalid_checksum
      return "#{value} (ERR)" if guesses.count.zero?

      return guesses[0].to_s if guesses.count == 1

      return "#{value} (AMB)" if guesses.count > 1

      nil
    end
  end
end
