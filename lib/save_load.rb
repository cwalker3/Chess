# frozen_string_literal: true

# module for saving a loading chess game
module SaveLoad
  def self.load
    Marshall.load(File.read("saves/#{valid_save}"))
  end

  def save
    Dir.mkdir('../saves') unless Dir.exist?('../saves')
    File.open("../saves/#{save_name}", 'w') { |save| save.write Marshal.dump(self) }
    prompt_continue
  end

  private

  def valid_save
    loop do
      file_number = prompt_file_input
      return Dir.children('saves')[file_number] if valid_file?(file_number)
    end
  end

  def prompt_file_input
    puts 'List of save files: '
    Dir.children('saves').each_with_index { |file, index| puts "#{index + 1}) #{file}" }
    puts "\nEnter a number for the corresponding save file:"
    gets.chomp.to_i - 1
  end

  def valid_file?(file_number)
    if Dir.children('saves')[file_number].nil?
      puts 'Invalid file.'
      sleep 1
      false
    else
      true
    end
  end

  def save_name
    puts 'Enter a name for your save:'
    gets.chomp
  end
end
