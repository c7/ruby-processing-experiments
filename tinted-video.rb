require 'ruby-processing'
 
class CaptureVideoSketch < Processing::App
  load_library "video"
  import "processing.video"
 
  def setup
    @video = Capture.new(self, width, height, 24)
  end
 
  def draw
    @video.read if @video.available
    
    # Medium
    tint 100, mouse_y, 100
    image @video, 0, 0, 320, 240
    
    # Small
    tint mouse_y, 100, 100
    image @video, 0, 240, 160, 120
    
    tint 100, 100, mouse_y
    image @video, 160, 240, 160, 120
    
    tint 100, mouse_x, mouse_y
    image @video, 0, 360, 320, 240
  end
end
 
CaptureVideoSketch.new :title => "Tinted Video", :width => 320, :height => 600
