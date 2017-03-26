
require 'observer'

class BoardModel

	include Observable
	def initialize()
		@board_array = Array.new(6){Array.new(7,0)}
		@rows = 6
		@columns = 7
	end


	def get_array
		changed
		notify_observers(Time.now)
		return @board_array
	end


	def to_s

		return_str = ""
		@board_array.reverse.each do |row|
			return_str=return_str+row.to_s+"\n"
		end
		return return_str
	end

	def add_piece(player_id, button_id)
		# observable

		# pre
		column = button_id%7
		@board_array.each do |row|
			if row[column]==0
				row[column]=player_id
				changed
				notify_observers(Time.now)
				return
			end
		end

		#post 
	end

	def clear

		@board_array = Array.new(6){Array.new(7,0)}
		changed
		notify_observers(Time.now)
	end


	# def get_win_pattern(winpattern)
	# 	a= winpattern[0]
	# 	b=winpattern[1]

	# 	if !block_given?
	# 		myproc = Proc.new{}

	# 	end

	# end

	def check_for_winner(player)
		win_pattern=player.get_win_pattern
		if horizontal_score_iterator(win_pattern) || vertical_score_iterator(win_pattern) || diagonal_right_check(win_pattern) || diagonal_left_check(win_pattern)
			return true
		end
		return false
	end

	def horizontal_score_iterator(win_pattern)
		@board_array.each do |row|
			counter = 0
			row.each do |column|
				if column == win_pattern[counter]
					counter=counter+1
					if counter == win_pattern.length
						p "horizontal winner"
						return true
					end
				else
					counter=0
				end
			end
		end
		return false
	end

	def vertical_score_iterator(win_pattern)
		for column_index in 0..@columns-1
			counter = 0
			@board_array.each do |row|
				if row[column_index] == win_pattern[counter]
					counter=counter+1
					if counter == win_pattern.length
						p "vertical winner"
						return true
					end
				else
					counter=0
				end
			end
		end
		return false
	end

	def diagonal_right_check(win_pattern)
		
		for row_index in 0..@rows-1
			for column_index in 0..@columns-1
				if @board_array[row_index][column_index] == win_pattern[0]
					temp_row=row_index
					temp_column=column_index
					check_value=win_pattern[0] 
					counter=0

					while (check_value==win_pattern[counter])
						counter = counter + 1
						if counter == win_pattern.length
							p "diagonal winner"
							return true
						end

	
						temp_row = temp_row + 1
						temp_column = temp_column + 1
						if temp_column >= @columns || temp_row >= @rows
							break
						end

						check_value=@board_array[temp_row][temp_column]
						
					end
				end
			end

		end
		return false
	end

	def diagonal_left_check(win_pattern)
		for row_index in 0..@rows-1
			for column_index in 0..@columns-1
				if @board_array[row_index][column_index] == win_pattern[0]
					temp_row=row_index
					temp_column=column_index
					check_value=win_pattern[0] 
					counter=0

					while (check_value==win_pattern[counter])
						counter = counter + 1
						if counter == win_pattern.length
							p "diagonal left winner"
							return true
						end

	
						temp_row = temp_row + 1
						temp_column = temp_column - 1
						if temp_column < 0 || temp_row >= @rows
							break
						end

						check_value=@board_array[temp_row][temp_column]
						
					end
				end
			end

		end
		return false
	end
end