def calculate_power_consumption(input_file)
    zeros = []
    ones = []
    File.open(input_file).each do |line|
        if zeros.empty? then
            zeros.fill(0, 0...line.chomp.length)
        end

        if ones.empty? then
            ones.fill(0, 0...line.chomp.length)
        end
        line.chomp.each_char.with_index do |character, index|
            if character == '1' then     
                ones[index] += 1
            else
                zeros[index] += 1
            end
        end
    end
    gamma = ""
    epsilon = ""

    zeros.length.times do |index|
        if ones[index] > zeros[index]  then
            gamma << "1"
            epsilon << "0"
        else
            gamma << "0"
            epsilon << "1"
        end
    end
     gamma.to_i(2) * epsilon.to_i(2)
end

puts calculate_power_consumption("input3.txt")