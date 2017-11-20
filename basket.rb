require_relative "graphic"
class Basket < Graphic

	def initialize(x,y,image,amount, type)
		super(x,y,image)
		@amount = amount
		@type =type
		@on_top_of = false
		@shape_amount = 0
	end

	def on_top_of?(shape)
		if (shape.x >= @x && shape.x <= (@x + 500)) && (shape.y >= 400)
			return true
		else
			return false
		end
	end

	def check(shape)
		if @type == "blue" || @type =="red" || @type == "green" || @type == "gold"
			if shape.color == @type
				@shape_amount += 1
				shape.correct_change(true)
			else
				shape.orginal
			end
		elsif  @type == "square" || @type == "circle" || @type == "star" || @type == "triangle"
			if shape.shape == @type
				@shape_amount += 1
				shape.correct_change(true)
			else
				shape.orginal
			end
		end
	end

	def full?
		if @shape_amount == @amount
			return true
		else
			return false
		end
	end
end