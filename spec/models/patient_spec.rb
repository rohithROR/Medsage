require 'rails_helper'

RSpec.describe Patient, :type => :model do

  before :all do 
    Patient.destroy_all
    Order.destroy_all
    Invoice.destroy_all
  end
  
  subject { described_class.new(patient_id: "U531649", patient_name: "Noah Thomas", state:'active') }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "count of active records to be 1" do
    subject.save
    expect(Patient.active_patients.count).to eq(1)
  end

  it "count of active records to be 0" do
    subject.state = 'deleted'
    subject.save
    expect(Patient.active_patients.count).to eq(0)
  end

end