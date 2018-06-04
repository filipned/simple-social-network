module Simple
  module Entities
    class Post < Grape::Entity
      format_with(:iso_timestamp) { |dt| dt.iso8601 }

      expose :id
      expose :title
      expose :body

      with_options(format_with: :iso_timestamp) do
        expose :created_at
        expose :updated_at
      end
    end
  end
end