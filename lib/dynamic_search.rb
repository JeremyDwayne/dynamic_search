module DynamicSearch
  extend ActiveSupport::Concern
  ##
  # This module provides the parent search method which will be available
  # to any model which includes DynamicSearch `include DynamicSearch`

  module ClassMethods

    def search(search, columns = nil)
      ##
      # The search method will search all columns except foreign keys, id,
      # and timestamps. The columns searched can be overwritten in an individual model
      # by using the following syntax:
      # 
      # def search(search)
      #   super(search, ["array", "of", "columns"])
      # end

      if search.present?
        columns ||= self.column_names.reject{|e| e.end_with?("_id")} - ["id", "created_at", "updated_at"]
        params = {}
        sql = []

        search.split(' ').each_with_index do |s, i|
          params["nth#{i}".to_sym] = "%#{sanitize_sql(s)}%"

          statements = []
          for column in columns
            statements << "UPPER(CAST(#{column} AS text)) LIKE UPPER(:nth#{i})"
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
