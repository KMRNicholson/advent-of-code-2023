module Almanac
    NEW_LINE = '${new_line}'

    def convert_to_machine_readable(raw_contents)
        content_string = ''
        raw_contents.each do |line| 
            if(line == '') then
                content_string += ':'
            else
                content_string += "#{line}#{NEW_LINE}"
            end
        end
        
        return content_string.split(':')
    end

    def parse_seed_data(contents)
        return seeds_data = contents[1].gsub("#{NEW_LINE}", '').split(' ')
    end

    def parse_seed_map(raw_contents, factor=1)
        contents = convert_to_machine_readable(raw_contents)

        seeds_data = parse_seed_data(contents)

        mappings = []
        i = 0
        while(i < seeds_data.length)
            source_index = (seeds_data[i].to_f) / factor
            range = (seeds_data[i+1].to_f) / factor
            destination_index = 0
            mappings += [Mapping.new(source_index, destination_index, range)]
            i += 2
        end

        return [Map.new('bag', 'seed', mappings)]
    end

    def parse_seeds(raw_contents)
        contents = convert_to_machine_readable(raw_contents)

        seeds = parse_seed_data(contents).map do |line|
            Seed.new(line.to_i)
        end

        return seeds
    end

    def parse_maps(raw_contents, parse_seed_maps=false, factor=1)
        contents = convert_to_machine_readable(raw_contents)
        map_contents = contents[2..contents.length()]
        
        maps = parse_seed_maps ? parse_seed_map(raw_contents, factor) : []
        i = 0
        while i < map_contents.length()
            source = map_contents[i].gsub(' map', '').split('-')[0]
            destination = map_contents[i].gsub(' map', '').split('-')[2]

            mapping_data = map_contents[i+1].split("#{NEW_LINE}").reject { |mapping| mapping == '' }
            mappings = []
            mappings += mapping_data.map do |mapping|
                map = mapping.split(' ')
                source_index = (map[1].to_f) / factor
                destination_index = (map[0].to_f) / factor
                range = (map[2].to_f) / factor
                Mapping.new(source_index, destination_index, range)
            end

            maps += [Map.new(source, destination, mappings)]
            i += 2
        end
        return maps
    end

    def get_lowest_location_by_seed(seeds, maps)
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
        return seeds.first
    end

    def get_lowest_location_by_location(maps, factor=1)
        destinations = ['location', 'humidity', 'temperature', 'light', 'water', 'fertilizer', 'soil', 'seed']

        mapping = get_map_by_destination(maps, 'location').first.get_mappings().sort_by!{|a|a.get_destination_index()}.last
        stop = mapping.get_destination_index() + mapping.get_range()
        puts "Stop after #{stop} loops"
        starting = Time.now
        i = 0
        while(i < stop)
            nextDest=i
            destinations.each do |destination|
                map = get_map_by_destination(maps, destination).first
                if(destination == 'seed') then
                    if(map.within_source_range?(nextDest)) then
                        puts "The location #{i * factor} was matched to seed #{nextDest * factor}! Exiting."
                        return (i * factor)
                    end
                end
                nextDest = map.destination_to_source(nextDest)
            end
            i += 1
            if(i % 100000 == 0) then
                ending = Time.now
                elapsed = ending - starting
                puts "on location: #{i}  elapsed time: #{elapsed}"
            end
        end
        
        return nil
    end

    def get_map_by_destination(maps, destination)
        return maps.select { |map| map.get_destination() == destination }
    end

    def get_map_by_source(maps, source)
        return maps.select { |map| map.get_source() == source }
    end

    class Seed
        def initialize(id)
            @id = id
        end

        def get_id()
            return @id
        end

        def set_location(location)
            @location = location
        end

        def get_location()
            return @location
        end
    end

    class Mapping
        def initialize(source_index, destination_index, range)
            @source_index = source_index
            @destination_index = destination_index
            @range = range
        end

        def get_source_index()    
            return @source_index
        end

        def get_range()    
            return @range
        end

        def get_destination_index()
            return @destination_index
        end
    end

    class Map
        def initialize(source, destination, mappings)
            @source = source
            @destination = destination
            @mappings = mappings
        end

        def get_source()    
            return @source
        end

        def get_destination()
            return @destination
        end

        def get_mappings()
            return @mappings
        end

        def within_source_range?(value)
            get_mappings.each do |mapping|
                lowerBound = mapping.get_source_index()
                upperBound = lowerBound + mapping.get_range()
                if(value >= lowerBound && value <= upperBound) then
                    return true
                end
            end
            return false
        end

        def source_to_destination(source)
            destination = source
            get_mappings.each do |mapping|
                lowerBound = mapping.get_source_index()
                upperBound = lowerBound + mapping.get_range()
                if(source >= lowerBound && source <= upperBound) then
                    destination = mapping.get_destination_index() + (source - lowerBound)
                end
            end
            return destination
        end

        def destination_to_source(destination)
            source = destination
            get_mappings.each do |mapping|
                lowerBound = mapping.get_destination_index()
                upperBound = lowerBound + mapping.get_range()
                if(destination >= lowerBound && destination <= upperBound) then
                    source = mapping.get_source_index() + (destination - lowerBound)
                end
            end
            return source
        end
    end
end