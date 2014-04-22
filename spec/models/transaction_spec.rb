require 'spec_helper'

describe Transaction do
  it { should belong_to(:account) }
  it { should belong_to(:merchant_category) }
  it { should belong_to(:merchant_category).with_foreign_key(:merchant_category_code) }
end
