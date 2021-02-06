platform :ios, '13.0'
workspace 'Fantazia'

inhibit_all_warnings!
use_frameworks!

def google_utilites
  pod 'GoogleUtilities'
end

def ad
  pod 'Google-Mobile-Ads-SDK'
end

def sdk
  pod 'Firebase/Analytics'
end

target 'Fantazia' do
  project 'Fantazia/Fantazia'

  google_utilites
#  ad
  sdk
end

target 'Balance' do
  project 'Game/Balance/Balance'

  google_utilites
#  ad
end

target 'BalanceApp' do
  project 'Game/Balance/Balance'

  google_utilites
#  ad
end

target 'Core' do
  project 'Common/Core/Core'

  google_utilites
#  ad
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
