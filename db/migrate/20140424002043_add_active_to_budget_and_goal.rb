class AddActiveToBudgetAndGoal < ActiveRecord::Migration
  def change
    add_column :budgets, :is_active, :boolean, default: true
    add_column :goals, :is_active, :boolean, default: true
  end
end
