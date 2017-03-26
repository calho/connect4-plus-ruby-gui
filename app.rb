require 'gtk3'

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

        singleP = @builder.get_object("Single Player")
        twoP = @builder.get_object("Two Players")

     
        @builder.get_object("Start").signal_connect("clicked") do 
        	if (singleP.active? or twoP.active?)
        		startMenu.destroy()
        		window.show()
        	end
        end

        original = @builder.get_object("original").set_active(true)
        ottoToot = @builder.get_object("OTTO&TOOT").set_active(false)

        @array_of_red_tokens = Array.new
        generate_red_token = Proc.new{ red_token = Gtk::Image.new("red_token.png") 
        	@array_of_red_tokens << red_token
        	}

        for i in 0..42
        	generate_red_token.call
        end

        @array_of_yellow_tokens = Array.new
        generate_yellow_token = Proc.new{ yellow_token = Gtk::Image.new("yellow_token.png") 
        	@array_of_yellow_tokens << yellow_token
        	}

        for i in 0..42
        	generate_yellow_token.call
        end

        @array_of_board_pieces = Array.new
        generate_board_piece = Proc.new{ board_piece = Gtk::Image.new("board_piece.png") 
        	@array_of_board_pieces << board_piece
        	}

        for i in 0..42
        	generate_board_piece.call
        end


        # @red_token = Gtk::Image.new("red_token.png")
        # @red_token1 = Gtk::Image.new("red_token.png")
        # @yellow_token = Gtk::Image.new("yellow_token.png")

        @board_status = Array.new(42)

        @array_of_buttons = Array.new
        add_button_to_array = Proc.new{|button| @array_of_buttons << button}
        set_button_function = Proc.new{ |i| button = @builder.get_object("button#{i}")
        	add_button_to_array.call(button)
        	button.image = @array_of_board_pieces[i]
        	button.signal_connect("clicked") do
         	puts "#{i}"
     		@board_status[i] = 1
     		update_board(@board_status)
     		p @board_status
         	# button.image = red_token
     		end
     	}
     	
        for i in 0..41
        	set_button_function.call(i)
        end

        p @array_of_buttons

        Gtk.main()

	end

	def on_button_press(button) 
		puts "button #{button} pressed "
	end

	def update_board(board_status) 
		board_status.each_with_index do |status, index|
			button = @array_of_buttons[index]
			if status == 1
				red_token = @array_of_red_tokens[index]
				button.image = red_token
			elsif status == 2
				yellow_token = @array_of_yellow_tokens[index]
				button.image = yellow_token
			end
		end
				
	end




end


app = App.new
