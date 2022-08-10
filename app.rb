class Grid

    def initialize(row,col)

        @row = row
        @col = col
        @grid = Array.new(row) { Array.new(col) { Cell.new } } 
               
        
    end

    def print_g

        @row.times do |i|

                @col.times do |j|
                print @grid[i][j].status
                

            end

            puts ""

        end

        puts ""
        
    end 


end

class Cell 

    #reader
    attr_reader :status

    def initialize

        @type_of_cell = [".","*"]
        @status = @type_of_cell[rand(2)]

    end 

end


print "Inserte número de filas "
row = gets.chomp.to_i 
print "Inserte número de columnas "
col = gets.chomp.to_i 

newGrid = Grid.new(row,col)
newGrid.print_g







