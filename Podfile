platform :ios, '13.0'

use_frameworks!

workspace 'BeersApp.xcworkspace'

target 'BeersApp' do
  project './BeersApp.xcodeproj' 

  # Reactive support
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxCocoa', '~> 5.1.0'

  # Autolayout
  pod 'SnapKit', '~> 5.0.1'

  #Code generation
  pod 'SwiftGen', '6.1.0'

  #Image loading
  pod 'Kingfisher', '~> 5.0'

  # Data loading
  pod 'Alamofire', '~> 4.7.3'
  
end

target 'BeersCore' do
  project './BeersCore/BeersCore.xcodeproj' 

  # Reactive support
  pod 'RxSwift', '~> 5.1.0'
  pod 'RxCocoa', '~> 5.1.0'

  # Data loading
  pod 'Alamofire', '~> 4.7.3'

end
