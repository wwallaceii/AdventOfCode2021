def read_input(file_name)
    heightmap = []
    File.open(file_name).each do |line|
        readings = line.chomp.split("").map(&:to_i)
        heightmap << readings
    end
    
    heightmap
end

def sum_low_points(heightmap)
    sum = 0
    heightmap.each_with_index do |row, rowIndex|
        row.each_with_index do |column, columnIndex|
            current = heightmap[rowIndex][columnIndex]
            up = rowIndex - 1
            down = rowIndex + 1
            left = columnIndex - 1
            right = columnIndex + 1

            if (up < 0 || heightmap[up][columnIndex] > current) &&
               (down >= heightmap.length || heightmap[down][columnIndex] > current) &&
               (left < 0 || heightmap[rowIndex][left] > current) &&
               (right >= heightmap[rowIndex].length || heightmap[rowIndex][right] > current)
               sum += (current + 1)
            end
        end
    end
    sum
end

puts sum_low_points(read_input("input9.txt"))