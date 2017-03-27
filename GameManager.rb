
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

	def funnyMethod
		puts 'hi'
	end

	def update(time)		
		funnyMethod
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
		player_id=@player_list[@last_player_id-1].get_id
		if @board_model.add_piece(player_id,button_id)

			@last_player_id= (@last_player_id==1)? 2:1
		end

	end

	def AI_play()

		position=@ai.get_position(@board_model.get_array)
		button_id = position[0]*7+position[1]
		sleep 1
		turn(button_id)


	end




	def check_winner()
		if @board_model.check_for_winner(@player_list[@last_player_id-1])
			return @last_player_id
		end
		return false
	end


end
