module Controls
  class Client
    # A module to encapsulate API methods related to assessments
    # @since API v1.0
    # @version v1.0.0
    module Assessments
      # @!group Assessment Methods

      # @return [Array<Hash>] an array of assessment hashes
      def assessments(assessment_id = nil)
        if assessment_id
          get "/assessments/#{assessment_id}"
        else
          get '/assessments'
        end
      end

      # @!endgroup
    end
  end
end
