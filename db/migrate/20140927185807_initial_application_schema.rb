class InitialApplicationSchema < ActiveRecord::Migration
  def change

    create_table :posts do |t|
      t.string :title
      t.string :state
      t.text :post_content
    end

    create_table :users do |t|
      t.string :full_name
      t.string :website
      t.string :twitter_handle
      t.string :slug
      t.text :bio
      t.integer :role_id
    end

    add_index :users, :role_id
  end
end
