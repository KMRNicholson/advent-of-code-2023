module CaptainJack
    def get_races(raw_contents)
        times = raw_contents[0].split(':')[1].split(' ').reject { |entry| entry == '' }
        distances = raw_contents[1].split(':')[1].split(' ').reject { |entry| entry == '' }

        races = []
        for num in (1..times.length) do
            index = num - 1
            time = times[index].to_i
            record_distance = distances[index].to_i
            races += [ Race.new(record_distance, time) ]            
        end
        return races
    end

    def find_product_of_win_possibilities(races, boat)
        product = 1
        races.each do |race|
            record_distance = race.get_record_distance()
            race_time = race.get_time()

            win_possibilities = 0
            for ms in (1..race_time) do
                boat.power_up(ms)
                time_left = race_time - ms
                distance = boat.get_distance(time_left)
                if(distance > record_distance) then
                    win_possibilities += 1
                end
            end
            product *= win_possibilities
        end

        return product
    end

    class ToyBoat
        def initialize(velocity)
            @velocity = velocity
        end

        def get_speed()    
            return @velocity
        end

        def get_distance(time)    
            return @velocity * time
        end
        
        def power_up(time)  
            @velocity = time
        end
    end

    class Race
        def initialize(record_distance, time)
            @record_distance = record_distance
            @time = time
        end

        def get_record_distance()    
            return @record_distance
        end

        def get_time()    
            return @time
        end
    end
end