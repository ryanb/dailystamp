class AddScoreCacheToStamps < ActiveRecord::Migration
  def self.up
    add_column :stamps, :score_cache, :integer
  end

  def self.down
    remove_column :stamps, :score_cache
  end
end
