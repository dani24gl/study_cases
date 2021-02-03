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

    def valid?
      remainder = value.to_i.digits.each.with_index(1).map do |n, i|
        n * i
      end.reduce(0, :+) % 11

      remainder.zero?
    end
  end
end
