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

      respond_to do |format|
        format.html
        format.zip do 
          if @category['games'].present?
            send_data download_zip_stream.read, filename: "#{@category['name']}.zip"
          else
            redirect_to categories_url, alert: 'Category is empty'
          end
        end
      end
    else
      redirect_to categories_url, alert: 'Category not found'
    end
  end

  def create
    response = gl_api.add_category(params[:name])

    if response.status == 201
      redirect_to categories_url, notice: 'Category was successfully created'
    else
      redirect_to categories_url, alert: 'There was an error creating the category'
    end
  end

  def destroy
    response = gl_api.delete_category(params[:id]) 

    if response.status == 204
      redirect_to categories_url, notice: 'Category was successfully destroyed.'
    else
      redirect_to categories_url, alert: response.body.join(', ')
    end
  end

  private
  include DownloadsConcern

  def categories_params
    params.permit(:name).to_h.symbolize_keys
  end

  def download_zip_stream
    @zip_stream ||= begin
      csv_filename = "#{@category['name']}.csv"
      csv_stream = category_to_csv_stream(@category)
      file_stream_to_zip_stream(csv_stream, csv_filename)
    end
  end
end