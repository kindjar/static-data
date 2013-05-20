# StaticData

StaticData is a Rails plugin that lets you easily manage fixed data 
that you want to always have in your database, and is primarily 
useful for pre-populating lookup tables and the like. It consists of 
a simple framework for describing your static data and a Rake task 
for ensuring that your static data is installed in your database.

While you can use migrations to do this, you can't referencing models
in migrations can get you into trouble, and it can be awkward to 
update static data in migrations later.

It doesn't do much, but it's awfully handy to have a simple way of
adding lookup table data to your database. And with StaticData, you 
can easily add new data and make it easy for to get everyone's 
database in sync with the latest static data (even production).

## Installation

Add this line to your application's Gemfile:

    gem 'static-data'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install static-data

## Usage

Create a db/static-data directory in your app:

    mkdir db/static-data

Create a file for each model that you want to store static for. The
file should be named after the model. Implement two class methods, `columns`
and `rows`. The `columns` method should return the names of the columns in the 
order their data appears in the `rows`

    # For a model named ImageType:
    cat > db/static-data/image_type.rb <<EOF 
    class StaticImageType < StaticData::Base
      def self.columns
        [:name, :mime_type, :extension]
      end

      def self.row
      [
        ['PNG', 'image/png', 'png'],
        ['JPEG', 'image/jpeg', 'jpg'],
      ]
      end
    end
    EOF

Install your static data:

    rake static-data:install

Enjoy!

## Limitations

StaticData isn't designed for large volumes of data and performance may be poor
on large static data sets.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
