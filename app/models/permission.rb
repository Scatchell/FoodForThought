class Permission

	def self.to_ordered_hash *hashes
		ordered = ActiveSupport::OrderedHash.new

		hashes.each do |hash|
			hash.each { |key, value| ordered[key] = value }
		end
		ordered
	end

	ITEMS = Permission.to_ordered_hash(
		{:create => "Create Item"},
		{:show => "Show Item"},
		{:destroy => "Destroy Item"},
		{:index => "View All Items"}
	)

	ORDERS = Permission.to_ordered_hash(
		{:create => "Create Order"},
		{:show => "Show Order"},
		{:destroy => "Destroy Order"},
		{:destroy_all => "Destroy all Orders"},	
		{:index => "View All Orders"}
	)	
end