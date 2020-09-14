class HomeController < ApplicationController
  include HomeHelper
  require 'csv'
  require 'zip'

  # Landing Page for the application
  # Importing the zip/csv file
  # GET: home/index
  def index
  end

  # GET: home/orders
  # Fetch the active orders along with respective patients and invoices
  def orders
    @orders = Order.includes(:invoices,:patients).active_orders
  end

  # POST:home/file_upload
  # differentiate if it is csv or zip file
  # process the file and updates data in DB
  # pushes the list of errors if any and delivers to frontend using flash
  def file_upload
    @error = []
    file_ext = File.extname(params[:file]).downcase
    if file_ext == '.zip'
      update_records_with_zip
    elsif file_ext == '.csv'
      update_records_with_csv
    end
    flash_msg = {}
    @error.present? ? flash_msg[:error] = @error : flash_msg[:notice] = I18n.t('controllers.home.file_upload.success')
    redirect_to root_path, flash: flash_msg
  end
end
