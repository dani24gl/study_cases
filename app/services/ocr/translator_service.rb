# frozen_string_literal: true

module Ocr
  class TranslatorService
    LINE_LENGTH = 35

    attr_reader :file

    def initialize(raw_file)
      @file = raw_file.split("\n")
    end

    def to_numbers
      output = []
      entries.each do |entry|
        line = new_line(entry)
        line_output = line.value

        line_output += ' (Invalid)' unless line.valid?

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
      numbers = []
      current_position = 0

      (0..LINE_LENGTH - 1).each do |i|
        add_number(numbers, entry, current_position, index) if space_found?(entry, i)
        current_position = i + 1
      end

      add_last_number(numbers, entry, current_position)

      numbers = remove_empty_places(numbers)
      Ocr::Line.new(numbers)
    end

    def space_found?(entry, char_position)
      entry[0][char_position] == ' ' &&
        entry[1][char_position] == ' ' &&
        entry[2][char_position] == ' '
    end

    def new_number(entry, current_position, char_position)
      Ocr::Number.new([
                        entry[0][current_position..char_position],
                        entry[1][current_position..char_position],
                        entry[2][current_position..char_position]
                      ])
    end

    def add_number(numbers, entry, current_position, index)
      numbers.push(new_number(entry, current_position, index - 1))
    end

    def add_last_number(numbers, entry, current_position)
      numbers.push(new_number(entry, current_position, LINE_LENGTH - 1))
    end

    def remove_empty_places(numbers)
      numbers.reject(&:empty?)
    end
  end
end
