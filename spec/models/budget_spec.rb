require 'spec_helper'

describe Budget do
  it { should belong_to(:user) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:frequency)}
  it { should validate_presence_of(:frequency_reset) }
  it { should validate_presence_of(:amount) }

  context "Budget::calculate_progress_for_budgets should take an array of budgets and return a hash of budget => [progress, on_track?]"

  context "Budget#progress takes in one budget and returns the progress"

  context "Budget#on_track takes in one budget and calculates if it is on track"
end
