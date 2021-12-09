def calculate_power_consumption(records)
    oxygen_ratings = records
    co2_ratings = records

    oxygen_index = 0
    while oxygen_ratings.length > 1 
        ones_count = oxygen_ratings.count { |rating| rating[oxygen_index] == "1"}
        zeros_count = oxygen_ratings.length - ones_count

        if ones_count >= zeros_count then
            oxygen_ratings = oxygen_ratings.select{ |rating| rating[oxygen_index] == "1"}
        else
            oxygen_ratings = oxygen_ratings.select{ |rating| rating[oxygen_index] == "0"}
        end
        oxygen_index += 1
    end

    co2_index = 0
    while co2_ratings.length > 1 
        ones_count = co2_ratings.count { |rating| rating[co2_index] == "1"}
        zeros_count = co2_ratings.length - ones_count

        if ones_count < zeros_count then
            co2_ratings = co2_ratings.select{ |rating| rating[co2_index] == "1"}
        else
            co2_ratings = co2_ratings.select{ |rating| rating[co2_index] == "0"}
        end
        co2_index += 1
    end

    puts "#{oxygen_ratings[0]} * #{co2_ratings[0]}"
    oxygen_ratings[0].to_i(2) * co2_ratings[0].to_i(2)
end

def get_report_from_file(filename)
    lines = []
    File.open(filename).each do |line|
        lines.push line.chomp
    end
    lines
end
records = get_report_from_file("input3.txt")
puts calculate_power_consumption(records)