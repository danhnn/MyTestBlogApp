class AddFeatureToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :feature, :string
  end
end
