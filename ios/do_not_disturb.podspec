#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint do_not_disturb.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'do_not_disturb'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'do_not_disturb/Sources/do_not_disturb/**/*.swift'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # Bundles the privacy manifest for CocoaPods consumers, mirroring the
  # `.process("PrivacyInfo.xcprivacy")` resource declared in Package.swift so
  # both dependency managers ship the same privacy manifest. For more info, see
  # https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  s.resource_bundles = {'do_not_disturb_privacy' => ['do_not_disturb/Sources/do_not_disturb/PrivacyInfo.xcprivacy']}
end
