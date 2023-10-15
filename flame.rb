class Flame
    WIDTH = 125
    HEIGHT = 40
    SPEED = 5  # Adjust the speed as needed
  
    def initialize(x, y, direction)
      Sound.new('assets\sounds\flameNoise.ogg').play
      @image = Sprite.new(
        'assets\images\fire.png',
        x: x,
        y: y,
        width: WIDTH,
        height: HEIGHT,
      )
      @x_velocity = direction == :left ? -SPEED : SPEED
    end
  
    def move
      @image.x += @x_velocity
    end

    def intersect?(object)
        # Calculate the collision manually based on object positions and dimensions
        flame_x1 = @image.x
        flame_x2 = @image.x + @image.width
        flame_y1 = @image.y
        flame_y2 = @image.y + @image.height
    
        enemy_x1 = object.x
        enemy_x2 = object.x + object.width
        enemy_y1 = object.y
        enemy_y2 = object.y + object.height
    
        # Check for collision
        if flame_x1 < enemy_x2 && flame_x2 > enemy_x1 && flame_y1 < enemy_y2 && flame_y2 > enemy_y1
          return true
        else
          return false
        end
      end
  
    def offscreen?
      @image.x > Window.width || @image.x < -WIDTH
    end
  
    def check_collision(enemies)
        enemies.each do |enemy|
          if @image.intersect?(enemy.sprite) && !enemy.destroyed?
            enemy.decrease_health(10)  # Adjust the amount as needed
            @image.remove
          end
        end
    end
      
  end
  