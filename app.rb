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


        red_token = Gtk::Image.new("red_token.png")
        yellow_token = Gtk::Image.new("yellow_token.png")

        @array_of_buttons = Array.new
        set_button_function = Proc.new{ |i| button = @builder.get_object("button#{i}")
        	button.signal_connect("clicked") do
         	puts "#{i}"
         	button.image = red_token
     		end
     	}
        for i in 0..41
        	set_button_function.call(i)
        end

        # p @array_of_buttons

        Gtk.main()

        
	end

	def on_button_press(button) 
		puts "button #{button} pressed "
	end




end


app = App.new
