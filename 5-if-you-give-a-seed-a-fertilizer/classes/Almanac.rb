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

    def parse_seeds(raw_contents)
        contents = convert_to_machine_readable(raw_contents)

        seeds = contents[1].gsub("#{NEW_LINE}", '').split(' ').map do |line|
            Seed.new(line.to_i)
        end

        return seeds
    end

    def parse_maps(raw_contents)
        contents = convert_to_machine_readable(raw_contents)
        map_contents = contents[2..contents.length()]
        
        maps = []
        i = 0
        while i < map_contents.length()
            source = map_contents[i].gsub(' map', '').split('-')[0]
            destination = map_contents[i].gsub(' map', '').split('-')[2]

            mapping_data = map_contents[i+1].split("#{NEW_LINE}").reject { |mapping| mapping == '' }
            mappings = []
            mappings += mapping_data.map do |mapping|
                map = mapping.split(' ')
                source_index = map[1].to_i
                destination_index = map[0].to_i
                range = map[2].to_i
                Mapping.new(source_index, destination_index, range)
            end

            maps += [Map.new(source, destination, mappings)]
            i += 2
        end
        return maps
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

        def get_source_range()
            return (@source_index..(@source_index+@range-1)).to_a
        end

        def get_destination_range()
            return (@destination_index..(@destination_index+@range-1)).to_a
        end

        def get_mapping()
            source_range = get_source_range()
            destination_range = get_destination_range()
            map = Hash.new
            for i in (0..@range-1) do
                map[source_range[i]] = destination_range[i]
            end
            return map
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

        def combine()
            combined_map = Hash.new
            get_mappings().each { |mapping| combined_map.merge!(mapping.get_mapping()) }
            return combined_map
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
    end
end