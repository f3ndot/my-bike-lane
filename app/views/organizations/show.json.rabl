object @organization
attributes :id, :name, :description, :violations

child(:violations) { attributes :id, :latitude, :longitude, :title }