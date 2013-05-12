require 'static-data'

describe StaticData::Base do
  it "model_class returns class without Static in it" do
    class FooBar; end
    class StaticFooBar < StaticData::Base; end

    class_obj = Object.const_get('StaticFooBar')
    class_obj.model_class.should eql(FooBar)
  end

  it 'model_class returns alternate class if set_model_class is used' do
    class Bazzle; end
    class StaticFooBar < StaticData::Base
      set_model_class 'Bazzle'
    end

    class_obj = Object.const_get('StaticFooBar')
    class_obj.model_class.should eql(Bazzle)
  end
end
