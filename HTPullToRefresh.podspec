Pod::Spec.new do |s|
  s.name     = 'HTPullToRefresh'
  s.version  = '0.0.1'
  s.platform = :ios, '5.0'
  s.license  = 'MIT'
  s.summary  = 'Give multiple pull-to-refreshes to any UIScrollView (both vertically and/or horizontally) with minial setup'
  s.homepage = 'https://github.com/hoang-tran/HTPullToRefresh'
  s.author   = { 'Hoang Tran' => 'hoangtx.master@gmail.com' }
  s.source   = { :git => 'https://github.com/hoang-tran/HTPullToRefresh', :tag => s.version.to_s }

  s.description = 'HTPullToRefresh allows you to easily add multiple pull-to-refreshes ' \
                  'to your UIScrollView (both vertically and/or horizontally) with minimal setup'

  s.frameworks   = 'QuartzCore'
  s.source_files = 'SVPullToRefresh/*.{h,m}'
  s.preserve_paths  = 'Demo'
  s.requires_arc = true
end
