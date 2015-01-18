class CreateInquiries < ActiveRecord::Migration
  def self.up
    create_table :inquiries do |t|
      t.string :from
      t.string :email
      t.string :phone
      t.string :what
      t.text :message
      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :inquiries
  end
end
