module EventsHelper
  def event_fee_type
    Event::FEE_TYPE.map{|t| [t[1],t[0]]}
  end
end
