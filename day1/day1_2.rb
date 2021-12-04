def count_depth_measurement_increases_with_sliding_window(input_file, sliding_window)
    count = 0
    prev_measurement = nil
    lines = []
    window_start = 0
    window_end = window_start + sliding_window - 1
    File.open(input_file).each {|line| lines << line.to_i }
    while window_end < lines.length do
        sum = 0
        lines[window_start..window_end].each { |value| sum += value}

        if !prev_measurement.nil? && sum > prev_measurement then
            count += 1            
        end
        prev_measurement = sum
        window_start += 1
        window_end += 1
    end
    count
end

puts count_depth_measurement_increases_with_sliding_window("input1.txt", 3)