class ThreeFourExtension < Middleman::Extension

  option :files, {}, 'Hash of input => output of external files'

  def after_configuration
    options[:files].each do |source, dest|
      app.files.reload_path File.expand_path(source)
    end
  end

  def manipulate_resource_list resources
    external_resources = options[:files].map do |source, dest|
      source_file = File.expand_path(source)

      unless resources.map(&:source_file).include?(source_file)
        Middleman::Sitemap::Resource.new app.sitemap, dest, source_file
      else
        nil
      end
    end.compact

    resources + external_resources
  end

end
::Middleman::Extensions.register(:three_four, ThreeFourExtension)
