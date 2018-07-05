class CategoriesController < ApplicationController
  def index
    response = gl_api.get_categories

    if response.status == 200
      @categories = response.body
    else
      redirect_to root_url, notice: 'Can not view categories'
    end
  end

  def show
    response = gl_api.get_category(params[:id])

    if response.status == 200
      @category = response.body
    else
      redirect_to categories_url, notice: 'Category not found'
    end
  end

  def create
    response = gl_api.add_category(params[:name])

    if response.status == 201
      redirect_to categories_url, notice: 'Category was successfully created'
    else
      redirect_to categories_url, notice: 'There was an error creating the category'
    end
  end

  def destroy
    response = gl_api.delete_category(params[:id]) 

    if response.status == 204
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    else
      redirect_to categories_url, notice: response.body.join(', ')
    end
  end

  require 'CSV'
  def download
    show
    
    csv_file = "#{@category["name"]}.csv"
    zip_file = "#{@category["name"]}.zip"

    csv_buf = CSV.generate do |csv|
      csv << @category['games'][0].keys
      @category['games'].each do |hsh| 
        csv << hsh.values 
      end
    end

    zip_buf = Zip::OutputStream.write_buffer do |os| 
      os.put_next_entry csv_file
      os.print csv_buf
    end
    zip_buf.rewind

    send_data zip_buf.read, filename: zip_file, type: 'application/zip'
  end
end