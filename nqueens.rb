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
		puts "id: #{id} column: #{column} row: #{row}"
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
# 	c = 1
# 	while(q_check.column - c > 0)
# 		for q_ud in $q_array
# 			rowcheck = q_check.row - c
# 			colcheck = q_check.column - c
# 			#puts "up q_check = " + q_check.id.to_s + " rowcheck = #{rowcheck} colcheck = #{colcheck}"
# 			if(q_ud.id != q_check.id && nil != q_ud.column && q_ud.column == colcheck && q_ud.row == rowcheck)
# 				puts "its a hit! #{rowcheck},#{colcheck} " + q_check.id.to_s
# 				return true
# 			end
# 		end
# 		c += 1
# 	end
	
	#third attack check, make sure that no left downward diagonals exist
# 	d = 1
# 	while(q_check.column - d >= 0 && q_check.row + d <= $q_array.length)
# 		for q_ud in $q_array
# 			rowcheck = q_check.row + d
# 			colcheck = q_check.column - d
# 			puts "down check: q_check = " + q_check.id.to_s + " rowcheck = #{rowcheck} colcheck = #{colcheck}"
# 			if(q_ud.id != q_check.id && nil != q_ud.column && q_ud.column == colcheck && q_ud.row == rowcheck)
# 				#puts "its a hit! #{rowcheck},#{colcheck}" + q_check.show
# 				return true
# 			end
# 		end
# 		d += 1
# 	end
	
	
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
			end
		end
	end
# 	if(!q_placed.is_good)
# 		puts "resetting queen: " + q_placed.id.to_s
# 		q_placed.reset_queen
# 	end
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
	s_queen = Queen.new(1)
	s_queen.row = 1
	s_queen.column = 1
	$q_array << s_queen
	if(position_queen($q_array[0]))
		show_queens()
	else
		puts "No Solution available for grid size: #{$nQ}"
	end
else
	puts "Come one now! You and I both know we're not going to do that."
end

