def read_lanternfish_from_file(file_name)
    lanternfish = []
    line = File.open(file_name) { |f| f.readline }
    lanternfish = line.split(",").map { |fish| fish.to_i}
end

def simulate_fish(input_file, days)
    lanternfish = read_lanternfish_from_file(input_file)
    #puts "Initial: #{lanternfish.join(",")}"
    day_counter = 0

    days.times do |index|
       new_fish = [] 
       lanternfish = lanternfish.map do |fish|
            new_fish_value = fish 
            if fish == 0
                new_fish.push 8
                new_fish_value = 6
            else
                new_fish_value -= 1
            end

            new_fish_value
       end
       lanternfish += new_fish 
       #puts "#{index+1}: #{lanternfish.join(",")}"
    end
    
    lanternfish
end

puts simulate_fish("input6.txt", 80).length