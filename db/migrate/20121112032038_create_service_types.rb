class CreateServiceTypes < ActiveRecord::Migration
  def change
    create_table :service_types do |t|
      t.string :name
      t.string :note

      t.timestamps
    end
  end
end
