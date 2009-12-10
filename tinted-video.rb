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
    tint 150, mouse_y, 150
    image @video, 0, 0, 320, 240
    
    # Small
    tint mouse_y, 150, 150
    image @video, 0, 180, 160, 120
    
    tint 150, 150, mouse_y
    image @video, 160, 180, 160, 120
  end
end
 
CaptureVideoSketch.new :title => "Tinted Video", :width => 320, :height => 300
