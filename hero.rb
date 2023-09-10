class Hero
    attr_accessor :health, :direction ,:health_bar
    def initialize
      @health = 100
      @direction = :right
      @sprite = Sprite.new(
        'hero.png',
        width: 128,
        height: 128,
        clip_width: 128,
        y: 150
      )
      @health_bar = Rectangle.new(
        x: 0,
        y: 10,
        width: 200,  # Width of the health bar
        height: 20,  # Height of the health bar
        color: 'green'  # Initial color of the health bar
      )
    end
  
    def draw
        if @direction == :left
          @sprite.clip_x = 128 # Flip the sprite horizontally when going left
        else
          @sprite.clip_x = 0 # Reset clip_x to 0 when going right (no flip)
        end
        @sprite
      end
  
    def decrease_health(amount)
      @health -= amount
    end
  
    def toggle_direction
      @direction = (@direction == :right) ? :left : :right
    end
  
    def move_left
      @direction = :left
    end
  
    def move_right
      @direction = :right
    end
  end