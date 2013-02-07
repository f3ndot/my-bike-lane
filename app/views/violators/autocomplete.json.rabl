collection :@violators
attributes :id, :license, :description, :organization_id

child :organization do |org|
  attributes :name, :description unless org.blank?
end