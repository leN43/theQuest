require 'ruby2d'
require './flame'
require './enemy'
require './hero'

# Set the window size
set width: 800, height: 450, title: 'QUEST'
walk_speed = 3
music = Music.new("bgMusicTavern.ogg", loop: true)
music.play
fond = Image.new('citySky.png')
sound = Sound.new("walkNoise.ogg")
hero = Hero.new
enemy = Enemy.new
@flame = nil  # Initialize @flame as nil initially
$can_fire = true  # Flag to control firing
Text.new(
  'THE QUEST',
  x: 120, y: 20,
  style: 'bold',
  size: 90,
  color: 'orange',
  z: 10
)

# Define a method to create a new flame and update @flame
def create_flame(hero)
  if $can_fire  # Check the global $can_fire variable
    @flame = Flame.new(
      hero.draw.x + (hero.direction == :left ? -Flame::WIDTH : 128),
      hero.draw.y + 64,
      hero.direction
    )
    $can_fire = false  # Disable firing until this flame leaves the screen
  end
end
on :key_held do |event|
  case event.key
  when 'left'
    hero.move_left
    if hero.draw.x > 0
      hero.draw.x -= walk_speed
    end
  when 'right'
    hero.move_right
    if hero.draw.x < (Window.width - 128)
      hero.draw.x += walk_speed
    end
  when 'up'
    if hero.draw.y > 0
      hero.draw.y -= walk_speed
    end
  when 'down'
    if hero.draw.y < (Window.height - 128)
      hero.draw.y += walk_speed
    end
  end
end

on :key_down do |event|
  case event.key
  when 'space'
    if $can_fire
      # Create a new flame (fireball) instance at the hero's position and update @flame
      create_flame(hero)
    end
  end
end

# Add an update block to move the flame and re-enable firing when it leaves the screen
update do
  if enemy.destroyed?
    # Display a victory message (optional)
    puts "You defeated the enemy! Victory!"

    # Close the game window
    close
  else
  if @flame
    @flame.move
    if @flame.offscreen?
      @flame = nil
      $can_fire = true  # Enable firing again
    end

    # Check for collision between flame and enemy
    if @flame && !enemy.destroyed? && @flame.intersect?(enemy.draw)
      enemy.decrease_health(10)
      # Handle the collision here
    end
  end
  # Update the health bar based on hero's health
  hero.health_bar.width = (hero.health / 100.0) * 200  # Adjust width based on health
  if hero.health > 50
    hero.health_bar.color = 'green'
  else
    hero.health_bar.color = 'red'
  end
  enemy.move_randomly
end
end

# Show the window
show
