
Pod::Spec.new do |s|
  s.name         = "UICollectionViewCarouselLayout"
  s.version      = "1.0"
  s.summary      = "A UICollectionViewLayout base on UICollectionViewFlowLayout"
  s.homepage     = "https://github.com/godL/UICollectionViewCarouselLayout"
  s.license      = "MIT"
  s.author             = { "GodL" => "547188371@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/godL/UICollectionViewCarouselLayout.git", :tag => s.version.to_s }
  s.source_files  = "UICollectionViewCarouselLayout", "UICollectionViewCarouselLayout/UICollectionViewCarouselLayout.h"
  s.public_header_files = 'UICollectionViewCarouselLayout/*.{h,m}'
  s.framework  = "UIKit"
  s.requires_arc = true
end
