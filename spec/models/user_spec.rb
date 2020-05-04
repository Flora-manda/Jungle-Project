require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { 
    described_class.new(
      first_name: "Anything",
      last_name: "Anything",
      password: "some_password",
      password_confirmation: "some_password",
      email: "john@doe.com")
    }

  describe "Validations" do
       it "is valid with valid attributes" do
        expect(subject).to be_valid
       end
  
      it "is not valid without a first name" do
        subject.first_name= nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a last name" do
        subject.last_name= nil
        expect(subject).to_not be_valid
      end
  
      it "is not valid without an email" do
        subject.email = nil
        expect(subject).to_not be_valid
      end

      it "is not valid without a password" do
        subject.password = nil
        expect(subject).to_not be_valid
      end

      it "validates password length" do
        subject.password = "some"
        expect(subject).to_not be_valid
      end

      it "validates password confirmation" do
        subject.password_confirmation = "some_password_2"
        expect(subject).to_not be_valid
      end

      it "validates email uniqueness" do
        subject2 = User.create(
        first_name: "Anything",
        last_name: "Anything",
        password: "some_password",
        password_confirmation: "some_password",
        email: "john@doe.com")

        subject.email = subject2.email
        expect(subject.save).to be_falsey
        expect(subject.errors.full_messages).to include("Email has already been taken")
      end

  describe '.authenticate_with_credentials' do
        it "should authenticate email entered with spaces around" do
          subject.save
          user = User.authenticate_with_credentials("  john@doe.com  ", "some_password")
          expect(user).to be_instance_of (User)
          expect(user.id).to eql (subject.id)
        end

        it "should authenticate email entered with upper of lower case" do
          subject.save
          user = User.authenticate_with_credentials("joHN@DOe.com", "some_password")
          expect(user).to be_instance_of (User)
          expect(user.id).to eql (subject.id)
        end
  end
  end
end
