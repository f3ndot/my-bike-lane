collection :@violators
attributes :id, :license, :description, :organization_id

node :organization_name do |v|
  v.organization.name if v.organization.present?
end

node :organization_offences do |v|
  v.organization.violations.count if v.organization.present?
end