require_relative "graphic"
class Shape < Graphic
	def initialize(x,y, image, color, shape)
		super(x,y,image)
		@color = color
		@shape = shape
		@clicked_on = false
		@clicks = 0
		@move = false
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


end