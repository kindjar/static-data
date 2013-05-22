namespace "static-data" do

  desc "Install all static data from db/static-data"
  task :install => :environment do
    require "static-data"

    StaticData.static_data_classes(Rails.root) do |static_data_class|
      StaticData.report_duration("== #{static_data_class}: installing", 
          "== #{static_data_class}: installed (%0.4fs)") do

        StaticData.report_duration("-- reset", "   -> %0.4fs") do
          static_data_class.reset
        end        

        StaticData.report_duration("-- install", "   -> %0.4fs") do
          static_data_class.install
        end
      end

      puts    # add blank line separator
    end
  end

  desc "Update any missing static data table rows from db/static-data"
  task :update => :environment do
    require "static-data"

    StaticData.static_data_classes(Rails.root) do |static_data_class|
      StaticData.report_duration("== #{static_data_class}: updating", 
          "== #{static_data_class}: updated (%0.4fs)") do

        StaticData.report_duration("-- update", "   -> %0.4fs") do
          results = static_data_class.update
          puts "   -> existing: #{results[:existing]}; added: #{results[:created]}"
        end
      end

      puts    # add blank line separator
    end
  end

end