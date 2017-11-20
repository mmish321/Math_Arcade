require "gosu"
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "number"
require_relative "shape"
require_relative "basket"

class Sorting < Gosu::Window

	def initialize()
		 @time = Gosu::milliseconds
		super(1600,800,false)
		@cursor = Cursor.new
		r = rand(1..2)
		if r == 1
			@sort = "color"
		else
			@sort = "shape"
		end
		@background = Gosu::Image.new("assets/forest.png",{})
		@shapes = ["square", "circle", "triangle", "star"]
		@colors = ["red", "gold", "green", "blue"]
		@baskets = Array.new
		@amount1 = rand(1..8)
		@amount2 = rand(1..8)
		@amount3 = rand(1..8)
		@birds = Gosu::Song.new("assets/Spring Birds.wav")
		@birds.play
		if @sort == "shape"
			@shape1 = @shapes[rand(0...@shapes.length)]
			@shape2 = @shapes[rand(0...@shapes.length)]
			@shape3 = @shapes[rand(0...@shapes.length)]
			@color1 = @colors[rand(0...@colors.length)]
			@color2 = @colors[rand(0...@colors.length)]
			@color3 = @colors[rand(0...@colors.length)]
			@icon1 = Shape.new(0,0,"assets/#{@shape1}_#{@color1}.png", @color1, @shape1)
			@icon2 = Shape.new(0,0,"assets/#{@shape2}_#{@color2}.png", @color2, @shape2)
			@icon3 = Shape.new(0,0,"assets/#{@shape3}_#{@color3}.png", @color3, @shape3)
			while (@icon1.shape == @icon2.shape) || (@icon2.shape == @icon3.shape) || (@icon1.shape == @icon3.shape)
				if (@icon1.shape == @icon2.shape)
					if (@icon1.shape == "square")
						@icon2.change_shape("circle")
					elsif (@icon1.shape == "circle")
						@icon2.change_shape("triangle")
					elsif (@icon1.shape == "triangle")
						@icon2.change_shape("star")
					else
						@icon2.change_shape("square")
					end		
				end
				if (@icon2.shape == @icon3.shape)
					if (@icon2.shape == "square")
						@icon3.change_shape("circle")
					elsif (@icon2.shape == "circle")
						@icon3.change_shape("triangle")
					elsif (@icon2.shape == "triangle")
						@icon3.change_shape("star")
					else
						@icon3.change_shape("square")
					end		
				end
				if (@icon1.shape == @icon3.shape)
					if (@icon1.shape == "square")
						@icon3.change_shape("circle")
					elsif (@icon1.shape == "circle")
						@icon3.change_shape("triangle")
					elsif (@icon1.shape == "triangle")
						@icon3.change_shape("star")
					else
						@icon3.change_shape("square")
					end		
				end
			end
			@icon1.change_image("assets/#{@icon1.shape}_#{@color1}.png")
			@icon2.change_image("assets/#{@icon2.shape}_#{@color2}.png")
			@icon3.change_image("assets/#{@icon3.shape}_#{@color3}.png")
			@baskets.push(Basket.new(0,400, "assets/#{@color1}#{@icon1.shape}basket.png", @amount1, @icon1.shape))
			@baskets.push(Basket.new(550,400, "assets/#{@color2}#{@icon2.shape}basket.png", @amount2, @icon2.shape))
			@baskets.push(Basket.new(1100,400, "assets/#{@color3}#{@icon3.shape}basket.png", @amount3, @icon3.shape))
		end
		if @sort == "color"
				@color1 = @colors[rand(0...@colors.length)]
				@color2 = @colors[rand(0...@colors.length)]
				@color3 = @colors[rand(0...@colors.length)]
				@shape1 = @shapes[rand(0...@shapes.length)]
				@shape2 = @shapes[rand(0...@shapes.length)]
				@shape3 = @shapes[rand(0...@shapes.length)]
				@icon1 = Shape.new(0,0,"assets/#{@shape1}_#{@color1}.png", @color1, @shape1)
				@icon2 = Shape.new(0,0,"assets/#{@shape2}_#{@color2}.png", @color2, @shape2)
				@icon3 = Shape.new(0,0,"assets/#{@shape3}_#{@color3}.png", @color3, @shape3)
				while (@icon1.color == @icon2.color) || (@icon2.color == @icon3.color) || (@icon1.color == @icon3.color)
					if (@icon1.color == @icon2.color)
						if (@icon1.color == "red")
							@icon2.change_color("gold")
						elsif (@icon1.color == "gold")
							@icon2.change_color("green")
						elsif (@icon1.color == "green")
							@icon2.change_color("blue")
						else
							@icon2.change_color("red")
						end		
					end
					if (@icon2.color == @icon3.color)
						if (@icon2.color == "red")
							@icon3.change_color("gold")
						elsif (@icon2.color == "gold")
							@icon3.change_color("green")
						elsif (@icon2.color == "green")
							@icon3.change_color("blue")
						else
							@icon3.change_color("red")
						end		
					end
					if (@icon1.color == @icon3.color)
						if (@icon1.color == "red")
							@icon3.change_color("gold")
						elsif (@icon1.color == "gold")
							@icon3.change_color("green")s
						elsif (@icon1.color == "green")
							@icon3.change_color("blue")
						else
							@icon3.change_color("red")
						end		
					end
				end
				@icon1.change_image("assets/#{@shape1}_#{@icon1.color}.png")
				@icon2.change_image("assets/#{@shape2}_#{@icon2.color}.png")
				@icon3.change_image("assets/#{@shape3}_#{@icon3.color}.png")
				@baskets.push(Basket.new(0,400, "assets/#{@icon1.color}basket.png", @amount1, @icon1.color))
				@baskets.push(Basket.new(550,400, "assets/#{@icon2.color}basket.png", @amount2, @icon2.color))
				@baskets.push(Basket.new(1100,400, "assets/#{@icon3.color}basket.png", @amount3, @icon3.color))
		end
		
			@icon_locations = Array.new
	        @display = Array.new
	        while @display.length() < (@amount1 +@amount2+ @amount3)
	          if @display.length() > 0
	             x = rand(0..1500)
	             y = rand(0..400)
	             location = [x,y]
	             if !@icon_locations.include?(location) then
	                equal = false
	                for i in 0...@icon_locations.length()
	                  if (@icon_locations[i][0] - x).abs < 120 && (@icon_locations[i][1] - y).abs < 100
	                    equal = true
	                  end
	                end
	                if !equal
	                	if (@display.length() < @amount1)
	                 	 @display.push(Shape.new(x,y, @icon1.image, @icon1.color, @icon1.shape))
	                 	 @icon_locations.push(location)
	                 	elsif (@display.length() < (@amount1 + @amount2)) && (@display.length > (@amount1 - 1))
	                 		@display.push(Shape.new(x,y, @icon2.image, @icon2.color, @icon2.shape))
	                 	 	@icon_locations.push(location)
	                 	else
	                 		@display.push(Shape.new(x,y, @icon3.image, @icon3.color, @icon3.shape))
	                 	 	@icon_locations.push(location)
	                 	end
	                end
	             end
	          else
	             x = rand(0..1500)
	             y = rand(0..400)
	             location = [x,y]
	             @icon_locations.push(location)
	             @display.push(Shape.new(x,y,@icon1.image, @icon1.color, @icon1.shape))
	          end
	        end
	end

	def update
		cursor_movement
		refresh	
		for shape in @display
			shape.run(@cursor)
		end
		for shape in @display
			if (shape.click_on?(@cursor) && @cursor.click && @cursor.reset)
				shape.increment
				if shape.clicks.odd?
					shape.move(true)
				else
					shape.move(false)
				end
			end
		end
		won?
		check_baskets
	end

	def draw
		@cursor.draw
		@background.draw(0,0,0)
		for shape in @display
			shape.draw
		end
		for basket in @baskets
			basket.draw
		end
	end

	 def cursor_movement
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end

    def refresh
      if  (Gosu::button_down? Gosu::KbEscape)
      	@birds.stop
        close
      end
   end
   def check_baskets
   	  for shape in @display
   	  	for basket in @baskets	
   	  		if basket.on_top_of?(shape) && shape.clicks.even?
   	  			basket.check(shape)
   	  			if (shape.correct)
   	  				@display.delete(shape)
   	  			end
   	  		end
   	  	end
   	  end
   end
   def won?
     if @baskets[1].full? && @baskets[0].full? && @baskets[2]. full?
     	@birds.stop
     	initialize
     end
   end
   

end

