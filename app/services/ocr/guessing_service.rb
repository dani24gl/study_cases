# frozen_string_literal: true

module Ocr
  class GuessingService
    include ChecksumHelper

    attr_accessor :line

    def initialize(line)
      @line = line
    end

    def guess
      guesses = []
      line.numbers.each.with_index do |number, i|
        number.alternatives.each do |alt|
          line_value_dup = line.value.dup
          line_value_dup[i] = alt.to_s

          guesses.push(line_value_dup) if line_value_dup.exclude?('?')
        end
      end

      reject_invalids(guesses)
    end

    private

    def more_than_one_digit_wrong?
      line.value.split('?').count > 1
    end

    def one_digit_wrong?
      line.value.split('?') == 1
    end

    def wrong_digit_postition
      @wrong_digit_postition ||= line.value.index('?')
    end

    def wrong_digit
      line.numbers[wrong_digit_postition]
    end

    def reject_invalids(guesses)
      guesses.reject do |g|
        invalid_checksum?(g.to_i)
      end
    end
  end
end
