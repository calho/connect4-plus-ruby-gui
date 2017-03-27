
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