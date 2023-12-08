require_relative "classes/FileHandler"
require_relative "classes/Almanac"

include FileHandler
include Almanac

input_file = ARGV[0]
input_data = InputData.new(input_file)

raw_contents = input_data.get_raw_contents_array()
seeds = parse_seeds(raw_contents)
maps = parse_maps(raw_contents)

destinations = ['soil', 'fertilizer', 'water', 'light', 'temperature', 'humidity', 'location']
seeds.each do |seed|
    source = seed.get_id()

    destinations.each do |destination|
        map = get_map_by_destination(maps, destination).first
        source = map.source_to_destination(source)
    end

    seed.set_location(source)
end

seeds.sort_by! { |a| a.get_location() }
location = seeds.first.get_location()

puts "Lowest location found to be: #{location}"