# frozen_string_literal: true

module Ocr
  class Number
    attr_reader :lines

    def initialize(lines)
      @lines = lines
    end

    def value
      return 0 if zero?

      return 1 if one?

      return 2 if two?

      return 3 if three?

      return 4 if four?

      return 5 if five?

      return 6 if six?

      return 7 if seven?

      return 8 if eight?

      return 9 if nine?

      '?'
    end

    def alternatives
      (alternatives_for_invalids + alternatives_for_valids).uniq
    end

    private

    def alternatives_for_valids
      return [8] if zero?

      return [7] if one?

      return [6, 9] if five?

      return [1] if seven?

      return [0] if eight?

      return [5, 8] if nine?

      []
    end

    # For simplicity I'll only check some cases of number 4, there are too many posibilities
    def alternatives_for_invalids
      return [4] if lines[0] == '   ' && lines[1] == '|_|' && lines[2] == '   '

      return [4] if lines[0] == '   ' && lines[1] == '|_ ' && lines[2] == '  |'

      return [4] if lines[0] == '   ' && lines[1] == '| |' && lines[2] == '  |'

      return [4] if lines[0] == '   ' && lines[1] == ' _|' && lines[2] == '  |'

      return [4] if lines[0] == '  |' && lines[1] == '|_|' && lines[2] == '  |'

      []
    end

    def zero?
      lines[0] ==   ' _ ' &&
        lines[1] == '| |' &&
        lines[2] == '|_|'
    end

    def one?
      lines[0] ==   '   ' &&
        lines[1] == '  |' &&
        lines[2] == '  |'
    end

    def two?
      lines[0] ==   ' _ ' &&
        lines[1] == ' _|' &&
        lines[2] == '|_ '
    end

    def three?
      lines[0] ==   ' _ ' &&
        lines[1] == ' _|' &&
        lines[2] == ' _|'
    end

    def four?
      lines[0] ==   '   ' &&
        lines[1] == '|_|' &&
        lines[2] == '  |'
    end

    def five?
      lines[0] ==   ' _ ' &&
        lines[1] == '|_ ' &&
        lines[2] == ' _|'
    end

    def six?
      lines[0] ==   ' _ ' &&
        lines[1] == '|_ ' &&
        lines[2] == '|_|'
    end

    def seven?
      lines[0] ==   ' _ ' &&
        lines[1] == '  |' &&
        lines[2] == '  |'
    end

    def eight?
      lines[0] ==   ' _ ' &&
        lines[1] == '|_|' &&
        lines[2] == '|_|'
    end

    def nine?
      lines[0] ==   ' _ ' &&
        lines[1] == '|_|' &&
        lines[2] == ' _|'
    end
  end
end
