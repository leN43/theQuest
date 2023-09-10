class Enemy
    attr_accessor :health, :health_bar, :direction, :sprite
  
    def initialize
      @health = 100
      @movement_speed = 10
      @direction = :left
      @sprite = Sprite.new(
        'dragon.png',
        width: 300,
        height: 300,
        y: 100,
        x: 600
      )
      @health_bar = Rectangle.new(
        x: 600,
        y: 10,
        width: 200,
        height: 20,
        color: 'green'
      )
    end
  
    def decrease_health(amount)
      @health -= amount
      @health = 0 if @health < 0
      update_health_bar
    end
  
    def draw
      if @direction == :left
        @sprite.clip_x = 288
      else
        @sprite.clip_x = 0
      end
      @sprite
    end
  
    def update_health_bar
      @health_bar.width = (@health / 100.0) * 200
      if @health > 50
        @health_bar.color = 'green'
      else
        @health_bar.color = 'red'
      end
      @health_bar.x = @sprite.x
      @health_bar.y = @sprite.y - 20
    end
    
    def destroyed?
        # Define the logic to determine if the enemy is destroyed
        # For example, return true if health is <= 0, or based on your game's criteria
        @health <= 0
      end

    def move(walk_speed)
      if @direction == :left
        @sprite.x += walk_speed
      else
        @sprite.x -= walk_speed
      end
      update_health_bar
    end
    def move_randomly
        # Generate a random number to determine the movement direction
        random_direction = rand(4)  # 0: up, 1: down, 2: left, 3: right
    
        case random_direction
        when 0
          # Move up
          @sprite.y -= @movement_speed
        when 1
          # Move down
          @sprite.y += @movement_speed
        when 2
          # Move left
          @sprite.x -= @movement_speed
        when 3
          # Move right
          @sprite.x += @movement_speed
        end
    
        # Ensure the enemy stays within the game window bounds
        constrain_to_window_bounds
      end
    
      def constrain_to_window_bounds
        # Adjust the enemy's position to stay within the window bounds
        @sprite.x = [@sprite.x, 0].max
        @sprite.x = [@sprite.x, Window.width - @sprite.width].min
        @sprite.y = [@sprite.y, 0].max
        @sprite.y = [@sprite.y, Window.height - @sprite.height].min
      end
  end
  