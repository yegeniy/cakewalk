class Point < ActiveRecord::Base

def self.up
create_table :points do |t|
t.column :lat, :decimal
t.column :lng, :decimal
t.column :found, :string, :limit=>100
t.column :left, :string, :limit=>100
end
execute("ALTER TABLE points MODIFY lat numeric(15,10);")
execute("ALTER TABLE points MODIFY lng numeric(15,10);")

def self.down
drop_table :points
end


end
