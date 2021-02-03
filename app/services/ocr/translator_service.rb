module Ocr
  class TranslatorService
    LINE_LENGTH = 27

    attr_reader :file

    def initialize(raw_file)
      @file = raw_file.split("\n")
    end

    def to_numbers
      entries.each do |entry|
        puts numbers(entry).map(&:value).join
      end
    end

    private

    def entries
      file.in_groups_of(4)
    end

    def numbers(entry)
      numbers = []
      current_position = 0

      for i in 0..LINE_LENGTH - 1 do
        if space_found?(entry, i)
          numbers.push(new_number(entry, current_position, i - 1))
          current_position = i + 1
        end
      end

      add_last_number(numbers, entry, current_position)

      remove_empty_places(numbers)
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

    def add_last_number(numbers, entry, current_position)
      numbers.push(new_number(entry, current_position, LINE_LENGTH - 1))
    end

    def remove_empty_places(numbers)
      numbers.reject do |number|
        number.empty?
      end
    end
  end
end
