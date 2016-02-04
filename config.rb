if Middleman::VERSION >= '4.0'
  import_file File.join( __dir__, 'dir', 'outside_source.html.md' ),
              'outside_source.html'

  import_file File.join( __dir__, 'dir', 'data_outside_source.html.erb' ),
              'data_outside_source.html'
else
  require_relative 'lib/three_four_extension'
  activate :three_four do |c|
    c.files = {
      'dir/outside_source.html.md'       => 'outside_source.html',
      'dir/data_outside_source.html.erb' => 'data_outside_source.html'
    }
  end
end


configure :build do
  set :build_dir, ENV['BUILD_DIR'] if ENV['BUILD_DIR']
end
