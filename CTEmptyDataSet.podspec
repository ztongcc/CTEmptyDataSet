Pod::Spec.new do |s|
  s.name         = "CTEmptyDataSet"
  s.version      = "0.0.1"
  s.summary      = "UITableView 和 UICollectionView的扩展"
  s.description  = <<-DESC
                     UITableView 和 UICollectionView的扩展
                   DESC
  s.homepage     = "https://github.com/Excalibur-CT/CTEmptyDataSet"
  s.license      = 'MIT'
  s.author       = { "Evan.Cheng" => "Evan_Tong@163.com" }
  s.source       = { :git => "https://github.com/Excalibur-CT/CTEmptyDataSet.git", :tag =>  s.version }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.public_header_files = 'CTEmptyDataSet/UIScrollView+Empty.h'
  s.source_files = 'CTEmptyDataSet/UIScrollView+Empty.{h,m}'

  s.frameworks   = 'Foundation', 'UIKit'

end
