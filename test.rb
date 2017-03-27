






def compute_horizontal_score(board_array,player,direction)
	score_hash = Hash.new
	board_array.each_with_index do |row , row_index|
		score_counter = 0
		found_piece = false
		row=(direction)? row : row.reverse
		
end