require "gosu/all"
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "number"

class Sorting < Gosu::Window

	def initialize()
		super(1600,800,false)
		@cursor = Cursor.new
		@background = Gosu::Image.new("assets/underwater.png",{})
	end














end