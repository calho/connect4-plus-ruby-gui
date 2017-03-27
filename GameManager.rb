
require_relative 'BoardModel'
require_relative 'BoardController'
require_relative 'Player'


class GameManager


	@game_type
	@board_model
	@player_list
	@last_player_id
	@ai
	def initialize()

		@last_player_id=1
	end

	def set_ai(ai)
		@ai = ai
	end

	def set_game_type(game_type)
		@game_type = game_type
	end
	
	def set_board_model(board_model)
		@board_model = board_model
	end

	def set_player_list(player_list)
		@player_list = player_list.get_list
	end


	def clear_board
		@board_model.clear
	end


	def get_board_array
		@board_model.get_array
	end

	def get_last_player_id
		@last_player_id
	end


	def turn(button_id)
		# p @player_list.class
		# p @last_player_id
		# p @player_list[@last_player_id-1]
		# p @player_list.length
		# p "turn"
		# p @player_list[@last_player_id-1].get_id
		player_id=@player_list[@last_player_id-1].get_id
		# p @board_model.get_array
		if @board_model.add_piece(player_id,button_id)
			p "GETTING HERE"
			@last_player_id= (@last_player_id==1)? 2:1
		end
		# p "turn"
		# p @player_list[@last_player_id-1].get_id

	end

	def AI_play()


		enemy_index = (@last_player_id==1)? 2:1
		enemy_player = @player_list[enemy_index-1]
		position=@ai.get_position(@board_model.get_array,@player_list[@last_player_id-1],enemy_player)
		p "position"
		p position
		button_id = position[0]*7+position[1]
		p button_id
		# sleep 1
		p "RIGHT BEFORE"
		turn(button_id)


	end




	def check_winner()
		if @board_model.check_for_winner(@player_list[@last_player_id-1])
			return @last_player_id
		end
		return false
	end


end
