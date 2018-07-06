module DownloadsConcern 
  extend ActiveSupport::Concern

  require 'CSV'

  def category_to_csv_stream(category = @category)
    games = category['games']

    CSV.generate do |csv|
      break if games.empty?
      csv << games[0].keys
      games.each do |hsh| 
        csv << hsh.values 
      end
    end
  end

  def file_stream_to_zip_stream(file_stream, filename)
    zip_stream = Zip::OutputStream.write_buffer do |os| 
      os.put_next_entry filename
      os.print file_stream
    end
    zip_stream.rewind
    zip_stream
  end
end