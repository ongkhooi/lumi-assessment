class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :main_image
      t.datetime :published_date
      t.string :link
      t.references :publisher, null: false, foreign_key: true

      t.timestamps
    end
    add_index :articles, :link
  end
end
