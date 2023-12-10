require_relative "classes/FileHandler"
require_relative "classes/CaptainJack"

include FileHandler
include CaptainJack

input_file = ARGV[0]
input_data = InputData.new(input_file)

raw_contents = input_data.get_raw_contents_array()

black_pearl = ToyBoat.new(0)


races = get_races(raw_contents)

product = find_product_of_win_possibilities(races, black_pearl)

puts "The product of win possibilities is #{product}"