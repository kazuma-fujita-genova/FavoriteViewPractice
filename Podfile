# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

use_frameworks!

def install_pods
  # pod 'FSPagerView'
  pod 'CHIPageControl'
  pod 'Hero'
  pod 'FaveButton'
  pod 'MaterialComponents'
  pod 'ImageSlideshow'
  pod 'FDFullscreenPopGesture'
end

target 'FavoriteViewPractice' do
  install_pods
end

swift4_0_names = [
  'FaveButton',
]

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if swift4_0_names.include? target.name
                config.build_settings['SWIFT_VERSION'] = "4.0"
            else
                config.build_settings['SWIFT_VERSION'] = "4.2"
            end
        end
    end
end

