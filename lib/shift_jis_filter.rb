require "nkf"

class ShiftJisFilter
  def after(controller)
    controller.response.body = NKF.nkf('-m0 -x -Ws', controller.response.body)
    unless controller.response.body.blank?
      controller.response.charset = "Shift_JIS"
    end
  end
end
