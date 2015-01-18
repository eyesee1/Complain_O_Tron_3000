class DeleteMyCreatedCol < ActiveRecord::Migration
  # didn't realize that scaffold would add its own field like this. such a newbie.
  def self.up
    remove_column :complaints, :created
  end

  def self.down
    add_column :complaints, :created, :datetime
  end
end
