$:.unshift './lib'

require 'date'
require 'person_reader'

if ARGV.empty?
  puts "Please specify one or more input files."
  Kernel.exit
end # if

records, reader = [], PersonReader
ARGV.each do |filepath|
  if !File.exists?(filepath)
    puts "ERROR: Unable to locate file at \"#{filepath}\". Skipping..."
    next
  elsif !File.file?(filepath)
    puts "ERROR: \"#{filepath}\" is not a file. Skipping..."
    next
  end # unless
  
  File.open filepath do |file|
    records += reader.read(file)
  end # open
end # each

puts records.inspect
