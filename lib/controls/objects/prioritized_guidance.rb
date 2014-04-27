require 'controls/objects/guidance'

module Controls
  # A guidance subclass for when guidance is returned with priority.
  #
  # [todo] - this should include Comparable
  PrioritizedGuidance = Class.new(Guidance)
end
