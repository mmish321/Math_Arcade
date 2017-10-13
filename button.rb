require_relative "number"
class Button < Number
	def initialize(x,y,image, value, click_image)
		super(x,y,image,value)
		@image_x = image
		@clicked_on = false
		@click = click_image
	end
	def click_on?(cursor)
		if Gosu::distance(@x, @y, cursor.x, cursor.y) < 50 then
			@clicked_on = true
		else
			@clicked_on = false
		end
		clicked_on
		return @clicked_on
	end
	def clicked_on
		if (@clicked_on)
			@image = Gosu::Image.new(@click,{})
		else
			@image = Gosu::Image.new(@image_x,{})
		end
	end
	def image
		@image_x
	end
end