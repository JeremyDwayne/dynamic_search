module DynamicSearch
  extend ActiveSupport::Concern
  # scope :status, -> (status) { where status: status }

  module ClassMethods

    def search(search, columns = nil)
      if search.present?
        # sanitize_sql is used over sanitize because sanitize removes html
        # tags but because we are doing sql calls we need to sanitize the
        # string for that. I have not included an escape charecter so this
        # might limit search but is safer.
        columns ||= self.column_names.reject{|e| e.end_with?("_id")} - ["id", "created_at", "updated_at"]
        i = 0
        params = Hash.new
        sql = Array.new
        for s in search.split
          i += 1
          params["first#{i}".to_sym] = "#{sanitize_sql(s)}%"
          params["nth#{i}".to_sym] = "% #{sanitize_sql(s)}%"
          # Search everything except the id columns
          statements = Array.new
          for column in columns
            statements << "#{column} LIKE :first#{i}"
            statements << "#{column} LIKE :nth#{i}"
          end
          sql << "(#{statements.join(" OR ")})"
        end
        self.where(sql.join(" AND "), params)
      else
        self.all
      end
    end

  end
end
