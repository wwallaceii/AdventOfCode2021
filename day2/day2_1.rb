def calculate_ship_coordinates(input_file)
    horizontal = 0
    depth = 0
    File.open(input_file).each do |line|
        command = line.split(" ")
        case command[0]
        when "forward"
            horizontal += command[1].to_i
        when "down"
            depth += command[1].to_i
        when "up"
            depth -= command[1].to_i
        end
    end

    horizontal*depth
end

puts calculate_ship_coordinates("input2.txt")