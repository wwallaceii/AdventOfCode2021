def read_lanternfish_from_file(file_name)
    lanternfish = []
    line = File.open(file_name) { |f| f.readline }
    lanternfish = line.split(",").map { |fish| fish.to_i}
end

def simulate_fish(input_file, days)
    lanternfish = read_lanternfish_from_file(input_file)
    puts "Initial count: #{lanternfish.length}"
    day_counter = 0
    fish_map = Hash.new(0)
    lanternfish.each {|fish| fish_map[fish] += 1}

    days.times do |index|
       zeros = fish_map[0]
       (0..7).each {|index| fish_map[index] = fish_map[index + 1]}
       fish_map[6] += zeros
       fish_map[8] = zeros
    end
    
    fish_map.values.sum
end

puts "80 days: #{simulate_fish("input6.txt", 80)}"
puts "256 days: #{simulate_fish("input6.txt", 256)}"