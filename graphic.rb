class Graphic
	def initialize(x, y, image)
		@x = x
		@y = y
		@image = Gosu::Image.new(image, {})
		@image_string = image
	end

	def draw
		@image.draw(@x, @y, 1)
		@drawn = true
	end
	def drawn
		@drawn
	end
	def x
		@x
	end
	def y
		@y
	end
	def image
		@image_string
	end

end
