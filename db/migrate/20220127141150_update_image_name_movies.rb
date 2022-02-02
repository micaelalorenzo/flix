class UpdateImageNameMovies < ActiveRecord::Migration[6.0]
  def change
    change_column :movies, :image_file_name, :string, :default => "placeholder.png"
  end
end
