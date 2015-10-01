module Esa
  class EsaError < StandardError; end
  class TeamNotSpecifiedError < EsaError; end
  class MissingContentTypeError < EsaError; end
end
