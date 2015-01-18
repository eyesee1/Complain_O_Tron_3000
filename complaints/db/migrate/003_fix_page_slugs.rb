class FixPageSlugs < ActiveRecord::Migration
  def self.up
    add_index :pages, :slug, :unique => true
  end

  def self.down
    remove_index :pages, :slug
  end
end
