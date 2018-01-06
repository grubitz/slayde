FactoryGirl.define do
  factory :picture do
    image { File.open('spec/fixtures/files/saul.jpg') }
    name "MyString"
    user
  end
end
