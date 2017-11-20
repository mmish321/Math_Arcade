class Cursor
	def initialize(image, click_image)
		@image = Gosu::Image.new(image, {})
        @image_string = image
        @click_image_string = click_image
		@x = 0
		@y = 0
		@clickimage = Gosu::Image.new(click_image, {})
        @switch = 1
        @click = Gosu::Sample.new("assets/mouse_click.wav")
	end
    
    def change_x(num)
      @x = num
    end
    def click
        if (Gosu::button_down? Gosu::MsLeft) then
    	   @image = Gosu::Image.new(@click_image_string,{})
             @switch = 2
        else
            if (@switch == 2) then
                @switch = 3
                @click.play
            end
            @image = Gosu::Image.new(@image_string, {})       
        end
        if @switch == 3
        	return true
        else
        	return false
        end
    end
    def reset
        @switch = 1
    end
    
    def change_y(num)
    	@y = num
    end
    def draw
    	@image.draw(@x,@y,2)
    end
    def x
    	@x
    end
    def y
    	@y
    end
end 
