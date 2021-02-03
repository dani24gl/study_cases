# frozen_string_literal: true

namespace :ocr do
  desc 'Reads a file with 4 lines entries and 27 chars per line,' \
       'and turn it into numbers'

  task turn_into_numbers: :environment do
    puts 'Enter your file path to be translated to numbers:'
    # file_path = STDIN.gets.strip
    puts 'public/example_file_1.doc'

    file_path = 'public/example_file_1.doc'

    begin
      file = File.read(file_path)
      puts 'File read'
      puts 'Starting conversion'

      Ocr::TranslatorService.new(file).to_numbers
    rescue Errno::ENOENT
      puts 'Error: File could not be read. Please check the file path and try this task later'
    end
  end
end
