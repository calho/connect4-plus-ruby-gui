
require_relative 'Player'

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
			elsif board_array[row_index][column_index] != 0
				found_piece = false
				score_counter=0
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


board_array = Array.new(6){Array.new(7,0)}
player1 = Player.new(1,"J",[1,1,1,1])

board_array[0][0] = 1
board_array[0][1] = 1
board_array[1][0] = 2
board_array[1][1] = 2
board_array[2][0] = 1
board_array[2][1] = 1
p compute_vertical_score(board_array,player1)
