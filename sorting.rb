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
		@test = Shape.new(400,400,"assets/uw1.png","blue", "circle")
		@test2 = Shape.new(700,500,"assets/uw2.png", "red", "square")
	end

	def update
		cursor_movement
		refresh
		@test.run(@cursor)
		@test2.run(@cursor)
		if (@test.click_on?(@cursor)) && @cursor.click && @cursor.reset 
			@test.increment
			if @test.clicks.odd?
				@test.move(true)
			else
				@test.move(false)
			end
		end
		if (@test2.click_on?(@cursor)) && @cursor.click && @cursor.reset 
			@test2.increment
			if @test2.clicks.odd?
				@test2.move(true)
			else
				@test2.move(false)
			end
		end
	end

	def draw
		@cursor.draw
		@background.draw(0,0,0)
		@test2.draw
		@test.draw
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