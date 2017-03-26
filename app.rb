require 'gtk3'
require_relative 'BoardModel'
require_relative 'BoardController'
require_relative 'Player'
require_relative 'PlayerList'
require_relative 'GameManager'
class App


	def initialize

		Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file("GameBoard.glade")

        @builder.add_from_file("StartMenu.glade")


        startMenu = @builder.get_object("StartMenu")
        startMenu.set_default_size(200, 200)
        window = @builder.get_object("window")
        window.signal_connect("destroy") { Gtk.main_quit }

		window.set_default_size(798, 690)        

        startMenu.show()

        @singleP = @builder.get_object("Single Player")
        @twoP = @builder.get_object("Two Players")

     
        @builder.get_object("Start").signal_connect("clicked") do 
        	if (@singleP.active? or @twoP.active?)
        		startMenu.destroy()
        		window.show()
        	end
        end


        @original = @builder.get_object("original").set_active(true)
        @ottoToot = @builder.get_object("OTTO&TOOT").set_active(false)


        red_token = Gtk::Image.new("red_token.png")
        yellow_token = Gtk::Image.new("yellow_token.png")

        @array_of_buttons = Array.new
        set_button_function = Proc.new{ |i| button = @builder.get_object("button#{i}")
        	button.signal_connect("clicked") do

            turn_front_end(i)
            button.image = red_token
     		end
     	}
        for i in 0..41
        	set_button_function.call(i)
        end

        # p @array_of_buttons
        self.run
        Gtk.main()

        
	end

	def on_button_press(button) 
		puts "button #{button} pressed "
	end


    def run
        
        if @original.active?
            if @twoP.active?
                player1 = Player.new(1,"jayfeather",[1,1,1,1])
                player2 = Player.new(2,"shade",[2,2,2,2])
                @playerList = PlayerList.new(player1,player2)
                p @playerList.get_list
            end

        end

        @board_model = BoardModel.new()
        @board_model.add_observer(self)
        @game_manager  = GameManager.new
        @game_type = "normal"

        @game_manager.set_player_list(@playerList)
        @game_manager.set_board_model(@board_model)
        @game_manager.set_game_type(@game_type)


    end

    def turn_front_end(button_id)

        @game_manager.turn(button_id)

        puts button_id

    end

    def update(time)        
        if @game_manager.check_winner
            p "won"
        else
            p "no one wins yet"
        #draw
        end
    end


end


app = App.new
# app.run
