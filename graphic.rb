class Graphic
	def initialize(x, y, image)
		@x = x
		@y = y
		@image = Gosu::Image.new(image, {})
	end

	def draw
		@image.draw(@x, @y, 1)
	end
	def x
		@x
	end
	def y
		@y
	end

end