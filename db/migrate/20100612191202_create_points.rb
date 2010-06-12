class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
	
     t.column :name, :string, :limit=>50
	t.column :address, :string, :limit=>100
	t.column :address2, :string, :limit=>100
	t.column :city, :string, :limit=>50
	t.column :state, :string, :limit=>20
	t.column :zip, :string, :limit=>9
	t.column :lat, :string, :limit=>20
	t.column :lng, :string, :limit=>20
	end	
	

   
  end
  

  def self.down
    drop_table :points
  end
end
