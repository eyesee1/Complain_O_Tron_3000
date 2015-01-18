class AddPositionToFaq < ActiveRecord::Migration
  def self.up
    add_column :faqs, :position, :integer
    Faq.new do |f|
      f.question = "How do I join or start a Complaints Choir?"
      f.answer = "Please visit the [Complaints Choir Official Site](http://complaintschoir.org) for more information."
      f.position = 1
      f.save
    end
  end

  def self.down
    remove_column :faqs, :position
  end
end
