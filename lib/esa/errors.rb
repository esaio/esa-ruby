module Esa
  class EsaError < StandardError; end
  class TeamNotSpecifiedError < EsaError; end
  class MissingContentTypeError < EsaError; end
  class RemoteURLNotAvailableError < EsaError; end
end
