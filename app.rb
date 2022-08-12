class Game_of_life
    attr_reader :printer
    def initialize(num_of_generations = 2,row,col)
        puts "Generation 1:"
        @num_of_generations = num_of_generations
        @newGrid = Grid.new(row,col)
        @printer = Printer.new(@newGrid)
        @printer.print_grid
    end
    def next_generation 
        @num_of_generations.times do |i|
            puts "Generation #{i+2}:"
            @newGrid.count_neighbors
            @newGrid.update_grid
            @printer.print_grid
        end
    end


end

class Grid
    attr_reader :row, :col, :grid
    def initialize(row,col)
        @row = row
        @col = col
        @grid = Array.new(row) { Array.new(col) { Cell.new } }
        get_neighbors
              
    end

    def get_neighbors
        @row.times do |i|
            @col.times do |j|
                neighbors=[]
                neighbors << (valid_neighbor(i,j-1)? @grid[i][j-1] : nil)
                neighbors << (valid_neighbor(i-1,j-1)? @grid[i-1][j-1] : nil)
                neighbors << (valid_neighbor(i+1,j-1)? @grid[i+1][j-1] : nil)
                neighbors << (valid_neighbor(i-1,j)? @grid[i-1][j]: nil)
                neighbors << (valid_neighbor(i-1,j+1)? @grid[i-1][j+1]: nil)
                neighbors << (valid_neighbor(i+1,j)? @grid[i+1][j] : nil)
                neighbors << (valid_neighbor(i+1,j+1)? @grid[i+1][j+1] : nil)
                neighbors << (valid_neighbor(i,j+1)? @grid[i][j+1]: nil)
                neighbors.compact!
                @grid[i][j].neighbors = neighbors
            end
        end
    end

    def valid_neighbor(x,y)
        x>=0 && x < @row && y >=0 && y < @col
    end

    def count_neighbors
        @row.times do |row|
             @grid[row].each do |cell|
                alive_count=0
                dead_count=0
                cell.neighbors.each do |neighbor|
                    neighbor.is_alive ? alive_count+=1 : dead_count+=1             
                   
                end
                cell.alive_neighbors=alive_count
                cell.dead_neighbors=dead_count


            end 
        end
    end
    def will_die(cell)
        cell.is_alive&&(cell.alive_neighbors<2||cell.alive_neighbors>3)
    end

    def will_live(cell)
        (cell.is_alive&&(cell.alive_neighbors==2||cell.alive_neighbors==3))||(!cell.is_alive&&cell.alive_neighbors==3)
    end
    def update_grid
        @row.times do |i|
    
            @col.times do |j|
            
                will_die(@grid[i][j])? @grid[i][j].kill_cell : will_live(@grid[i][j])? @grid[i][j].revive_cell : ""
                

            end
        end
    end
 
end





class Printer
    def initialize(grid_object)
        @grid_object = grid_object
    end

    def print_grid
        @grid_object.row.times do |i|
                @grid_object.col.times do |j|
                print @grid_object.grid[i][j].status + "  "
            end
            puts ""
        end
        puts ""
    end

    def print_neighbors(x,y)
        puts "neighbors for cell (#{x},#{y})"
        @grid_object.grid[x][y].neighbors.each do |neighbors|
            print neighbors.status + "  " 
        end
        puts ""
    end 
end

class Cell 
    #reader
    attr_accessor :neighbors, :alive_neighbors, :dead_neighbors  
    attr_reader :status
    def initialize
        alive_neighbors=0
        dead_neighbors=0
        @type_of_cell = [".","*"]
        @status = @type_of_cell[rand(2)]
        @neighbors = []
    end 

    def is_alive
        @status=='*'
    end
    def is_dead
        @status=='.'
    end
    def kill_cell
        @status='.'
    end
    def revive_cell
        @status='*'
    end
end


print "Inserte número de filas "
row = gets.chomp.to_i 
print "Inserte número de columnas "
col = gets.chomp.to_i 
print "Inserte número de generaciones "
num_of_generations = gets.chomp.to_i 

game = Game_of_life.new(num_of_generations,row,col)
game.next_generation




