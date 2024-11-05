class CreatePublishers < ActiveRecord::Migration[7.2]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :rss_url
      t.string :website_url
      t.string :language

      t.timestamps
    end
  end
end
