class AddEstOompletionDate < ActiveRecord::Migration
  def up
    add_column :services, :est_completion, :datetime
  end

  def down
    remove_column :services, :est_completion
  end
end
