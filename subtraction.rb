require 'gosu'
require_relative "cursor"
require_relative "button"
require_relative "number"
require_relative "graphic"

class Subtraction < Gosu::Window
	def initialize()
		super(1600,800,false)
		@cursor = Cursor.new
		@background = Gosu::Image.new("assets/subtractionbackground.png", {})
		@mascot = Graphic.new(0,0,"assets/subtraction_mascot.png")
		@basket = Graphic.new(400,0,"assets/icebasketempty.png")
		@buttons = Array.new
		@subtraction_sign = Graphic.new(1000,140,"assets/subtraction_sign.png")
		@dash = Graphic.new(1400,180,"assets/dash1.png")
		@equal_sign = Graphic.new(1275,140,"assets/equal_sign.png")
		@used_problems = Array.new
		r = rand(1..15)
		s = rand(0..r)	
		@problem = [Number.new(850,140,"assets/#{r}_blue_plain.png",r),  Number.new(1125,140,"assets/#{s}_blue_plain.png",s), Number.new(1425,140, "assets/#{r-s}_blue_plain.png",(r-s))]
		@used_problems.push(@problem)
		@correct = 0
		@needed = [1,2,3,4,5,6]
		@needed_amount = @needed[0]
		@bubbles = Gosu::Sample.new("assets/bubbles.wav")
		@draw_answer = false
		@time = Gosu::milliseconds
		for i in 0...16
        if i <=7
          @buttons.push(Button.new(435+(i* 150), 525, "assets/#{i}_100_blue.png", i, "assets/#{i}_100_gold.png"))
        else
          @buttons.push(Button.new(435+((i-8)*150), 675, "assets/#{i}_100_blue.png", i,"assets/#{i}_100_gold.png"))
        end
      end
      @draw_problem = true
	end

	def update
		cursor_movement
		check_progress
		check_input
		refresh
	end

	def draw
		@cursor.draw
		@background.draw(0,0,0)
		@mascot.draw
		@basket.draw
		draw_button
		if @draw_problem
			@subtraction_sign.draw
			@dash.draw
			@equal_sign.draw
			@problem[0].draw
			@problem[1].draw
		end
		if @draw_answer && @draw_problem
			@problem[2].draw
			if ((Gosu::milliseconds - @time) % 1000 <= self.update_interval)
				generate_problem	
			end	
		end
	end

	def cursor_movement
      @cursor.click
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end
    def draw_button
        for button in @buttons
          button.draw
        end
    end
   def check_progress
    	if @correct == @needed_amount
    		if @needed_amount == 6
    			@draw_problem = false
    			@basket.change_image("assets/icebasket6.png")
    			@buttons.clear
    			@problem.clear
    			@mascot.change_image("assets/subtraction_mascot_happy.png")
    		else
    			@basket.change_image("assets/icebasket#{@correct}.png")
    			@needed_amount = @needed[@correct]
    			@correct = 0
    		end
    	end
    end
    def check_input
    	for button in @buttons
    		if button.click_on?(@cursor) && @cursor.click && @cursor.reset
    			if (button.value == @problem[2].value)
    				@draw_answer = true
    				@correct +=1
	    		else
	    			@correct = 0 
	    		end
	    	end
	    end
    end
    def generate_problem
    	r = rand(1..15)
		s = rand(0..r)
		numbers = [r,s]
		if !@used_problems.include?(numbers) 
			@problem[0].change_value(r)
			@problem[1].change_value(s)
			@problem[2].change_value((r-s))
			@problem[0].change_image("assets/#{r}_blue_plain.png")
			@problem[1].change_image("assets/#{s}_blue_plain.png")
			@problem[2].change_image("assets/#{r-s}_blue_plain.png")
			@used_problems.push(numbers)
		else
			generate_problem
		end
		@draw_answer = false
    end

    def refresh
      if  (Gosu::button_down? Gosu::KbEscape)
        self.close!
      end
   end

end

meep =  Subtraction.new
meep.show