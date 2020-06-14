require 'rails_helper'

RSpec.describe Event, :type => :model do
  let(:user) { create(:user) }
  let(:event_type) { :check_in }
  let(:occurred_at) { Time.local(2020, 1, 1, 8, 0, 0) }
  let(:event) {build(:event, event_type: event_type, occurred_at: occurred_at, user: user)}

  it "event is valid with valid attributes" do
    expect(event).to be_valid
  end

  context "when event cannot be in future" do
    let(:occurred_at) { Time.local(2021, 1, 1, 0, 0, 0) }
    it { expect(event).not_to be_valid }
    it do "includes error message"
      event.valid?
      expect(event.errors[:occurred_at]).to include("can't be in the future")
    end
  end
    
  context "when event is outside office hours" do
    let(:occurred_at) { Time.local(2020, 1, 1, 0, 0, 0) }
    it { expect(event).not_to be_valid }
    it do "includes error message"
      event.valid?
      expect(event.errors[:occurred_at]).to include("event time should be between office hours")
    end
  end
    
  context "when event type is check_out event without check_in" do
    let(:occurred_at) { Time.local(2020, 1, 1, 8, 0, 0) }
    let(:event_type) { :check_out }
    it { expect(event).not_to be_valid }
    it do "includes error message"
      event.valid?
      expect(event.errors[:event_type]).to include("need to check in first")
    end
  end

  context "when event type is check_in event without check_out" do
    let!(:chech_in_event) { create(:event, :check_in, occurred_at: Time.local(2020, 1, 1, 8, 0, 0), user: user) }
    let(:occurred_at) { Time.local(2020, 1, 1, 9, 0, 0) }
    let(:event_type) { :check_in }
    it { expect(event).not_to be_valid }
    it do "includes error message"
      event.valid?
      expect(event.errors[:event_type]).to include("need to check out first")
    end
  end

  it { should validate_presence_of(:occurred_at) }
  it { should validate_presence_of(:event_type) }
  it { should belong_to(:user) }
end
