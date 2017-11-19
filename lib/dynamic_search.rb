module DynamicSearch
  extend ActiveSupport::Concern
	# scope :status, -> (status) { where status: status }

	module ClassMethods
		def search(search)
			if search && !search.empty?
				# sanitize_sql is used over sanitize because sanitize removes html
				# tags but because we are doing sql calls we need to sanitize the
				# string for that.
				results = self.all
				for part in search.split(/\s+/)
					part = "#{sanitize_sql(part)}%"
					word = "% #{sanitize_sql(part)}%"
                    results = results.search_params(part).or(results.search_params(word))
				end
				return results.uniq
			else
				self.all
			end
		end
	end
end
