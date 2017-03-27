
class AI

	def initialize(difficulty_level)
		@difficulty_level = difficulty_level
	end

	def compute_horizontal_score(board_array,player,direction)
		player_id = player.get_id

		player_pattern = player.get_win_pattern

		score_hash = Hash.new
		board_array.each_with_index do |row , row_index|
			score_counter = 0
			found_piece = false
			row=(direction)? row : row.reverse
			row.each_with_index do |column, column_index|
				c_index=(direction)? column_index : 6 - column_index

				if player_pattern[score_counter] == board_array[row_index][c_index]
					score_counter=score_counter+1
					found_piece = true
				end

				if board_array[row_index][c_index] == 0 && found_piece
					# p board_array[row_index][c_index]
					if score_counter == 0
						score_counter=1
					end
					score = score_counter*10
					score_hash[[row_index,c_index]]=[player_id,score]
					found_piece = false
				end
			end
		end
		return score_hash

	end


	def compute_vertical_score(board_array, player)
		player_pattern = player.get_win_pattern
		player_id = player.get_id
		score_hash = Hash.new
		for column_index in 0..board_array[0].length-1
			found_piece = false
			score_counter = 0
			board_array.each_with_index do |row , row_index|

				if player_pattern[score_counter] == board_array[row_index][column_index]
					score_counter=score_counter+1
					found_piece = true
				elsif board_array[row_index][column_index] != 0
					found_piece = false
					score_counter=0
				end

				if board_array[row_index][column_index] == 0 && found_piece
					# p board_array[row_index][c_index]
					if score_counter == 0
						score_counter=1
					end
					score = score_counter*10
					score_hash[[row_index,column_index]]=[player_id,score]
					found_piece = false
				end
			end
		end
		return score_hash
	end

	# need to diagonal

	# def compute_right_diagonal_score(board_array,player_id,enemy_id)
	#
	# 	score_hash = Hash.new
	# 	for row_index in 0..board_array.length-1
	# 		for column_index in 0..board_array[0].length-1
	# 			temp_row=row_index
	# 			temp_column=column_index
	#
	# 			score_counter=0
	#
	# 			player_self =true
	# 			found_piece = false
	#
	# 			while (1)
	# 				# p temp_row
	# 				# p temp_column
	# 				board_value=board_array[temp_row][temp_column]
	#
	# 				if board_array[temp_row][temp_column] != 0
	# 					found_piece = true
	# 				end
	#
	# 				if player_self && player_id==board_value
	# 					score_counter=score_counter+1
	# 				end
	#
	# 				if player_self && enemy_id==board_value
	# 					score_counter=0
	# 					player_self = false
	# 				end
	#
	# 				if !player_self && enemy_id==board_value
	# 					score_counter=score_counter+1
	# 				end
	#
	# 				if !player_self && player_id==board_value
	# 					score_counter=0
	# 					player_self = true
	# 				end
	#
	# 				if board_value == 0 && found_piece
	# 					p board_value
	# 					id =(player_self)? player_id : enemy_id
	# 					if score_counter == 0
	# 						score_counter=1
	# 					end
	# 					score = score_counter*10 +((player_self)? 5 : 0)
	# 					p id
	# 					score_hash[[temp_row,temp_column]]=[id,score]
	# 					found_piece = false
	# 				end
	#
	# 				temp_row=temp_row+1
	# 				temp_column=temp_column+1
	#
	# 				if temp_column >= board_array[0].length || temp_row >= board_array.length
	# 					break
	# 				end
	#
	# 			end
	#
	#
	# 		end
	# 	end
	# 	return score_hash
	# end

	def compute_right_diagonal_up_score(board_array,player)
		player_pattern = player.get_win_pattern
		player_id = player.get_id
		score_hash = Hash.new

		for row_index in 0..board_array.length-1
			for column_index in 0..board_array[0].length-1
				temp_row_index=row_index
				temp_column_index=column_index
				score_counter = 0
				found_piece = false

				while (!(temp_column_index >= board_array[0].length || temp_row_index >= board_array.length))
					board_value=board_array[temp_row_index][temp_column_index]

					if player_pattern[score_counter]==board_value
						score_counter=score_counter+1
						found_piece = true
					elsif board_array[temp_row_index][temp_column_index] != 0
						found_piece = false
						score_counter=0
					end

					if board_array[temp_row_index][temp_column_index] == 0 && found_piece
						if score_counter == 0
							score_counter=1
						end
						score = score_counter*10
						if !score_hash.key?([temp_row_index,temp_column_index])
							score_hash[[temp_row_index,temp_column_index]]=[player_id,score]
						end
						# found_piece = false
						break
					end
					temp_row_index=temp_row_index+1
					temp_column_index=temp_column_index+1
				end
			end
		end
		return score_hash
	end


	def compute_left_diagonal_score


	end


end
ai = AI.new
board_array = Array.new(6){Array.new(7,0)}
board_array[0][0] = 1
board_array[0][1] = 1
board_array[0][6] = 2
board_array[1][0] = 1
board_array[1][1] = 1
p ai.compute_horizontal_score(board_array,1,2,true)
# p ai.compute_vertical_score(board_array,1,2)
# p ai.compute_right_diagonal_score(board_array,1,2)
