# StaticData

StaticData is a Rails plugin that lets you easily manage fixed data 
that you want to always have in your database, and is primarily 
useful for pre-populating lookup tables and the like. It consists of 
a simple framework for describing your static data and a Rake task 
for ensuring that your static data is installed in your database.

It doesn't do much, but it's awfully handy to have a simple way of
adding lookup table data to your database. Anything that makes it 
easier to set up a brand new database from scratch is a win in my
book.

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
file should be named after the model:

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

The current static-data:install task blows away any existing data 
already present in the model's table before installing, so any
non-static data in the table will be nuked. It would be nice to 
offer another task that simply ensures that all static data is
present without deleting other data. I consider that a TODO, but
am happy to receive pull requests.

If you have existing data in your tables and use foreign key 
constraints (which do go hand-in-hand with lookup tables), you
probably don't want to run this rake task, because it will either 
fail or cause delete cascades, depending on how you've set up your
constraints. Fixing the above item should hopefully fix this, too.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
