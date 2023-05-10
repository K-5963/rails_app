class AddDetailsToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :summary, :text
    add_column :books, :impression, :text
  end
end
