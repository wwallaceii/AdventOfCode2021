def read_input(file_name)
  grid = []
  folds = []

  max_x = 0
  max_y = 0
  reading_coordinates = true
  File.open(file_name).each do |line|
    row = line.chomp

    if row.empty?
      reading_coordinates = false
      (0..max_y).each do |y_index|
        if grid[y_index].nil?
          grid[y_index] = Array.new(max_x + 1, ".")
        else
          (0..max_x).each do |x_index|
            grid[y_index][x_index] = "." if grid[y_index][x_index].nil?
          end
        end
      end
      next
    end

     if reading_coordinates
      point = row.split(",")
      x = point[0].to_i
      y = point[1].to_i

      if x > max_x
        max_x = x
      end

      if y > max_y
        max_y = y
      end

      if !grid[y]
        grid[y] = []
      end

      grid[y][x] = "#"

     else
      match = row.match(/([x|y])=(\d*)/)
      folds << match[1,2]
     end
    
  end
  
  puts " #{max_x + 1} columns, #{max_y + 1} rows"

  [grid, folds]
end

class TransparentPaper

  def initialize(grid, folds)
    @grid = grid
    @folds = folds
  end

  def process_folds(print_steps: false, break_after_step: nil)
    @folds.each_with_index do |fold, iteration|
      direction = fold[0]
      line = fold[1].to_i

      puts "\n#{fold.join(",")}" if print_steps
      if(direction == "x")
        right = @grid.map do |row|
         row[(line+1)..-1]
        end
        left = @grid.map do |row|
          row[0..(line - 1)]
        end

        @grid = fold_left(right, left)

      else
        top = @grid[0..(line-1)]
        bottom = @grid[(line + 1)..-1]
        @grid = fold_up(bottom, top)
      end

      print if print_steps
      break if iteration == break_after_step
    end
  end

  def dot_count
    @grid.flatten.count("#")
  end

  def print(grid = @grid)
    puts "--------------------"
    grid.each do |row|
      puts row.join("")
    end
    puts ""
  end

  private
  
  def fold_left(right, left)
    left.each_with_index do | row, row_index |
      row.reverse.each_with_index do | column, column_index |
        if right[row_index][column_index]
          right[row_index][column_index] = "#" if column == "#"
        else
          right[row_index][column_index] = column
        end
      end
    end

    right.map do |row|
      row.reverse
    end    
  end

  def fold_up(bottom, top)
    top.reverse.each_with_index do | row, row_index |
      row.each_with_index do | column, column_index |
        if bottom[row_index]
          bottom[row_index][column_index] = "#" if column == "#"
        else
          bottom[row_index] = row
        end
      end
    end

    bottom.reverse    
  end

  
end
data =  read_input("input13.txt")
puts "Part 1"
tp = TransparentPaper.new(data[0], data[1])
tp.process_folds(break_after_step: 0)
puts "#{tp.dot_count} dot(s)"


puts "\nPart 2"
tp = TransparentPaper.new(data[0], data[1])
tp.process_folds
tp.print