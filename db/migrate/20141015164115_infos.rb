class Infos < ActiveRecord::Migration
  def change
    create_table :infos do |t|
      t.datetime :last_updated
    end 
  end
end
