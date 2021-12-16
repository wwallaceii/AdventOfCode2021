def read_input(file_name)
    positions = []
    line = File.open(file_name) { |f| f.readline }
    positions = line.split(",").map {|pos| pos.to_i}
end

def calculate_lowest_fuel(positions)
    result = nil
    cost_for_position = Hash.new(0)

    positions.each do |base_position|
        temp_result = 0
        positions.each do |other_position|
            temp_result += (base_position - other_position).abs
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