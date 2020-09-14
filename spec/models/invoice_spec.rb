require 'rails_helper'

RSpec.describe Invoice, :type => :model do

  before :all do 
    Patient.destroy_all
    Order.destroy_all
    Invoice.destroy_all
    @patient = Patient.create(patient_id: "U5316491", patient_name: "Noah Thomas", state:'active')
    @order = Order.create(order_id: "C0323061", category: "big_chinstrap", state:'active')
  end

  it "is valid with valid attributes" do
    invoice = Invoice.new(patient_id: @patient.patient_id, order_id: @order.order_id)
    expect(invoice).to be_valid
  end

  it "is not valid with order not exists" do
    invoice = Invoice.new(patient_id: @patient.patient_id, order_id: 'UNKNOWN')
    expect(invoice).to_not be_valid
  end

  it "is not valid with patient not exists" do
    invoice = Invoice.new(patient_id: 'UNKNOWN', order_id: @order.order_id)
    expect(invoice).to_not be_valid
  end
  
  it "count of active records to be 1" do
    invoice = Invoice.create(patient_id: @patient.patient_id, order_id: @order.order_id, state: 'active')
    expect(Invoice.active_invoices.count).to eq(1)
  end

  it "count of active records to be 0" do
    invoice = Invoice.create(patient_id: @patient.patient_id, order_id: @order.order_id, state: 'deleted')
    expect(Invoice.active_invoices.count).to eq(0)
  end

end