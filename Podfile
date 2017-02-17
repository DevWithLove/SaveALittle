platform :ios, '9.0'
use_frameworks!

def savealittle_shared_pods
  pod 'FoldingCell'
  pod 'Charts'
  pod 'SlideMenuControllerSwift'
  pod 'UICircularProgressRing'
  pod 'SCLAlertView'
  pod 'SwiftDate', '~> 4.0'
  pod 'SkyFloatingLabelTextField', '~> 2.0.0'
  pod 'RealmSwift'
end

target 'SaveALittle' do

  # Pods for SaveALittle
  savealittle_shared_pods

  target 'SaveALittleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SaveALittleUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'SaveALittleDev' do
  # Pods for SaveALittleDev
  savealittle_shared_pods

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
