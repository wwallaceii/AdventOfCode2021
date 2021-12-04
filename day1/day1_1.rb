def count_depth_measurement_increases(input_file)
    count = 0
    prev_line = nil
    File.open(input_file).each do |line|
        if !prev_line.nil? && line.to_i > prev_line then
            count += 1
        end
        prev_line = line.to_i
    end

    count
end

puts count_depth_measurement_increases("input1.txt")