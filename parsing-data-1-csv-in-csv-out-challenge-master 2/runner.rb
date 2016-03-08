require_relative 'person'
require_relative 'person_parser'

# Parse the data in the csv file into ruby objects
parser = PersonParser.new('people.csv')
people = parser.people


# Get people with phone numbers in a certain area code
puts "The following people have phone numbers from area code 419."

people_with_area_code_419 = people.select { |person| /\A1-419/.match person.phone }
people_with_area_code_419.each { |person| puts "#{person.first_name} #{person.last_name}" }
