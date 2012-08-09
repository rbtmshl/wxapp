require 'spec_helper'

describe Forecast do

  let(:user) { FactoryGirl.create(:user) }
  before { @forecast = user.forecasts.build(sensible: "Snow", hi_temp: 28, lo_temp: 22, ws: 12, wd: 315, precip_chance: 90, qpf: 0.75) }

  subject { @forecast }

  it { should respond_to(:user_id) }
  it { should respond_to(:sensible) }
  it { should respond_to(:hi_temp) }
  it { should respond_to(:lo_temp) }
  it { should respond_to(:ws) }
  it { should respond_to(:wd) }
  it { should respond_to(:precip_chance) }
  it { should respond_to(:qpf) }
  it { should respond_to(:user) }
  its(:user) { should == user }


  it { should be_valid }

  describe "when user_id is not present" do
    before { @forecast.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Forecast.new(user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end  
end

