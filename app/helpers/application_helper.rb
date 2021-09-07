module ApplicationHelper
  
  def file_type(filename)
       types = {
         :jpeg => "image",
         :jpg => "image",
         :gif => "image",
         :png => "image",
         :mp4 => "video", 
         :mkv => "video",
         :MOV => "video"
       }
       types[filename.split(".").last.to_sym]
  end
    
end
