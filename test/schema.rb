ActiveRecord::Schema.define(:version => 1) do
  create_table :users do |t|
    t.boolean :active
    t.string :email, :crypted_password, :salt
    t.datetime :last_loggged_in_at
    t.timestamps
  end
end