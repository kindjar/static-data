module StaticData
  class Base
    def self.set_model_class(other_model_class)
      @model_class_name = other_model_class
    end

    def self.model_class
      model_class_name = @model_class_name || self.name.sub(/^Static/, '')
      Object.const_get(model_class_name)
    end

    def self.reset
      self.model_class.delete_all
    end

    def self.install
      cols = self.columns
      row_class = self.model_class
      rows.each do |row|
        row_class.create!(Hash[cols.zip(row)], :without_protection => true)
      end
    end

    # def self.update
    # end
  end
end
