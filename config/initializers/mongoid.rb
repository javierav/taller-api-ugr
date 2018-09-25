module BSON
  class ObjectId
    def as_json(*)
      to_s
    end

    alias to_json as_json
  end
end
