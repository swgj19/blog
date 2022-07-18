class AddPostIdToOpinions < ActiveRecord::Migration[6.1]
  def change
    add_column :opinions, :post_id, :integer
  end
end
