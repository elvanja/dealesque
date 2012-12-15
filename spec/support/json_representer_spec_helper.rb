require "rspec"

module JsonRepresenterSpecHelper
  def self.included(base)
    base.class_eval do
      def self.should_decode_with_json_representer(data_hash, representer, target_class)
        data_hash.each do |key, value|
          it "decodes #{key} from json" do
            subject = should_represent_from_json(representer, Hash[key, value].to_json, target_class)
            should_compare_json_attribute(key, representer, subject, value)
          end
        end

        it "decodes all from json" do
          subject = should_represent_from_json(representer, data_hash.to_json, target_class)
          data_hash.each do |key, value|
            should_compare_json_attribute(key, representer, subject, value)
          end
        end
      end

      def should_compare_json_attribute(key, representer, subject, value)
        attribute = representer.representable_attrs.find { |attribute| attribute.name == key.to_s || attribute.options[:from] == key }
        fail("can't decode #{key} from json for #{subject.class}") unless attribute
        expect(subject.public_send(attribute.name)).to eq(value)
      end

      def should_represent_from_json(representer, json, target_class = OpenStruct)
        target_class.new.extend(representer).from_json(json)
      end
    end
  end
end