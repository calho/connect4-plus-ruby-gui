
def pre_add_piece(player_id, button_id, board_array)
	assert_respond_to(player_id, :round, 'invalid player_id')
	assert_respond_to(button_id, :round, 'invalid button_id')
	assert(button_id > 0, 'giving a negative button id')
	column_number = button_id%7
	column = board_array.transpose[column_number]
	assert((column.include? 0), 'column too full')
end

def post_add_piece()
	assert(yield, 'failed in adding piece properly')
end

def pre_clear(board_array)
	assert((defined? board_array) != nil, 'no board array was created')
end	

def post_clear(board_array)
	assert(board_array.all? {|row| row.all? {|column| column == 0}}, 'board failed to clear')
end

def pre_check_for_winner(player)
	assert_respond_to(player, :get_win_pattern, 'invalid player passed')
end