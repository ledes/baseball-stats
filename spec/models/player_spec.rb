require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should have_many(:statistics) }
  it { should validate_presence_of :name }
  it { should validate_presence_of :given_name }
  it { should validate_presence_of :position }
end
