# frozen_string_literal: true

module Ocr
  class TranslatorService
    DIGITS_LENGTH = 9

    attr_reader :file

    def initialize(raw_file)
      @file = raw_file.split("\n")
    end

    def to_numbers
      output = []
      entries.each do |entry|
        line = new_line(entry)
        line_output = line.output
        output.push(line_output)

        puts line_output
      end

      output.join("\n")
    end

    private

    def entries
      file.in_groups_of(4)
    end

    def new_line(entry)
      Ocr::Line.new(calculate_numbers(entry))
    end

    def calculate_numbers(entry)
      numbers = []

      (0..DIGITS_LENGTH - 1).each do |i|
        pos = i * 3
        numbers.push(new_number(entry, pos, pos + 2))
      end

      numbers
    end

    def new_number(entry, start_pos, last_pos)
      Ocr::Number.new([
                        entry[0][start_pos..last_pos],
                        entry[1][start_pos..last_pos],
                        entry[2][start_pos..last_pos]
                      ])
    end
  end
end
