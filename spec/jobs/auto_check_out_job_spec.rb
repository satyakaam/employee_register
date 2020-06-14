require "rails_helper"

RSpec.describe AutoCheckOutJob, :type => :job do
  describe "#perform" do
    let(:user) { create(:user) }
    let!(:chech_in_event) { create(:event, :check_in, occurred_at: Time.current.change({ hour: 8 }), user: user) }
    it "auto check out the checked_in users" do
      AutoCheckOutJob.perform_now
      expect(Event.count).to eq(2)
      expect(Event.first.auto_generated).to eq(true)      
    end
  end
end
