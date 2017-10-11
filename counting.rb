require 'gosu/all'
require_relative "cursor"
require_relative "graphic"
require_relative "numberbutton"
require_relative "number"


class CountingGame < Gosu::Window

	def initialize()
		super(1600,800, false)
        @correct = false
        @cursor = Cursor.new
        @background = Gosu::Image.new("assets/clouds.jpg",{})
        @amount = rand(0..15)
        @icons = Array.new 
        #@icon = @icons[rand(0...@icons.length())]
        @display = Array.new
        @icon_locations = Array.new
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
                  @display.push(Graphic.new(x,y, "assets/star100.png"))
                  @icon_locations.push(location)
                end
             end
          else
             x = rand(0..1500)
             y = rand(0..400)
             location = [x,y]
             @icon_locations.push(location)
             @display.push(Graphic.new(x,y,"assets/star100.png"))
          end
        end
        @buttons = Array.new
        for i in 0...16
	        if i <=7
	          @buttons.push(NumberButton.new(50+(i* 200), 525, "assets/#{i}_100_blue.png", i))
	        else
	          @buttons.push(NumberButton.new(50+((i-8)*200), 675, "assets/#{i}_100_blue.png", i))
	        end
        end
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
	end
    
    def cursor_movement
      @cursor.change_x(mouse_x)
      @cursor.change_y(mouse_y)
    end
    def check_input
      for button in @buttons
          if button.click_on?(@cursor) && @cursor.click && @cursor.reset && (button.value == @amount)
            @buttons.clear
            @display.clear
            @correct = true
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
      if  @correct &&(Gosu::button_down? Gosu::KbReturn)
        initialize
      end
      if  (Gosu::button_down? Gosu::KbEscape)
        close
      end
   end
end

meep = CountingGame.new
meep.show