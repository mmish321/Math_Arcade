class Cursor
	def initialize
		@image = Gosu::Image.new('assets/cursor.png', {})
		@x = 0
		@y = 0
		@clickimage = Gosu::Image.new('assets/cursor_click.png', {})
        @switch = 1
	end
    
    def change_x(num)
      @x = num
    end
    def click
        if (Gosu::button_down? Gosu::MsLeft) then
    	   @image = Gosu::Image.new('assets/cursor_click.png',{})
             @switch = 2
        else
            if (@switch == 2) then
                @switch = 3
            end
            @image = Gosu::Image.new('assets/cursor.png', {})           
        end
        if @switch == 3 then
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
