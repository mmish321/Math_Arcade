require_relative "graphic"
class Shape < Graphic
	def initialize(x,y, image, color, shape)
		super(x,y,image)
		@color = color
		@shape = shape
		@clicked_on = false
		@clicks = 0
		@move = false
		@original_x = x
		@original_y = y
		@correct = false
	end

	def color
		@color
	end

	def shape
		@shape
	end
	def click_on?(cursor)
		if Gosu::distance(@x, @y, cursor.x, cursor.y) < 50 then
			@clicked_on = true
		else
			@clicked_on = false
		end
		return @clicked_on
	end
	def change_x(num)
		@x = num
	end
	def change_y(num)
		@y = num
	end
	def clicks
		@clicks
	end
	def increment
		@clicks +=1
	end
	def run(cursor)
		if @move == true
			@x = cursor.x
			@y = cursor.y
		end
	end
	def move(value)
		@move = value
	end
	def move?
		@move
	end
 	def change_color(color)
 		@color = color
 	end
 	def change_shape(shape)
 		@shape = shape
 	end
 	def orginal
 		@x = @original_x
 		@y = @original_y
 	end
 	def correct_change(value)
 		@correct = value
 	end
 	def correct
 		@correct
 	end

end