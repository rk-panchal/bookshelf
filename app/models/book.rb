class Book < ApplicationRecord
	has_attached_file :cover_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :cover_image, content_type: /\Aimage\/.*\z/

  	# ThinkingSphinx::Index.define 'book'.to_sym, :with => :active_record

  	ThinkingSphinx::Index.define :book, :with => :active_record do
	  set_property :min_infix_len => 3
	end

	after_save ThinkingSphinx::RealTime.callback_for(:book)

end
