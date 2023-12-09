require_relative "classes/FileHandler"
require_relative "classes/Almanac"

include FileHandler
include Almanac

input_file = ARGV[0]
input_data = InputData.new(input_file)

raw_contents = input_data.get_raw_contents_array()
seeds = parse_seeds(raw_contents)
maps = parse_maps(raw_contents)
seed_with_lowest_location = get_lowest_location_by_seed(seeds, maps)

puts "Lowest location from seed #{seed_with_lowest_location.get_id()} found to be: #{seed_with_lowest_location.get_location()}"

parse_seed_maps = true
maps_v2 = parse_maps(raw_contents, parse_seed_maps)
map = get_lowest_location_by_location(maps_v2)