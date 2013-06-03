# 0.3.0

* Add a rails generator for creating a new static data model.
* Update docs to demonstrate `update` rake task and new generator.

# 0.2.0

* Add support for incrementally updating tables rather than merely deleting all 
data and rewriting. This should play nicer with foreign key constraints on
static data tables, which, after all, is one of the main reasons to use a static
data table in the first place. Use the new rake task `static-data:update`.

# 0.1.1

* Add rdocs for StaticData::Base
* Update homepage to github location in gemspec