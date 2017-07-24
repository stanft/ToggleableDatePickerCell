Pod::Spec.new do |s|
    s.name         = 'ToggleableDatePickerCell'
    s.version      = '1.0.0'
    s.license      = { :type => 'MIT' }
    s.homepage     = 'https://github.com/stanft/ToggleableDatePickerCell'
    s.authors      = {'Dylan Vann' => 'dylanvann@gmail.com',
                      'Stephan Anft' => 'trivial@gmx.net'}
    s.summary      = 'Activatable inline/expanding date picker for table views.'
    s.ios.deployment_target = '9.3'
    s.source       = { :git => 'https://github.com/stanft/ToggleableDatePickerCell.git' }
    s.source_files = 'Source/*.{swift,xib}'
end
