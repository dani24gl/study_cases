# frozen_string_literal: true

module ChecksumHelper
  def invalid_checksum?(integer)
    remainder = integer.digits.each.with_index(1).map do |n, i|
      n * i
    end.reduce(0, :+) % 11

    !remainder.zero?
  end
end
