module HomeHelper

  # Valid Patient Headers in order
  def patient_headers
    ["patient_id", "patient_name", "state"]
  end

  # Valid Order Headers in order
  def order_headers
    ["category","order_id", "state"]
  end

  # Valid Invoice Headers in order
  def invoice_headers
    ["order_id", "patient_id", "state"]
  end

  # extracts the zip file and loops only csv files and update records
  def update_records_with_zip
    zip_file = Zip::File.open(params[:file])
    zip_file.sort.each do |entry|
      if entry.file? && File.extname(entry.name) == '.csv'
        csv_text = entry.get_input_stream.read
        @csv = CSV.parse(csv_text)
        @filename = entry.name
        update_records
      end # csv file check condition
    end
  end

  # reads the csv file and update records
  def update_records_with_csv
    @csv = CSV.read(params[:file])
    @filename = params[:file].original_filename
    update_records
  end

  # check if the file belongs to patients, orders or invoices and update records
  def update_records
    @headers = @csv.first
    case @headers.sort
    when patient_headers
      update_patient
    when order_headers
      update_order
    when invoice_headers
      update_invoice
    else
      @error.push(I18n.t('controllers.home.file_upload.invalid_file', file_name: @filename))
    end
  end

  # update record to DB if it is patient
  def update_patient
    data = get_data
    data.each do |record|
      patient = Patient.find_by_patient_id(record["patient_id"])
      patient.present? ? patient.update(record) : Patient.create(record)
    end
  end

  # update record to DB if it is order
  def update_order
    data = get_data
    data.each do |record|
      order = Order.find_by_order_id(record["order_id"])
      order.present? ? order.update(record) : Order.create(record)
    end
  end

  # update record to DB if it is invoice
  def update_invoice
    data = get_data
    data.each_with_index do |record,index|
      invoice = Invoice.create(record)
      @error.push(
        I18n.t(
          'controllers.home.file_upload.invalid_records',
          file_name: @filename,
          line_num: index+1,
          error: invoice.errors.full_messages.join(','))
        ) if invoice.errors.present?
    end
  end

  # generates the array of hashes with the data in the file
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
