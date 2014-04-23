class AddMonthlyAmountToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :monthly_amount, :integer
  end
end
