module Queries
  class FetchNote < Queries::BaseQuery
    type Types::NoteType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      Note.find(id)
    rescue ActiveRecord::RecordNotFound => _e
      GraphiQL::ExecutionError.new('Note does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphiQL::ExecutionError.new("Invalid attributes for #{e.record.class}: "\
        " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end