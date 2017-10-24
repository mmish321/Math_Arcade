require "gosu/all"
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "number"
require_relative "shape"

class Sorting < Gosu::Window

	def initialize()
		super(1600,800,false)
		@cursor = Cursor.new
		@background = Gosu::Image.new("assets/underwater.png",{})
		@shapes = ["uw1", "uw2", "uw3", "uw4"]
		@colors = ["red", "purple", "green", "blue"]
		@shape1 = @shapes[rand(0...@shapes.length)]
		@shape2 = @shapes[rand(0...@shapes.length)]
		@shape3 = @shapes[rand(0...@shapes.length)]
		@color1 = @colors[rand(0...@colors.length)]
		@color2 = @colors[rand(0...@colors.length)]
		@color3 = @colors[rand(0...@colors.length)]
		@icon1 = Shape.new(0,0,"assets/#{@shape1}.png", @color1, @shape1)
		@icon2 = Shape.new(0,0,"assets/#{@shape2}.png", @color2, @shape2)
		@icon3 = Shape.new(0,0,"assets/#{@shape3}.png", @color3, @shape3)
		while (@icon1.equal_to(@icon2)) || (@icon2.equal_to(@icon3)) || @icon1.equal_to(@icon3)
			@shape1 = @shapes[rand(0...@shapes.length)]
			@shape2 = @shapes[rand(0...@shapes.length)]
			@shape3 = @shapes[rand(0...@shapes.length)]
			@color1 = @colors[rand(0...@colors.length)]
			@color2 = @colors[rand(0...@colors.length)]
			@color3 = @colors[rand(0...@colors.length)]
		end
		@amount1 = rand(1..8)
		@amount2 = rand(1..8)
		@amount3 = rand(1..8)
		@icon_locations = Array.new
        @display = Array.new
        while @display.length() < @amount1 
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
                  @display.push(Shape.new(x,y, @icon1.image, @color1, @shape1))
                  @icon_locations.push(location)
                end
             end
          else
             x = rand(0..1500)
             y = rand(0..400)
             location = [x,y]
             @icon_locations.push(location)
             @display.push(Shape.new(x,y,@icon1.image, @color1, @shape1))
          end
        end
        while @display.length() < @amount1 + @amount2
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
                  @display.push(Shape.new(x,y, @icon2.image, @color2, @shape2))
                  @icon_locations.push(location)
               end
            end
        end
         while @display.length() < @amount2 + @amount1 + @amount3
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
                  @display.push(Shape.new(x,y, @icon3.image, @color3, @shape3))
                  @icon_locations.push(location)
                end
             end
        end
	end

	def update
		cursor_movement
		refresh
		#@test.run(@cursor)
		#@test2.run(@cursor)
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
	end

	def draw
		@cursor.draw
		@background.draw(0,0,0)
		for shape in @display
			shape.draw
		end
	end

	 def cursor_movement
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end

    def refresh
      if  (Gosu::button_down? Gosu::KbEscape)
        close
      end
   end
end

meep = Sorting.new
meep.show