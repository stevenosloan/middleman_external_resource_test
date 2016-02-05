if Middleman::VERSION >= '4.0'

  import_path File.join( __dir__, 'import_path_dir' ) do |path|
    path.chomp(File.extname(path)).sub(/^\/?import_path_dir\//, '')
  end

  import_file File.join( __dir__, 'import_file_dir', 'import.html.erb' ),
              'import.html'

  import_file File.join( __dir__, 'import_file_dir', 'frontmatter.html.erb' ),
              'frontmatter.html'

  files.watch :source, path: File.join( __dir__, 'import_path_dir' )
  files.watch :source, path: File.join( __dir__, 'import_file_dir' )

else
  require_relative 'lib/three_four_extension'
  activate :three_four do |c|
    c.files = {
      'import_path_dir/outside_source.html.md'       => 'outside_source.html',
      'import_path_dir/data_outside_source.html.erb' => 'data_outside_source.html',
      'import_file_dir/import.html.erb'              => 'import.html',
      'import_file_dir/frontmatter.html.erb'         => 'frontmatter.html'
    }
  end
end


configure :build do
  set :build_dir, ENV['BUILD_DIR'] if ENV['BUILD_DIR']
end
