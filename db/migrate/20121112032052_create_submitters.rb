class CreateSubmitters < ActiveRecord::Migration
  def change
    create_table :submitters do |t|
      t.string :name

      t.timestamps
    end
  end
end
