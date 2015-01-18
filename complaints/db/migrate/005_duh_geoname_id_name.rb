class DuhGeonameIdName < ActiveRecord::Migration
  # DUH. let's get that name right
  def self.up
    rename_column :complaints, :geonamesId, :geonameId
  end

  def self.down
    rename_column :complaints, :geonameId, :geonamesId
  end
end
