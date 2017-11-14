class Graphic
	def initialize(x, y, image)
		@x = x
		@y = y
		@image = Gosu::Image.new(image, {})
		@image_string = image
	end

	def draw
		@drawn = true
		@image.draw(@x, @y, 1)
	end
	def drawn
		@drawn
	end
	def reset
		@drawn = false
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
	def change_image(image)
		@image = Gosu::Image.new(image, {})
		@image_string = image
	end

end
