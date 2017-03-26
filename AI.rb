
class AI

	def initialize

	end

	def compute_score(board_array, player_id)
		

	end

	def compute_horizontal_score(board_array, player_id, enemy_id,direction)

		score_hash = Hash.new
		board_array.each_with_index do |row , row_index|
			score_counter = 0
			# score_counter_enemy=0
			player_self =true
			found_piece = false
			row=(direction)? row : row.reverse
			p row
			row.each_with_index do |column, column_index|

				if board_array[row_index][column_index] != 0
					found_piece = true
				end

				if player_id == board_array[row_index][column_index] && player_self == true
					score_counter=score_counter+1

				end

				if player_id == board_array[row_index][column_index] && player_self == false
					score_counter = 0
					player_self = true

				end

				if enemy_id == board_array[row_index][column_index] && player_self == true
					score_counter = 0
					player_self = false

				end


				if enemy_id == board_array[row_index][column_index] && player_self == false
					score_counter=score_counter+1
				end

				if board_array[row_index][column_index] == 0 && found_piece
					p board_array[row_index][column_index]
					id =(player_self)? player_id : enemy_id
					if score_counter == 0
						score_counter=1
					end
					score = score_counter*10 +((player_self)? 5 : 0)
					p id
					score_hash[[row_index,]]=[id,score]
					found_piece = false
				end

			end

		end
		return score_hash
	end



	def compute_vertical_score

	end

	def compute_left_diagonal_score

	end

	def compute_right_diagonal_score

	end


end
ai = AI.new
board_array = Array.new(6){Array.new(7,0)}
board_array[0][0] = 2
board_array[0][1] = 1

p ai.compute_horizontal_score(board_array,1,2,false)


