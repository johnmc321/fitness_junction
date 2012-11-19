class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string  #has to be password_digest in ordeer for has_secure_password function to work
  end
end
