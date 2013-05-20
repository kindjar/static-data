require "static-data/version"
require "static-data/base"
require "static-data/railtie" if defined?(Rails)

module StaticData

  def self.report_duration(step_name, report_format)
    puts step_name
    start = Time.now
    yield
    puts report_format % [Time.now - start]
  end

  def self.static_data_classes(root)
    static_data_class_files(root).each do |file|
      basename = File.basename(file).split('.', 2).first
      expected_class_name = "Static" + basename.camelize

      require File.join(root, 'db', 'static-data', basename)

      klass = Object.const_get(expected_class_name)
      yield klass
    end
  end

  private

  def self.static_data_class_files(root)
    Dir.glob(File.join(root, 'db', 'static-data', '*.rb')).sort
  end

end
