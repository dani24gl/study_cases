# frozen_string_literal: true

module Ocr
  class Line
    attr_reader :numbers

    def initialize(numbers)
      @numbers = numbers
    end

    def value
      @value ||= numbers.map(&:value).join
    end

    def output
      return "#{value} (ILL)" if invalid_numbers?

      return "#{value} (ERR)" if invalid_checksum?

      value
    end

    private

    def invalid_numbers?
      value.include?('?')
    end

    def invalid_checksum?
      return true if value.length != 9

      remainder = value.to_i.digits.each.with_index(1).map do |n, i|
        n * i
      end.reduce(0, :+) % 11

      !remainder.zero?
    end
  end
end
