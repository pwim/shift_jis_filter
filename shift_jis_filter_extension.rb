require 'shift_jis_filter'
class ShiftJisFilterExtension < Radiant::Extension
  version "0.1"
  description "Replacement of UTF-8 with Shift_JIS"
  url "http://github.com/pwim/shift_jis_filter"

  def activate
    SiteController.send :after_filter, ShiftJisFilter.new
  end
end
