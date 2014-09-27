class AddMissingTimestamps < ActiveRecord::Migration
  def up
    [:posts, :users].each do |table|
      add_column table, :created_at, :datetime
      add_column table, :updated_at, :datetime

      execute "UPDATE #{table} SET created_at = NOW(), updated_at = NOW()"

      change_column table, :created_at, :datetime, :null => false
      change_column table, :updated_at, :datetime, :null => false
    end
  end
end
