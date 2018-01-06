require 'rails_helper'

RSpec.describe Picture, type: :model do

  it 'has a valid factory' do
    expect(build(:picture)).to be_valid
  end

  it 'is invalid if image is smaller than 500x500' do
    expect(build(:picture, image: file_fixture('taxationistheft.jpg').open)).not_to be_valid
  end

  it 'is valid if user eq nil' do
    expect(build(:picture, user: nil)).to be_valid
  end

  it 'is invalid if image is not image type' do
    expect(build(:picture, image: file_fixture('testtext.txt').open)).not_to be_valid
  end

  it 'is invalid if image is bigger then 50mb' do
    picture = build(:picture)
    picture.image_file_size = 51.megabytes
    expect(picture).not_to be_valid
  end

end
