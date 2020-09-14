class HomeController < ApplicationController
  include HomeHelper
  require 'csv'
  require 'zip'

  def index
  end

  def orders
    @orders = Order.includes(:invoices,:patients).active_orders
  end

  def file_upload
    @error = []
    zip_file = Zip::File.open(params[:file])
    zip_file.sort.each do |entry|
      if entry.file? && File.extname(entry.name) == '.csv'
        update_records(entry)
      end # csv file check condition
    end
    flash_msg = {}
    @error.present? ? flash_msg[:error] = @error : flash_msg[:notice] = I18n.t('controllers.home.file_upload.success')
    redirect_to root_path, flash: flash_msg
  end
end
