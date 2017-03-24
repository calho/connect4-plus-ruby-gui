require 'gtk3'

class App


	def initialize
		Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file("GameBoard.glade")


        window = @builder.get_object("window")
        #window.signal_connect("destroy") { Gtk.main_quit }
        window.show()
        Gtk.main()

	end





end


app = App.new
