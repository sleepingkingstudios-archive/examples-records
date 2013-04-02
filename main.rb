# main.rb

$:.unshift './lib'

require 'date'
require 'person_reader'
require 'format/table_formatter'

# Checks if any files have been specified from the command line.
if ARGV.empty?
  puts "Please specify one or more input files."
  Kernel.exit
end # if

# Loops through the provided files, processing each valid file or returning an
# error message for invalid file names.
records, reader = [], PersonReader
ARGV.each do |filepath|
  if !File.exists?(filepath)
    puts "ERROR: Unable to locate file at \"#{filepath}\". Skipping..."
    next
  elsif !File.file?(filepath)
    puts "ERROR: \"#{filepath}\" is not a file. Skipping..."
    next
  end # unless
  
  begin
    File.open filepath do |file|
      # Processes the contents of the file into an array of Person objects.
      records += reader.read(file)
    end # open
  rescue StandardError => error
    puts "Encountered exception #{error.inspect} when reading from file #{filepath}."
  end # begin-rescue
end # each

# The TableFormatter takes an array of records and prints a table with the
# specified columns.
writer, output = Format::TableFormatter.new(records, " "), ""
columns = :last_name, :first_name,
  lambda { |record| record.gender[0] =~ /f/i ? "Female" : "Male" },
  :date_of_birth, :favorite_color

# Sort the records by last name, then gender, and prints the table to an output
# buffer.
output << "Output 1:" << "\n"
writer.records = records.sort { |u, v| u.last_name <=> v.last_name }.
  sort { |u, v| 0 == (u.gender <=> v.gender) }
end # sort
output += writer.format *columns

# Sorts the records by date of birth and prints to buffer.
output << "\n" << "Output 2:" << "\n"
writer.records = records.sort do |u, v|
  DateTime.strptime(u.date_of_birth, "%m/%d/%Y") <=>
    DateTime.strptime(v.date_of_birth, "%m/%d/%Y")
end # sort
output += writer.format *columns

# Sorts the records by last name and prints to buffer.
output << "\n" << "Output 3:" << "\n"
writer.records = records.sort do |u, v| u.last_name <=> v.last_name; end
output += writer.format *columns

# Dumps the output buffer to an "output.text" file.
begin
  File.write "./output.txt", output
  
  puts "Processed #{records.count} records to output.txt"
rescue StandardError => error
  puts "Encountered exception #{error.inspect} when writing to file #{filepath}."
end # begin-rescue
