MM_VERSIONS = %w[ 3.4  4.0   4.1 ]

namespace :run do

  def with_gemfile gemfile, clean=false, &block
    Bundler.with_clean_env do
      gemfile = File.expand_path(gemfile)
      ENV['BUNDLE_GEMFILE'] = gemfile

      unless File.exist?( "#{gemfile}.lock")
        args = ["--quiet"]
        puts "bundling #{gemfile}"
        `bundle install --gemfile='#{gemfile}' --binstubs #{args.join(' ')}`
      end

      system "bundle exec '#{yield}'"
    end
  end

  def tracer msg
    puts ""
    puts (0..(msg.length+10)).map { |i| "=" }.join
    puts "     #{msg}"
    puts (0..(msg.length+10)).map { |i| "=" }.join
  end

  MM_VERSIONS.each do |version|
    desc "run build with middleman #{version}"
    task :"build:#{version}" do
      tracer "building with MM #{version}"
      with_gemfile "gemfiles/middleman.#{version}/Gemfile" do
        "BUILD_DIR=build_#{version} gemfiles/middleman.#{version}/bin/middleman build --verbose"
      end
    end

    desc "run console with middleman #{version}"
    task :"console:#{version}" do
      tracer "mounting console on MM #{version}"
      with_gemfile "gemfiles/middleman.#{version}/Gemfile" do
        "gemfiles/middleman.#{version}/bin/middleman console"
      end
    end
  end

end

desc "build on available versions of middleman"
task :build => MM_VERSIONS.map { |v| "run:build:#{v}" }

