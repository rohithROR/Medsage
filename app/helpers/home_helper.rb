module HomeHelper
  def patient_headers
    ["patient_id", "patient_name", "state"]
  end

  def order_headers
    ["category","order_id", "state"]
  end

  def invoice_headers
    ["order_id", "patient_id", "state"]
  end

  def update_patient
    begin
      data = get_data
      data.each do |record|
        patient = Patient.find_by_patient_id(record["patient_id"])
        patient.present? ? patient.update(record) : Patient.create(record)
      end
      flash[:notice] = I18n.t('controllers.home.file_upload.success', parameter: "Patients")
    rescue
      flash[:error] = I18n.t 'controllers.home.file_upload.failure'
    end
  end

  def update_order
    begin
      data = get_data
      data.each do |record|
        order = Order.find_by_order_id(record["order_id"])
        order.present? ? order.update(record) : Order.create(record)
      end
      flash[:notice] = I18n.t('controllers.home.file_upload.success', parameter: "Orders")
    rescue
      flash[:error] = I18n.t 'controllers.home.file_upload.failure'
    end
  end

  def update_invoice
    begin
      data = get_data
      data.each do |record|
        invoice = Invoice.create(record)
      end
      flash[:notice] = I18n.t('controllers.home.file_upload.success', parameter: "Invoices")
    rescue
      flash[:error] = I18n.t 'controllers.home.file_upload.failure'
    end
  end

  def get_data
    data_array = []
    @csv.drop(1).each do |row|
      row_hash = {}
      row.each_with_index do |col,index|
        row_hash[@headers[index]] = col
      end
      data_array << row_hash
    end
    data_array
  end
end
