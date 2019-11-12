ThinkingSphinx::Index.define :book, :with => :active_record do
  # fields
	indexes title, :sortable => true
    indexes author
    indexes description
end