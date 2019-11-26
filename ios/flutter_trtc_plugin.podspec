#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_trtc_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.ios.vendored_frameworks = 'Frameworks/TXLiteAVSDK_Professional.framework'
  s.vendored_frameworks = 'TXLiteAVSDK_Professional.framework'
  s.resources = 'Resources/back_full.png','Resources/close.png','Resources/more_b.png','Resources/muteAudio.png','Resources/muteVideo.png','Resources/scaleFill.png','Resources/scaleFit.png','Resources/signal1.png','Resources/signal2.png','Resources/signal3.png','Resources/signal4.png','Resources/signal5.png','Resources/unmuteAudio.png','Resources/unmuteVideo.png','Resources/VideoClosed.png','Resources/beauty_dis.png','Resources/beauty.png','Resources/camera.png','Resources/muteVideo.png','Resources/camera2.png','Resources/log_b.png','Resources/log_b2.png','Resources/gird_b.png','Resources/float_b.png','Resources/mute_b.png','Resources/mute_b2.png','Resources/linkmic_start.png','Resources/linkmic_stop.png','Resources/beauty_b.png','Resources/beauty_b2.png','Resources/set.png','Resources/set_b.png','Resources/set_b2.png'
  s.ios.deployment_target = '8.0'
end

