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
	
	def show
		puts "id: #{id} column: #{column} row: #{row}"
	end
	
	attr_reader :id, :row, :column, :is_good
	attr_writer :row, :column, :is_good
end

def build_queens(build_num)
	x = 0
	while (x < build_num)
		$q_array[x] = Queen.new(x+1)
		x += 1
	end
end

def show_queens
	for queen in $q_array
		queen.show
	end
end

def attack_check(q_check)
	#first attack check, make sure queen isn't on the same row
	for q in $q_array
		if(q.id != q_check.id && nil != q.row && q.row == q_check.row)
			return true
		end
	end
	
	return false
end

def position_queen(q_placed, initcol)
	if(nil == q_placed.column)
		q_placed.column = initcol
		q_placed.row = 1
	end
	
	q_placed.is_good = false
	
	while(q_placed.row <= $nQ && !q_placed.is_good)
		if(attack_check(q_placed))
			q_placed.row += 1
		else
			q_placed.is_good = true
			#puts "this one is good:"
			#q_placed.show
			nextcol = initcol + 1
			nextindex = q_placed.id
			if(nextcol > $nQ)
				return q_placed.is_good
			end
			is_good = position_queen($q_array[nextindex],nextcol) 
			if(!is_good)
				q_placed.is_good = false
				q_placed.row += 1
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
	build_queens($nQ)
	if(position_queen($q_array[0],1))
		show_queens()
	else
		puts "No Solution available for grid size: #{$nQ}"
	end
else
	puts "Come one now! You and I both know we're not going to do that."
end

