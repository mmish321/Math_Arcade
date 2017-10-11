require_relative "number"
class NumberButton < Number
	def initialize(x,y,image, value)
		super(x,y,image,value)
		@image_x = image
		@clicked_on = false
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
			temp = "assets/#{@value}_100_gold.png"
			@image = Gosu::Image.new(temp,{})
		else
			@image = Gosu::Image.new(@image_x,{})
		end
	end
end