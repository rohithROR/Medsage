class HomeController < ApplicationController
  include HomeHelper
  require 'csv'

  def index
  end

  def orders
    @orders = Order.includes(:invoices,:patients).active_orders
  end

  def file_upload
    @csv = CSV.read(params[:file])
    @headers = @csv.first
    case @headers.sort
    when patient_headers
      update_patient
    when order_headers
      update_order
    when invoice_headers
      update_invoice
    else
      I18n.t 'controllers.home.file_upload.invalid_file'
    end
    render :action => 'index'
  end
end
