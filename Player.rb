

class Player

	@score
	@username

	def initialize(id, username, win_pattern)
		@id = id
		@username = username
		@win_pattern = win_pattern
	end

	def add_score(point)
		@score = @score + point
	end

	def get_id
		return @id
	end

	def get_username
		return @username
	end


	def get_win_pattern
		return @win_pattern
	end
end
