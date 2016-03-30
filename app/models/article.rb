class Article < ActiveRecord::Base
	has_many :comments ,dependent: :destroy
	has_many :tags ,through: :taggings
	has_many :taggings
	belongs_to :user
	has_attached_file :photo, :styles => { :small => "150x150",thumb: "100x100",medium: "300X300",large: "1900x1200"}
    validates_attachment_size :photo, :less_than => 5.megabytes
    validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
	def tag_list

       self.tags.collect do |c|
        c.name
      end.join(",")
      
   end
   def tag_list=(tags_string)
  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq

  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  self.tags = new_or_found_tags

end
 def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("title like ?", "%#{query}%") 
  end
end
