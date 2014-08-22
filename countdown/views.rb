require File.join(File.dirname(__FILE__), 'controllers.rb')

class CountdownClockView

  def initialize(controller)
    # TODO: Write initializer
    @controller = controller
    @visible = false
  end

  def set_visibility(visible)
    @visible = visible
  end

  def visible?
    return @visible
  end

end
