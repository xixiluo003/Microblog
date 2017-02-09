class CreateUsersTable < ActiveRecord::Migration
    def change
        create_table :users do |t|
            t.string :username
            t.string :password
            t.string :firstname
            t.string :lastname
            t.string :usertype
            t.string :email
            t.integer :rating
            t.datetime :created_at
        end
    end
end
