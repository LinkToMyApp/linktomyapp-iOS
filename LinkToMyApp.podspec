Pod::Spec.new do |s|
  s.name         = "LinkToMyApp"
  s.version      = "1.0"
  s.summary      = "Link To My App iOS SDK"
  s.homepage     = "https://github.com/tiboll/linktomyapp-iOS"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "LinkToMyApp" => "http://linktomyapp.com" }
  s.source       = { :git => "https://github.com/tiboll/linktomyapp-iOS.git", :branch => "master" }
  s.platform     = :ios, '5.0'
  s.source_files = 'LinkToMyApp/*.{h,m}'
  s.requires_arc = true
end