class AddGoalToStamps < ActiveRecord::Migration
  def self.up
    add_column :stamps, :goal_score, :integer
    add_column :stamps, :goal_reward, :text
    Stamp.update_all("goal_score = 100")
  end

  def self.down
    remove_column :stamps, :goal_reward
    remove_column :stamps, :goal_score
  end
end
