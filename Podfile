# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LightningNode' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LightningNode
    pod 'LNDrpc', :path => '.'
    pod 'KeychainAccess'
    pod 'NVActivityIndicatorView'
    pod 'PanModal'
    pod 'M13Checkbox'

  target 'LightningNodeTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'LNDrpc', :path => '.'
    pod 'SnapshotTesting'
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['SnapshotTesting'].include? target.name
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
  end
end