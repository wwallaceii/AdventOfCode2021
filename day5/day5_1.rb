def read_input(file_name)
    grid = Hash.new()

    File.open(file_name).each do |line|
        coordinates = line.chomp.match /([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)/
        x1 = coordinates[1].to_i
        y1 = coordinates[2].to_i
        x2 = coordinates[3].to_i
        y2 = coordinates[4].to_i
        
        if x1 == x2
            range = y1 < y2 ? (y1..y2) : (y2..y1)

            range.each do |index|
                if !grid[index]
                    grid[index] = Hash.new(0)
                end
                grid[index][x1] += 1
            end
        elsif y1 == y2
            range = x1 < x2 ? ((x1)..(x2)) : ((x2)..(x1))
            range.each do |index|
                if !grid[y1]
                    grid[y1] = Hash.new(0)
                end
                grid[y1][index] += 1
            end
        end
    end

    grid
end

def count_overlaps(grid)
    count = 0

    grid.each_value{ |inner_hash| inner_hash.each_value { |value| count += 1 if value > 1} }

    count
end

grid = read_input("input5.txt")

puts count_overlaps(grid)