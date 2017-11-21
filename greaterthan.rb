require 'gosu'
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "number"


class GreaterThan < Gosu::Window
	def initialize()
		super(1600,800,false)
        @time = Gosu::milliseconds
		    @cursor = Cursor.new("assets/white_cursor.png", "assets/cursor_click.png")
        @background = Gosu::Image.new("assets/bkgr_space.png",{})
        @icons = ["assets/space1.png","assets/space2.png", "assets/space3.png", "assets/space4.png","assets/space5.png"]        
        @icon1 = Graphic.new(600,590,@icons[rand(0...@icons.length())])
        @icon2 = Graphic.new(1000,590,@icons[rand(0...@icons.length())])
        while @icon1.image == @icon2.image
        	 @icon1 = Graphic.new(600,550,@icons[rand(0...@icons.length())])
        	 @icon2 = Graphic.new(1000,550,@icons[rand(0...@icons.length())])
        end
        @dashes = Array.new
        for i in 0...16
        	@dashes.push(Graphic.new(0 + (i *100),480, "assets/white_dash.png"))
        end
        @dashes.push(Graphic.new(780,600, "assets/dash1.png"))
        @buttons = Array.new
        @buttons.push(Button.new(400,680,"assets/greater_than_button.png", "greater","assets/graterthan.png"))
        @buttons.push(Button.new(1200,680, "assets/less_than_button.png", "less", "assets/lessthan.png"))
        @buttons.push(Button.new(800,680, "assets/equal_button.png", "equal", "assets/equal_sign.png"))
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
        @space = Gosu::Song.new("assets/outerspace.wav")
        @space.play(looping = true)
        @star = Gosu::Sample.new("assets/shooting_star.ogg")
        @star_dust = Gosu::Sample.new("assets/star_dust.wav")
        @swoosh = Gosu::Sample.new("assets/swoosh.wav")
    end

    def update
      sound_effects
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
    		reset
    	end
    	if !@correct
    		@chosen.clear
    	end
    	for button in @buttons
    		if button.click_on?(@cursor) && @cursor.click && @cursor.reset 
    			@chosen.push(Graphic.new(800,590,button.click_image))
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
    def sound_effects
      if ((Gosu::milliseconds - @time) % 5000 <= self.update_interval)
        r = rand(1..3)
        if r ==1
          @swoosh.play
        elsif r ==2
          @star_dust.play
        else
          @star.play
        end
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
    def close
      @space.stop
      close!
    end
    def reset     
        @icon1 = Graphic.new(600,590,@icons[rand(0...@icons.length())])
        @icon2 = Graphic.new(1000,590,@icons[rand(0...@icons.length())])
        while @icon1.image == @icon2.image
           @icon1 = Graphic.new(600,550,@icons[rand(0...@icons.length())])
           @icon2 = Graphic.new(1000,550,@icons[rand(0...@icons.length())])
        end
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
        @icon_locations.clear
        @display.clear
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
        @chosen.clear
        @correct = false
    end
end

