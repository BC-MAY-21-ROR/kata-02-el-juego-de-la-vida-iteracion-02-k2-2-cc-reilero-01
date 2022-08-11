class Game_of_life
    attr_reader :printer
    def initialize(num_of_generations = 2,row,col)
        @num_of_generations = num_of_generations
        @newGrid = Grid.new(row,col)
        @printer = Printer.new(@newGrid)
    end


end

class Grid
    attr_reader :row, :col, :grid
    def initialize(row,col)
        @row = row
        @col = col
        @grid = Array.new(row) { Array.new(col) { Cell.new } }
        get_neighbors
        count_neighbors      
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
                cell.neighbors.each do |neighbor|
                    
                end
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
    attr_accessor :neighbors
    attr_reader :status
    def initialize
        @type_of_cell = [".","*"]
        @status = @type_of_cell[rand(2)]
        @neighbors = []
    end 

    def is_alive
        return @status=='*'
    end
end


print "Inserte número de filas "
row = gets.chomp.to_i 
print "Inserte número de columnas "
col = gets.chomp.to_i 

game = Game_of_life.new(row,col)
game.printer.print_grid
game.printer.print_neighbors(0,0)






