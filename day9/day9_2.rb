require "set"

def read_input(file_name)
    heightmap = []
    File.open(file_name).each do |line|
        readings = line.chomp.split("").map(&:to_i)
        heightmap << readings
    end
    
    heightmap
end

def multiply_3_largest_basin_sizes(heightmap)
    basins = []
    lowpoints = []
    heightmap.each_with_index do |row, rowIndex|
        row.each_with_index do |column, columnIndex|
            current = heightmap[rowIndex][columnIndex]
            basin_size = 0
            up = rowIndex - 1
            down = rowIndex + 1
            left = columnIndex - 1
            right = columnIndex + 1

            if (up < 0 || heightmap[up][columnIndex] > current) &&
               (down >= heightmap.length || heightmap[down][columnIndex] > current) &&
               (left < 0 || heightmap[rowIndex][left] > current) &&
               (right >= heightmap[rowIndex].length || heightmap[rowIndex][right] > current)
               lowpoints << [rowIndex, columnIndex]
            end
        end
    end

    lowpoints.each do |point|
        basins << basin_size(heightmap, point[0], point[1])
    end
    result = 1;
    basins.sort.reverse.first(3).each do |value|
        result *= value
    end

    result
end

def basin_size(heightmap, row, column)
    if row < 0 ||
       row >= heightmap.length ||
       column < 0 ||
       column >= heightmap[row].length ||
        heightmap[row][column] == 9 ||
        heightmap[row][column] == -1
        return 0
    end

    heightmap[row][column] = -1

    return 1 + basin_size(heightmap, row - 1, column) + basin_size(heightmap, row + 1, column) + basin_size(heightmap, row, column - 1) + basin_size(heightmap, row, column + 1)    
end

puts multiply_3_largest_basin_sizes(read_input("input9.txt"))