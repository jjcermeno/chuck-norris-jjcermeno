require 'caze'

module Info
  include Caze

  has_use_case :get_info, Info::GetInfo
end