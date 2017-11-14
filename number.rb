require_relative "graphic"
class Number < Graphic
	def initialize(x, y, image, value)
		super(x,y, image)
		@value = value
	end
	def value
		@value
	end

	def change_value(x)
		@value = x
	end
end