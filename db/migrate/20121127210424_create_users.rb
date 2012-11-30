class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :login
      t.string :password_digest
      t.string :password_hash
      t.string :password_salt
      t.references :role

      t.timestamps
    end
  end
end
