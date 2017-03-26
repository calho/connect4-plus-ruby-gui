
require_relative 'BoardModel'
require_relative 'BoardController'
require_relative 'Player'


class GameManager


	@game_type
	@board_model
	@player_list
	@last_player_id
	def initialize()

		@last_player_id=1
	end

	def funnyMethod
		puts 'hi'
	end

	def update(time)		
		funnyMethod
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
		@board_model.add_piece(player_id,button_id)

		@last_player_id= (@last_player_id==1)? 2:1

	end

	def check_winner()
		if @board_model.check_for_winner(@player_list[@last_player_id-1])
			return @last_player_id
		end
		return false
	end


end



# player1 = Player.new(1,"jayfeather",[1,1,1,1])
# player2 = Player.new(2,"shade",[2,2,2,2])
# playerList = PlayerList.new(player1,player2)

# board_model = BoardModel.new()
# game_manager  = GameManager.new
# game_type = "normal"

# game_manager.set_player_list(playerList)
# game_manager.set_board_model(board_model)
# game_manager.set_game_type(game_type)

# # while (!won)
# # 	# turn under won

# # end


# boardmodel1.add_piece(player2.get_id, 7)
# boardmodel1.add_piece(player2.get_id, 14)
# boardmodel1.add_piece(player2.get_id, 21)
# boardmodel1.add_piece(player2.get_id, 28)
# boardmodel1.add_piece(player2.get_id, 35)
# boardmodel1.add_piece(player2.get_id, 15)
# boardmodel1.add_piece(player2.get_id, 22)
# boardmodel1.add_piece(player2.get_id, 29)
# boardmodel1.add_piece(player2.get_id, 36)
# boardmodel1.add_piece(player2.get_id, 23)
# boardmodel1.add_piece(player2.get_id, 30)
# boardmodel1.add_piece(player2.get_id, 37)
# boardmodel1.add_piece(player2.get_id, 31)
# boardmodel1.add_piece(player2.get_id, 38)
# boardmodel1.add_piece(player.get_id, 24)
# boardmodel1.add_piece(player.get_id, 0)
# boardmodel1.add_piece(player.get_id, 8)
# boardmodel1.add_piece(player.get_id, 16)


# boardmodel1.add_piece(player2.get_id, 36)
# boardmodel1.add_piece(player2.get_id, 37)
# boardmodel1.add_piece(player2.get_id, 38)
# boardmodel1.add_piece(player2.get_id, 30)
# boardmodel1.add_piece(player2.get_id, 31)
# boardmodel1.add_piece(player.get_id, 29)
# boardmodel1.add_piece(player.get_id, 23)
# boardmodel1.add_piece(player.get_id, 17)
# boardmodel1.add_piece(player.get_id, 24)

# boardmodel1.add_piece(player.get_id, 35)



# puts boardmodel1

# boardmodel1.check_for_winner(player)

# test = GameManager.new(boardmodel1)

# boardmodel1.get_array