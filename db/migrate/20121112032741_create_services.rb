class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :service_type
      t.datetime :completion_date
      t.references :owner
      t.references :customer
      t.references :submitter
      t.references :status
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
