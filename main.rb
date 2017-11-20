require "gosu"
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "sorting"
require_relative "counting"
require_relative "greaterthan"
require_relative "addition"
require_relative "subtraction"

class MathArcade < Gosu::Window

	def initialize()
		super(1600,800,false)
		@background = Gosu::Image.new("assets/arcadebackground.png",{})
		self.caption = "Math Arcade"
		@cursor = Cursor.new
		@games = Array.new
		@games.push(Button.new(600,0,"assets/counting.png","Counting", "assets/counting.png"))
		@games.push(Button.new(950,0, "assets/greaterthan.png", "GreaterThan", "assets/greaterthan.png"))
		@games.push(Button.new(1300,0, "assets/sorting.png", "Sorting", "assets/sorting.png"))
		@games.push(Button.new(700,290, "assets/addition.png", "Addition", "assets/addition.png"))
		@games.push(Button.new(1100,270, "assets/subtraction.png", "Subtraction", "assets/subtraction.png"))
		@font = Gosu::Font.new(25)
	end


	def update
		cursor_movement
		refresh
		check_input
	end


	def draw
		@cursor.draw
		@background.draw(0,0,0)
		for game in @games
			game.draw
		end
		draw_font
	end

	def cursor_movement
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end

    def refresh
      if  (Gosu::button_down? Gosu::KbReturn) || (Gosu::button_down? Gosu::KbEscape)
        	close!
      end
   end

   def draw_font
   	@font.draw("Counting",650,200,1,1,1,0xff_3B5998)
   	@font.draw("Greater Than?",985,200,1,1,1,0xff_808080)
   	@font.draw("Sorting!",1370,200,1,1,1,0xff_27d645)
   	@font.draw("Addition", 750, 490, 1,1,1,0xff_FFA500)
   	@font.draw("Subtraction", 1140, 470, 1,1,1,0xff_0aeee8)
   end

   def check_input
	   	for game in @games
	   		if game.x <= @cursor.x && (game.x + 200) >= @cursor.x && game.y <= @cursor.y && (game.y + 200) >= @cursor.y && @cursor.click && @cursor.reset
	   			if game.value == "Counting"
	   				choice = CountingGame.new
	   				choice.show
	   				self.close!
	   				initialize
	   				self.show
	   			elsif game.value == "GreaterThan"
	   				choice = GreaterThan.new
	   				choice.show
	   				self.close!
	   				initialize
	   				self.show
	   			elsif game.value == "Sorting"
	   				choice = Sorting.new
	   				choice.show
	   				self.close!
	   				initialize
	   				self.show
	   			elsif game.value == "Addition"
	   				choice = Addition.new
	   				choice.show
	   				self.close!
	   				initialize
	   				self.show
	   			else
	   				choice = Subtraction.new
	   				choice.show
	   				self.close!
	   				initialize
	   				self.show
	   			end
	   		end
	   end
	end

end

meep = MathArcade.new
meep.show