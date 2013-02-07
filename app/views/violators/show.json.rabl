object :@violator
attributes :id, :license, :description

child :organization do |org|
  #attributes :id, :name, :description unless org.blank?
end