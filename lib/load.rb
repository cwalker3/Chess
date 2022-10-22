# frozen_string_literal: true

# Class that loads a fen string from a save
class Load
  def self.fen
    File.read("saves/#{valid_save}")
  end

  def self.valid_save
    loop do
      file_number = prompt_file_input
      return Dir.children('saves')[file_number] if valid_file?(file_number)
    end
  end

  def self.prompt_file_input
    puts 'List of save files: '
    Dir.children('saves').each_with_index { |file, index| puts "#{index + 1}) #{file}" }
    puts "\nEnter a number for the corresponding save file:"
    gets.chomp.to_i - 1
  end

  def self.valid_file?(file_number)
    if Dir.children('saves')[file_number].nil?
      puts 'Invalid file.'
      sleep 1
      false
    else
      true
    end
  end
end
