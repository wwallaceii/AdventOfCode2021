def read_octopus_input(file_name)
    grid = []
    File.open(file_name).each do |line|
        row = line.chomp.split("").map(&:to_i)
        grid << row
    end
    
    grid
end

class Simulation    
    def initialize(grid)
        @grid = grid
        @step = 0
        @total_flashes = 0
    end

    def run(num_steps)
        num_steps.times { next_step }
    end

    def run_until_synchronized_flash
        while !all_flashed
          next_step
        end
        puts "All flashed at: Step #{@step}"
    end
    

    def display_grid
       puts "Step #{@step}: #{@total_flashes} flash(es)\n"
       @grid.each { |row| puts "\t#{row.join("\t")}"}
    end 

    private

    def next_step
        @step += 1
        flash_queue = []
        flashed = []
        @grid.map!.with_index do |row, row_index|
            row.map!.with_index do |energy_level, column_index|
                flash_queue.unshift [row_index, column_index] if (energy_level + 1) == 10
                energy_level += 1
            end
        end

        while !flash_queue.empty?
            position = flash_queue.pop
            row = position[0]
            column = position[1]
            @total_flashes += 1
            flash(row - 1, column, flash_queue) # up
            flash(row - 1, column + 1, flash_queue) # diag_up_right
            flash(row, column + 1, flash_queue) # right
            flash(row + 1, column + 1, flash_queue) # diag_down_right
            flash(row + 1, column, flash_queue) # down
            flash(row + 1, column - 1, flash_queue) # diag_down_left
            flash(row, column - 1, flash_queue) # left
            flash(row - 1, column - 1, flash_queue) # diag_up_left
        end

        reset_flashed
        display_grid
    end
    
    def all_flashed
        @grid.flatten.all? {|value| value == 0}
    end

    def flash(row, column, queue)
        if( row >=0 &&
            row < @grid.length &&
            column >= 0 &&
            column < @grid[row].length)
            @grid[row][column] += 1

            queue.unshift [row, column] if @grid[row][column] == 10
        end
    end

    def reset_flashed
        @grid.map! do |row|
            row.map! do |energy_level|
                energy_level = 0 if energy_level > 9
                energy_level
            end
        end
    end
end
octopus_grid = read_octopus_input "input11.txt"

simulation = Simulation.new(octopus_grid)
simulation.display_grid
simulation.run_until_synchronized_flash