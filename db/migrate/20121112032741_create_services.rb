class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.reference :service_type
      t.datetime :completion_date
      t.reference :owner
      t.reference :customer
      t.reference :submitter
      t.reference :status
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
