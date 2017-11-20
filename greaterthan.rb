require 'gosu'
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "number"


class GreaterThan < Gosu::Window
	def initialize()
		super(1600,800,false)
		@cursor = Cursor.new
        @background = Gosu::Image.new("assets/bkgr_space.png",{})
        @amount = rand(0..15)
        @icons = ["assets/sp1.png","assets/uw2.png", "assets/uw3.png", "assets/uw4.png","assets/uw5.png"]        
        @icon1 = Graphic.new(600,590,@icons[rand(0...@icons.length())])
        @icon2 = Graphic.new(1000,590,@icons[rand(0...@icons.length())])
        while @icon1.image == @icon2.image
        	 @icon1 = Graphic.new(600,550,@icons[rand(0...@icons.length())])
        	 @icon2 = Graphic.new(1000,550,@icons[rand(0...@icons.length())])
        end
        @dashes = Array.new
        for i in 0...11
        	@dashes.push(Graphic.new(0 + (i *150),480, "assets/dash1.png"))
        end
        @dashes.push(Graphic.new(780,600, "assets/dash1.png"))
        @buttons = Array.new
        @buttons.push(Button.new(400,700,"assets/1_100_blue.png", "greater","assets/1_100_gold.png"))
        @buttons.push(Button.new(800,700, "assets/2_100_blue.png", "less", "assets/2_100_gold.png"))
        @buttons.push(Button.new(1200,700, "assets/3_100_blue.png", "equal", "assets/3_100_gold.png"))
        @amount1 = rand(1..9)
        @amount2 = rand(1..9)
        @equal = (@amount1 == @amount2)
        @greater = (@amount1 > @amount2 )
        if @greater
        	@answer = "greater"
        elsif @equal
        	@answer = "equal"
        else
        	@answer = "less"
        end
        @icon_locations = Array.new
        @display = Array.new
         while @display.length() < @amount1 
          if @display.length() > 0
             x = rand(0..700)
             y = rand(0..350)
             location = [x,y]
             if !@icon_locations.include?(location) then
                equal = false
                for i in 0...@icon_locations.length()
                  if (@icon_locations[i][0] - x).abs < 120 && (@icon_locations[i][1] - y).abs < 100
                    equal = true
                  end
                end
                if !equal
                  @display.push(Graphic.new(x,y, @icon1.image))
                  @icon_locations.push(location)
                end
             end
          else
             x = rand(0..700)
             y = rand(0..350)
             location = [x,y]
             @icon_locations.push(location)
             @display.push(Graphic.new(x,y,@icon1.image))
          end
        end
        @icon_locations.clear
        while @display.length() < @amount2 + @amount1
          if @display.length() > 0
             x = rand(850..1500)
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
                  @display.push(Graphic.new(x,y, @icon2.image))
                  @icon_locations.push(location)
                end
             end
          else
             x = rand(850..1500)
             y = rand(0..400)
             location = [x,y]
             @icon_locations.push(location)
             @display.push(Graphic.new(x,y,@icon2.image))
          end
        end
        @chosen = Array.new
        @correct = false
    end

    def update
      cursor_movement
      check_input
      refresh
	end

	def draw
		@background.draw(0,0,0)
		@cursor.draw
		draw_button
        display_icon
        @icon1.draw
        @icon2.draw
        draw_dash
        if @chosen.length() ==1
        	@chosen[0].draw
        end
	end
    def check_input
    	if @correct
    		initialize
    	end
    	if !@correct
    		@chosen.clear
    	end
    	for button in @buttons
    		if button.click_on?(@cursor) && @cursor.click && @cursor.reset 
    			@chosen.push(Graphic.new(800,560,button.image))
    			if button.value == @answer
    				@correct = true
    			elsif button.value != @answer
    				@correct = false
    			end
    		end
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
   def draw_button
        for button in @buttons
          button.draw
        end
    end
    def draw_dash
    	for dash in @dashes
    		dash.draw
    	end
    end
    def display_icon
	     for icon in @display
	      icon.draw
	     end
    end
   

end

