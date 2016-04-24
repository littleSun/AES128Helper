#
#  Be sure to run `pod spec lint AES128Helper.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "AES128Helper"
  s.version      = "1.0.0"
  s.summary      = "AES128 used for encryption or decrypt, apply the ECB mode, pcks5 or pcks7 padding."

  s.homepage     = "https://github.com/littleSun"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  s.author             = { "littleSun" => "noah_nj@163.com" }
  # Or just: s.author    = "zengchao"
  # s.authors            = { "zengchao" => "noah_nj@163.com" }
  # s.social_media_url   = "http://twitter.com/zengchao"


  # s.platform     = :ios
  s.platform     = :ios, "6.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

  s.source       = { :git => "https://github.com/littleSun/AES128Helper.git", :tag => s.version }

  s.source_files  = "AES128Helper/Encrypt/AES128Helper.{h,m}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "GTMBase64"

end
