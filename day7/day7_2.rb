def read_input(file_name)
    positions = []
    line = File.open(file_name) { |f| f.readline }
    positions = line.split(",").map {|pos| pos.to_i}
end

def calculate_lowest_fuel(positions)
    result = nil
    max_position = positions.max
    (0..max_position).each do |base_position|
        temp_result = 0
        positions.each do |other_position|
            temp_result += (0..(base_position - other_position).abs).sum
            if (!result.nil? && temp_result >= result)
                break
            end
        end

        if(result.nil?)
            result = temp_result
        elsif temp_result < result
            result = temp_result
        end
    end
    return result
end

positions = read_input("input7.txt")
puts calculate_lowest_fuel(positions)