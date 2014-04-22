require 'spec_helper'

describe Account do
  it { should belong_to(:user) }
  it { should belong_to(:bank) }
  it { should validate_presence_of(:account_username) }
  it { should validate_presence_of(:account_password) }
  it { should validate_presence_of(:account_name) }
end
