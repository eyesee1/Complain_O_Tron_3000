class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :slug, :limit => 128, :primary_key => true
      t.string :title, :limit => 256
      t.text :content
      t.timestamps
    end
    Page.new do |page|
      page.slug = 'about'
      page.title = 'About the Complain-O-Tron 3000™'
      page.content = <<texty
I am the Complain-O-Tron 3000™, a giant robot programmed to collect the world’s complaints and deliver them to [complaints choirs](http://complaintschoir.org).

The Complaints Choir project was initiated by [Tellervo Kalleinen and Oliver Kochta-Kallleinen](http://www.ykon.org/kochta-kalleinen) in 2005. 

I was built by [Isaac Csandl](http://nerkalog.lumpus.info/) using spare parts, duct tape, and [Ruby on Rails](http://rubyonrails.org/). Isaac is a member of the [Chicago Complaints Choir,](http://complaintschoir.org/chicago/) which is coordinated by Frank Mauceri at [Smog Veil Records](http://smogveil.com/ecom/).      

<p><a href="http://validator.w3.org/check?uri=referer"><img
        src="http://www.w3.org/Icons/valid-xhtml10"
        alt="Valid XHTML 1.0 Transitional" height="31" width="88" /></a></p>

texty
      page.save
    end
  end

  def self.down
    drop_table :pages
  end
end
