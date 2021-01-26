platform :ios, '13.0'
workspace 'Fantazia'

inhibit_all_warnings!
use_frameworks!

target 'Fantazia' do
  project 'Fantazia/Fantazia'

  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
