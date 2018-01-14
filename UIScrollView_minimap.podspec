Pod::Spec.new do |s|

  s.name         = "UIScrollView_minimap"
  s.version      = "0.1.2"
  s.summary      = "create minimap by UIScrollView"
  s.description  =  "UIScrollView_minimap is a awesome module that shows the part of image in the scroll view as a form of minimap"

  s.homepage     = "https://github.com/TileImageTeamiOS/UIScrollView_minimap"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author             = { "Hong Seong Ho" => "grohong76@gmail.com",  'Changnam Hong' => 'hcn1519@gmail.com', 'Han JeeWoong'=>'hjw01234@gmail.com' }

  s.ios.deployment_target = "9.0"
  s.source           = { :git =>'https://github.com/TileImageTeamiOS/UIScrollView_minimap.git', :tag => s.version.to_s }
  s.source_files  = 'ScrollViewMinimap/Minimap/*.swift'
  s.frameworks = 'UIKit'

end
