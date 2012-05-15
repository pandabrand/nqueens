#!/usr/bin/ruby

#	$nQ user variable for board
$nQ
#	$q_array variable to hold placed queens
$q_array = []

#	class Queen four variables id, row, column, is_good
#		@id int for uniqueness
#		@row int for horizontal placement
#		@column int for vertical placement
#		@is_good boolean for placement verification
#
#		def initialize(int id) constructor for Queen id is required
#			on initialization row and column are set to nil and
#			is_good is set to false. this is the default state.
#
#		def show_queens() method to print out the id, column and row.
class Queen
	def initialize(id)
		@id = id
		@row = nil
		@column = nil
		@is_good = false
	end
	
	def show
		puts "queen: #{id} column: #{column} row: #{row}"
	end
	
	attr_reader :id, :row, :column, :is_good
	attr_writer :row, :column, :is_good
end

#	def show_queens() prints all queens in $q_array using the Queen::show()
def show_queens
	for queen in $q_array
		queen.show
	end
end

#	def Boolean attack_check(Queen q) method to check this queen against other placed 
#		queens. checks three different areas, make sure this queen isn't on a row with  
#		another Queen make sure that there is not a queen in a upper negative upper  
#		diagonal and there is not a queen in the lower negative diagonal. If all those 
#		conditionals are false the method will return false, if any of those conditionals
#		are true the method will return true immediately.
def attack_check(q_check)
	#first attack check, make sure queen isn't on the same row
	for q in $q_array
		if(q.id != q_check.id && q.row == q_check.row)
			return true
		end
	end
	
	#second attack check, make sure that no negative upward diagonals exist
	c = 1
	while(q_check.column - c > 0)
		for q_ud in $q_array
			rowcheck = q_check.row - c
			colcheck = q_check.column - c
			if(q_ud.id != q_check.id && q_ud.column == colcheck && q_ud.row == rowcheck)
				return true
			end
		end
		c += 1
	end
	
	#third attack check, make sure that no negative downward diagonals exist
	d = 1
	while(q_check.column - d > 0)
		for q_ud in $q_array
			rowcheck = q_check.row + d
			colcheck = q_check.column - d
			if(q_ud.id != q_check.id && q_ud.column == colcheck && q_ud.row == rowcheck)
				return true
			end
		end
		d += 1
	end
	
	
	return false
end

#	def Boolean position_queen(Queen q) method to place queens on board starting with a 
#		Queen with a set row and column this method will attempt to place the rest of the
#		Queens moving left to right. If the current Queen's attack_check returns false
#		the Queen will be moved one row down. if it returns true it will attempt to place
#		the next Queen. If that Queen reaches the last row and still can not be placed.
# 		The method will go back to the previous Queen and move that Queen down one more 
# 		row. This will continue until one of two states are reached. It will terminate and #		return true if a Queen is placed in every row and all Queen passed the 
#		attack_check. If the last Queen reaches the last row and a solution has not been
#		found the method will return false.
def position_queen(q_placed)	
	while(q_placed.row <= $nQ && !q_placed.is_good)
		if(attack_check(q_placed))
			q_placed.row += 1
		else
			q_placed.is_good = true
			#puts "this one is good:"
			#q_placed.show
			nextcol = q_placed.column + 1
			nextindex = q_placed.id
			if(nextcol > $nQ)
				return q_placed.is_good
			end
			n_queen = Queen.new(q_placed.id + 1)
			n_queen.row = 1
			n_queen.column = nextcol
			$q_array << n_queen
			is_good = position_queen(n_queen) 
			if(!is_good)
				$q_array.pop
				q_placed.row += 1
				q_placed.is_good = false
			end
		end
	end
	return q_placed.is_good
end	

#	user input get size of board.
puts "Enter a board number:"
$nQ = STDIN.gets
$nQ = $nQ.to_i

#	case to check board size. zero doesn't make sense to solve, neither does one. There  
#	are no valid solutions for 2 or 3. We will accept numbers 4-24, we will not accept 
#	numbers above 25 for the potential high processing time for a solution.
case $nQ
when 0
	puts "Board can't be zero"
when 1
	puts "Board too small to solve"
when 2 .. 3
	puts "No solution for a board size of #{$nQ}"
when 4 .. 24
	t_start = Time.now
	s_queen = Queen.new(1)
	s_queen.row = 1
	s_queen.column = 1
	$q_array << s_queen
	if(position_queen($q_array[0]))
		show_queens()
	else
		puts "No Solution available for board size: #{$nQ}"
	end
	t_end = Time.now
	t_solve = (t_end - t_start)
	puts "Time to solve " + t_solve.to_s
else
	puts "Come on now! You and I both know we're not going to do that."
end

