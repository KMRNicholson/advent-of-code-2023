module FileHandler
    class InputData
        def initialize(inputDataFile)
            @filePath = inputDataFile;
        end

        def get_raw_contents_array()
            file = File.open(@filePath);
            raw_contents = file.readlines.map(&:chomp)
            return raw_contents
        end

        def get_raw_contents_string()
            file = File.open(@filePath);
            raw_contents = file.read
            return raw_contents
        end
    end
end