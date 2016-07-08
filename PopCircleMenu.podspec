Pod::Spec.new do |s|
  s.name = 'PopCircleMenu'
  s.version = '0.1.1'
  s.license = 'MIT'
  s.summary = 'Pinterest like pop circle menu'
  s.homepage = 'https://github.com/luiyezheng/PopCircleMenu'
  s.authors = { 'luiyezheng' => 'luiyezheng@foxmail.com' }
  s.source = { :git => 'https://github.com/luiyezheng/PopCircleMenu.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source'

  s.requires_arc = false
end
