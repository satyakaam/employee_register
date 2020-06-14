require 'rails_helper'

RSpec.describe User, :type => :model do
  it "user is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end

  it "admin is valid with valid attributes" do
    expect(build(:user, :admin)).to be_valid
  end

  it { should validate_presence_of(:name) }
  it { should have_many(:events) }
end
