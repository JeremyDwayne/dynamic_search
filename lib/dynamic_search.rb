module DynamicSearch
  extend ActiveSupport::Concern

  module ClassMethods

    def search(search, columns = nil)
      if search.present?
        columns ||= self.column_names.reject{|e| e.end_with?("_id")} - ["id", "created_at", "updated_at"]
        params = {}
        sql = []

        search.split.each_with_index do |s, i|
          params["first#{i}".to_sym] = "#{sanitize_sql(s)}%"
          params["nth#{i}".to_sym] = "% #{sanitize_sql(s)}%"

          statements = []
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
