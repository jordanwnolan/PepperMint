require 'spec_helper'

describe TransactionCategory do
  it { should validate_presence_of(:description) }
end
