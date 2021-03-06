require 'gosu'
require_relative "cursor"
require_relative "graphic"
require_relative "button"
require_relative "number"


class CountingGame < Gosu::Window

	def initialize()
		super(1600,800, false)
        @correct = false
        @cursor = Cursor.new("assets/cursor.png", "assets/cursor_click.png")
        @background = Gosu::Image.new("assets/underwater.png",{})
        @amount = rand(0..15)
        @icons = ["assets/uw1.png","assets/uw2.png", "assets/uw3.png", "assets/uw4.png","assets/uw5.png"]
        @icon = @icons[rand(0...@icons.length())]
        @display = Array.new
        @icon_locations = Array.new
        @bubbles = Gosu::Sample.new("assets/bubbles.wav")
        @splash = Gosu::Sample.new("assets/splash.wav")
        @blub = Gosu::Sample.new("assets/blub.wav")
        @waves = Gosu::Song.new("assets/underwater.wav")
        @waves.play(looping = true)
        @time = Gosu::milliseconds
        while @display.length() < @amount 
          if @display.length() > 0
             x = rand(100..1500)
             y = rand(0..400)
             location = [x,y]
             if !@icon_locations.include?(location) then
                equal = false
                for i in 0...@icon_locations.length()
                  if (@icon_locations[i][0] - x).abs < 100 && (@icon_locations[i][1] - y).abs < 100
                    equal = true
                  end
                end
                if !equal
                  @display.push(Graphic.new(x,y, @icon))
                  @icon_locations.push(location)
                end
             end
          else
             x = rand(0..1500)
             y = rand(0..400)
             location = [x,y]
             @icon_locations.push(location)
             @display.push(Graphic.new(x,y,@icon))
          end
        end
        @buttons = Array.new
        for i in 0...16
	        if i <=7
	          @buttons.push(Button.new(50+(i* 200), 525, "assets/#{i}_100_blue.png", i, "assets/#{i}_100_gold.png"))
	        else
	          @buttons.push(Button.new(50+((i-8)*200), 675, "assets/#{i}_100_blue.png", i, "assets/#{i}_100_gold.png"))
	        end
        end
	end

	def update
      cursor_movement
      check_input
      refresh
      sound_effects
	end

	def draw
		@background.draw(0,0,0)
		@cursor.draw
		draw_button
    display_icon
	end
    
    def sound_effects
      if ((Gosu::milliseconds - @time) % 5000 <= self.update_interval)
        r = rand(1..2)
        if r ==1
          @bubbles.play
        else 
          @splash.play
        end
      end
      if ((Gosu::milliseconds - @time) % 8000 <= self.update_interval)
        @blub.play
      end
    end


    
    def cursor_movement
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end
    def check_input
      for button in @buttons
          if button.click_on?(@cursor) && @cursor.click && @cursor.reset && (button.value == @amount)
            @correct = true
            reset
          end
      end
    end

    def draw_button
        for button in @buttons
          button.draw
        end
    end
    def display_icon
     for icon in @display
      icon.draw
     end
    end
    def refresh
      if  (Gosu::button_down? Gosu::KbEscape)
        close
      end
   end
   def reset
    @icon = @icons[rand(0...@icons.length())]
    @amount = rand(0..15)
    @display.clear
    @icon_locations.clear
    while @display.length() < @amount 
          if @display.length() > 0
             x = rand(100..1500)
             y = rand(0..400)
             location = [x,y]
             if !@icon_locations.include?(location) then
                equal = false
                for i in 0...@icon_locations.length()
                  if (@icon_locations[i][0] - x).abs < 100 && (@icon_locations[i][1] - y).abs < 100
                    equal = true
                  end
                end
                if !equal
                  @display.push(Graphic.new(x,y, @icon))
                  @icon_locations.push(location)
                end
             end
          else
             x = rand(0..1500)
             y = rand(0..400)
             location = [x,y]
             @icon_locations.push(location)
             @display.push(Graphic.new(x,y,@icon))
          end
        end
   end
   def close
    @waves.stop
      close!
    end
end

