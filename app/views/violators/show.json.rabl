object @violator
attributes :id, :license, :description, :violations, :organization

child(:violations) { attributes :id, :title, :created_at, :latitude, :longitude }
child(:organization => :organization) { attributes :id, :name, :description }