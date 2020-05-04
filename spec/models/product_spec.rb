require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    subject { 
      described_class.new(
        name: "Anything",
        description: "Anything",
        image: "apparel1.jpg",
        price_cents: 100,
        quantity: 100,
        created_at: DateTime.now,
        updated_at: DateTime.now + 1.week,
        category: Category.new)
      }
    

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a price" do
      subject.price_cents = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a quantity" do
      subject.quantity = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a category" do
      subject.category = nil
      expect(subject).to_not be_valid
    end
  end
end
