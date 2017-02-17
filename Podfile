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
