require 'caze'

module Status
  include Caze

  has_use_case :get_status, Status::GetStatus
end