require 'rails_helper'

RSpec.describe Order, :type => :model do

  before :all do 
    Patient.destroy_all
    Order.destroy_all
    Invoice.destroy_all
  end
  
  subject { described_class.new(order_id: "C032306", category: "big_chinstrap", state:'active') }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "count of active records to be 1" do
    subject.save
    expect(Order.active_orders.count).to eq(1)
  end

  it "count of active records to be 0" do
    subject.state = 'deleted'
    subject.save
    expect(Order.active_orders.count).to eq(0)
  end

end