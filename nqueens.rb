#!/usr/bin/ruby

$nQ
$q_array = []

class Queen
	def initialize(id)
		@id = id
		@row = nil
		@column = nil
		@is_good = false
	end
	
	def reset_queen
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

def show_queens
	for queen in $q_array
		queen.show
	end
end

def attack_check(q_check)
	#first attack check, make sure queen isn't on the same row
	for q in $q_array
		if(q.id != q_check.id && q.row == q_check.row)
			return true
		end
	end
	
	#second attack check, make sure that no left upward diagonals exist
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
	
	#third attack check, make sure that no left downward diagonals exist
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

puts "Enter a grid number:"
$nQ = STDIN.gets
$nQ = $nQ.to_i

case $nQ
when 0
	puts "Grid can't be zero"
when 1
	puts "Grid too small to solve"
when 2
	puts "No solution for a grid size of 2"
when 3
	puts "No solution for a grid size of 3"
when 4 .. 24
	t_start = Time.now
	s_queen = Queen.new(1)
	s_queen.row = 1
	s_queen.column = 1
	$q_array << s_queen
	if(position_queen($q_array[0]))
		show_queens()
	else
		puts "No Solution available for grid size: #{$nQ}"
	end
	t_end = Time.now
	t_solve = (t_end - t_start)
	puts "Time to solve " + t_solve.to_s
else
	puts "Come one now! You and I both know we're not going to do that."
end

