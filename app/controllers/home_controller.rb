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
