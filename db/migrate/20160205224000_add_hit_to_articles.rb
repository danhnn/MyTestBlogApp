class AddHitToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :hit, :integer
  end
end
