require 'gtk3'
require_relative 'BoardModel'
require_relative 'BoardController'
require_relative 'Player'
require_relative 'PlayerList'
require_relative 'GameManager'
require_relative 'AI'
class App


	def initialize

		Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file("GameBoard.glade")

        @builder.add_from_file("StartMenu.glade")


        @startMenu = @builder.get_object("StartMenu")
        @startMenu.signal_connect("destroy") {Gtk.main_quit}
        @startMenu.set_default_size(200, 200)
        @window = @builder.get_object("window")
        @window.signal_connect("destroy") { Gtk.main_quit }
        @connect4grid = @builder.get_object("connect4grid")

        # background = Gtk::Image.new :file => "board.png"

        # @connect4grid.image = background

        # @game_over_dialog = Gtk::MessageDialog.new(:parent => nil, :flags => :destroy_with_parent,
        #                     :type => nil, :buttons_type => "Restart", :buttons_type => "Menu" 
        #                     :message => "Game Over")

        # @game_over_dialog = @builder.get_object("game over dialog")

        # game_over_dialog.signal_connect("response") {dialog.destroy}
        # game_over_dialog.vbox.add(@builder.get_object("Message"))
        # dialog.show_all


		@window.set_default_size(798, 690)        

        @startMenu.show()

        @singleP = @builder.get_object("Single Player")
        @twoP = @builder.get_object("Two Players")
        @forfeit = @builder.get_object("Forfeit")
        @forfeit.signal_connect("clicked") do
            player = @game_manager.get_last_player_id-1
            if player == 0
                player = 2
            end
            game_over_window(player)
        end
        @menu = @builder.get_object("GameBoard Menu")
        @menu.signal_connect("clicked") do
            go_to_menu
        end


        sidebar_bg = Gdk::RGBA::new(200.0/255.0,197.0/255.0,190.0/255.0,1.0)
        sidebar1 = @builder.get_object("sidebar1")
        sidebar1.override_background_color(0, sidebar_bg )
        sidebar2 = @builder.get_object("sidebar2")
        sidebar2.override_background_color(0, sidebar_bg )
        sidebar3 = @builder.get_object("sidebar3")
        sidebar3.override_background_color(0, sidebar_bg )

        @player_turn = @builder.get_object("player turn")
        @player_turn.label=("player1's turn")
        @player_turn.override_background_color(0, sidebar_bg )

        @original = @builder.get_object("original").set_active(true)
        @ottoToot = @builder.get_object("OTTO&TOOT").set_active(false)

        @game_mode = "original"
     
        @builder.get_object("Start").signal_connect("clicked") do 
        	if (@singleP.active? or @twoP.active?)
        		@startMenu.hide
        		@window.show
                if (@original.active?)
                    @game_mode = "original"
                elsif @ottoToot.active?
                    @game_mode = "OTTO&TOOT"
                end
                self.run
                    
        	end
        end

        @array_of_red_tokens = Array.new
        generate_red_token = Proc.new{ red_token = Gtk::Image.new :file => "red_token.png" 
        	@array_of_red_tokens << red_token
        	}

        for i in 0..42
        	generate_red_token.call
        end

        @array_of_yellow_tokens = Array.new
        generate_yellow_token = Proc.new{ yellow_token = Gtk::Image.new :file => "yellow_token.png" 
        	@array_of_yellow_tokens << yellow_token
        	}

        for i in 0..42
        	generate_yellow_token.call
        end

        @array_of_board_pieces = Array.new
        generate_board_piece = Proc.new{ board_piece = Gtk::Image.new :file => "board_piece.png"
        	@array_of_board_pieces << board_piece
        	}

        for i in 0..42
        	generate_board_piece.call
        end

        @array_of_T_tokens = Array.new
        generate_T_tokens = Proc.new{ t_token = Gtk::Image.new :file => "T_token.png" 
            @array_of_T_tokens << t_token
            }

        for i in 0..42
            generate_T_tokens.call
        end

        @array_of_O_tokens = Array.new
        generate_O_tokens = Proc.new{ o_token = Gtk::Image.new :file => "O_token.png"
            @array_of_O_tokens << o_token
            }

        for i in 0..42
            generate_O_tokens.call
        end

        # @board_status = Array.new(42)

        bg = Gdk::RGBA::new(63.0/255.0,72.0/255.0,204.0/255.0,1.0)
        @window.override_background_color(0, bg)

        @array_of_buttons = Array.new
        add_button_to_array = Proc.new{|button| @array_of_buttons << button}
        set_button_function = Proc.new{ |i| button = @builder.get_object("button#{i}")
        	add_button_to_array.call(button)

            # button.override_background_color(0, bg)

        	button.image = @array_of_board_pieces[i]
        	button.signal_connect("clicked") do

                turn_front_end(i)

     		end
     	}
     	
        for i in 0..41
        	set_button_function.call(i)
        end



        # p @array_of_buttons
        # self.run

        Gtk.main()

        
	end

	def on_button_press(button) 
		puts "button #{button} pressed "
	end

	def update_board() 
        one_board_status = @game_manager.get_board_array.reverse.flatten
		one_board_status.each_with_index do |status, index|
			button = @array_of_buttons[index]
			if status == 1
                if @game_mode == "original"
				    player1_token = @array_of_red_tokens[index]
                elsif @game_mode == "OTTO&TOOT"
                    player1_token = @array_of_T_tokens[index]
                end
				button.image = player1_token
			elsif status == 2
                if @game_mode == "original"
				    player2_token = @array_of_yellow_tokens[index]
                elsif @game_mode == "OTTO&TOOT"
                    player2_token = @array_of_O_tokens[index]
                end
				button.image = player2_token
            else 
                board_piece = @array_of_board_pieces[index]
                button.image = board_piece
			end
		end
				
	end


    def run

        @board_model = BoardModel.new()
        @board_model.add_observer(self)
        @game_manager  = GameManager.new
        
        # if @original.active?
        if @twoP.active?
            if @game_mode == "original"
                player1 = Player.new(1,"jayfeather",[1,1,1,1])
                player2 = Player.new(2,"shade",[2,2,2,2])
            elsif @game_mode == "OTTO&TOOT"
                player1 = Player.new(1,"jayfeather",[1,2,2,1])
                player2 = Player.new(2,"shade",[2,1,1,2])
            end

        end

        if @singleP.active?
            if @game_mode == "original"
                player1=Player.new(1,"jayfeather",[1,1,1,1])
                player2=Player.new([2,2,2,2])
            elsif @game_mode == "OTTO&TOOT"
                player1 = Player.new(1,"shade",[1,2,2,1])
                player2=Player.new([2,1,1,2])
            end
            # should take in difficulty level HARDCODED FOR NOW      
            ai = AI.new(1)
            @game_manager.set_ai(ai)
        end
        @playerList = PlayerList.new(player1,player2)
        p @playerList.get_list

        # end

        @game_manager.set_player_list(@playerList)
        @game_manager.set_board_model(@board_model)
        @game_manager.set_game_type(@game_type)


    end

    def turn_front_end(button_id)

        if @twoP.active?
            @game_manager.turn(button_id)
        else
            @game_manager.turn(button_id)
            update_board()
            @game_manager.AI_play()
        end
        update_board()
        puts button_id

    end


    def go_to_menu
        if block_given?
            yield
        end
        @window.hide
        @game_manager.clear_board
        update_board
        @startMenu.show
        @connect4grid.sensitive=(true)
    end

    def game_over_window(player)
        message =  "Game Over, Player#{player} Won!"
        dialog = Gtk::Dialog.new
        dialog.title = "Game Over"
        dialog.transient_for = @window
        dialog.set_default_size(300, 100)
        dialog.resizable=(false)
        label = Gtk::Label.new(message)
        dialog.child.add(label)
        dialog.add_button("Restart", 1)
        dialog.add_button("Menu", 2)

        dialog.signal_connect("response") do |widget, response|
            case response
            when 1
                p "RESTART"
                @game_manager.clear_board
                update_board
                dialog.hide
                @connect4grid.sensitive=(true)
            when 2
                p "MENU"
                go_to_menu{dialog.hide}

            end
        end
        @connect4grid.sensitive=(false)
        dialog.show_all
    end

    def update(time)        
        if @game_manager.check_winner
            game_over_window(@game_manager.check_winner)

            p "won"
        else
            if @game_manager.get_last_player_id == 1
                @player_turn.label=("player1's turn")
            elsif @game_manager.get_last_player_id == 2
                @player_turn.label=("player2's turn")
            end
            p "no one wins yet"
        #draw
        end
    end


end


app = App.new
# app.run
