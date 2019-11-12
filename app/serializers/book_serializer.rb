#class BookSerializer < ActiveModel::Serializer::Resource
class BookSerializer < JSONAPI::Serializable::Resource

  # attributes :id,:title, :author, :isbn, :description, :language, :cover_image
end
