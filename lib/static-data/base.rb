module StaticData
  class Base
    # Overrides the default model class for this StaticData class. Use this
    # if your StaticData class name is not "Static + ModelClass". If you stick
    # to the standard naming convention, you don't need this method.
    def self.set_model_class(other_model_class)
      @model_class_name = other_model_class
    end

    # Returns the model class for this StaticData subclass (which is the class
    # name without the "Static" prefix by default, but can be overridden via
    # set_model_class).
    def self.model_class
      model_class_name = @model_class_name || self.name.sub(/^Static/, '')
      Object.const_get(model_class_name)
    end

    # Deletes all model_class records from the database.
    def self.reset
      self.model_class.delete_all
    end

    # Override this method to control which attributes make up the data
    # returned by the `rows` method.
    def self.columns
      []
    end

    # Override this method to return the record data that should always exist
    # in the model class's database table. The columns must appear in the 
    # the order specified by the `columns` method.
    def self.rows
      []
    end

    # Creates new records for all of the data returned by the `rows` method
    # of the StaticData subclass.
    def self.install
      cols = self.columns
      row_class = self.model_class
      self.rows.each do |row|
        row_class.create!(Hash[cols.zip(row)], :without_protection => true)
      end
      return {:created => self.rows.size}
    end

    # Creates new records for all of the data returned by the `rows` method
    # of the StaticData subclass -- unless they exist already.
    def self.update
      created = 0
      existing = 0
      cols = self.columns
      row_class = self.model_class
      self.rows.each do |row|
        attribs = Hash[cols.zip(row)]
        row_class.transaction do
          if row_class.exists?(attribs)
            existing += 1
          else
            row_class.create!(attribs, :without_protection => true)
            created += 1
          end
        end
      end
      return {:created => created, :existing => existing}
    end
  end
end
