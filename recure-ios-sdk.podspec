Pod::Spec.new do |spec|

  spec.name         = "recure-ios-sdk"
  spec.version      = "1.0.0"
  spec.summary      = "Official Recure SDK for iOS."
  spec.description  = <<-DESC
  Recure AI helps companies increase their revenue by detecting account sharers and free trial abusers and converting them into paying customers.
  DESC

  spec.homepage     = "https://github.com/Recure-AI/recure-ios-sdk"
  spec.license      = "MIT"
  spec.author             = { "Recure" => "no-reply@recure.ai" }

  spec.platform     = :ios, "13.0"
  spec.ios.deployment_target = "13.0"
  spec.swift_versions = "5.3"

  spec.source       = { :git => "https://github.com/Recure-AI/recure-ios-sdk.git", :tag => spec.version.to_s }
  spec.source_files  = "Sources/Recure/**/*.{swift}"
end
