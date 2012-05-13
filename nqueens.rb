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
	show_queens()
else
	puts "Come one now! You and I both know we're not going to do that."
end

