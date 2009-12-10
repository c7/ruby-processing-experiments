# Load the Java OpenGL library
load_java_library "opengl"
include_package "processing.opengl"  

# Load the Control Panel
load_library "control_panel"

# Setup of the application  
def setup
  size 500, 756, OPENGL
  no_stroke
  color_mode RGB, 1
  fill 0.3
  frame_rate 24
  background 0
  
  control_panel do |c|
    c.slider :opacity,        0.01..1.0,   0.3
    c.slider :rotation_x,     0.01..1.0,   0.2
    c.slider :rotation_y,     0.01..1.0,   0.3
    c.slider :growth_factor,  0.01..2.0,   1.0
    
    c.checkbox :paused
    c.checkbox :trails
  end
  
  @boxes = [
    {:y => 4,  :speed => 1,  :size => 68, :opacity => 1.0},
    {:y => 1,  :speed => 15,  :size => 60, :opacity => 1.8},
    {:y => 3,  :speed => 4,  :size => 32, :opacity => 1.2},
    {:y => 41, :speed => 23,  :size => 40, :opacity => 1.2},                                                       
    {:y => 1,  :speed => 6,  :size => 47, :opacity => 1.5},
    {:y => 1,  :speed => 2,  :size => 30, :opacity => 1.5},
    {:y => 5,  :speed => 16, :size => 14, :opacity => 2.0},
    {:y => 1,  :speed => 17,  :size => 42, :opacity => 1.0},
    {:y => 4,  :speed => 25,  :size => 90, :opacity => 1.2},                                                       
    {:y => 6,  :speed => 1, :size => 23, :opacity => 1.0},
    {:y => 42, :speed => 15,  :size => 20, :opacity => 1.0},
    {:y => 1,  :speed => 10,  :size => 38, :opacity => 1.5},
    {:y => 11, :speed => 5, :size => 20, :opacity => 2.0},
    {:y => 24, :speed => 26,  :size => 33, :opacity => 1.0},
    {:y => 1,  :speed => 8, :size => 24, :opacity => 2.0},
    {:y => 24, :speed => 13,  :size => 20, :opacity => 1.5},
    {:y => 38, :speed => 27, :size => 31, :opacity => 1.8},
    {:y => 11, :speed => 14, :size => 12, :opacity => 1.0},
    {:y => 1,  :speed => 29, :size => 85, :opacity => 1.2},
    {:y => 21, :speed => 11,  :size => 50, :opacity => 1.2},
    {:y => 1,  :speed => 18,  :size => 33, :opacity => 1.3},
    {:y => 5,  :speed => 8, :size => 18, :opacity => 2.3},
    {:y => 17, :speed => 26, :size => 64, :opacity => 1.0},
    {:y => 3,  :speed => 7,  :size => 45, :opacity => 1.0},
    {:y => 65, :speed => 13,  :size => 99, :opacity => 1.2},
    {:y => 8,  :speed => 2,  :size => 83, :opacity => 1.2},                                                       
    {:y => 12, :speed => 20, :size => 47, :opacity => 1.6},
    {:y => 11, :speed => 3, :size => 32, :opacity => 1.3},
    {:y => 1,  :speed => 15, :size => 47, :opacity => 0.9},
    {:y => 7,  :speed => 19,  :size => 60, :opacity => 1.8},
  ]

  @column_width = (width/@boxes.size)
end

def draw
  unless @paused    
    background 0 unless @trails
    
    light_specular      0.5, 1, 0.5
    directional_light   0.9, 0.9, 0.9, 0, 0, -1
    
    @boxes.each_with_index do |b, i|
      # Start drawing each box by pushing the matrix
      push_matrix
      
      # Calculate new speed
      b[:speed] = b[:speed] * -1 if b[:y] >= height || b[:y] <= 0
      b[:y] = b[:y] + b[:speed]
      
      # Translate the position
      translate   (b[:size]/2)+(i)*@column_width, b[:y]
      rotate_x    (PI/@rotation_x)
      rotate_y    (PI/@rotation_y)
      
      # Color
      specular  0.2
      fill 0, 150, 0, b[:opacity]*@opacity
      
      # Draw the actual box
      box b[:size]*@growth_factor
      
      # End by popping the matrix
      pop_matrix
    end
  end
end