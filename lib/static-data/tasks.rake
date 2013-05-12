namespace "static-data" do
  desc "Install all static data from db/static-data"
  task :install => :environment do
    require "static-data"

    Dir.glob('db/static-data/*') do |file|
      basename = File.basename(file).split('.', 2).first
      expected_class_name = "Static" + basename.
          camelize

      start = Time.now
      puts "== #{expected_class_name}: installing"

      require "#{Rails.root}/db/static-data/#{basename}"
      Object.const_get(expected_class_name).tap do |static_data_class|
        step_start = Time.now
        puts "-- reset"
        static_data_class.reset
        puts "   -> %0.4fs" % [(Time.now - step_start)]

        step_start = Time.now
        puts "-- install"
        static_data_class.install
        puts "   -> %0.4fs" % [(Time.now - step_start)]
      end

      puts "== #{expected_class_name}: installed (%0.4fs)" % [(Time.now - start)]
      puts
    end
  end
end