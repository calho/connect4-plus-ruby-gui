require 'gtk3'

class App


	def initialize
		Gtk.init
        @builder = Gtk::Builder::new
        @builder.add_from_file("window.glade")
	end





end


app = App.new