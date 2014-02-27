#describe '/api/events' do
#  before do
#    login_to_environment
#  end
#
#  context 'GET /api/events' do
#    it 'returns a list of events' do
#      events = Controls.events
#
#      expect(events).to match_format(event_format)
#    end
#  end
#
#  context 'GET /api/events?filter=ProductChangeEvent' do
#    it 'returns a list of events' do
#      events = Controls.events filter: 'ProductChangeEvent'
#
#      expect(events).to match_format(event_format)
#      expect(events.map(&:payload)).to match_format(product_change_format)
#    end
#  end
#
#  context 'GET /api/events?filter=SecurityControlChangeEvent' do
#    it 'returns a list of events' do
#      events = Controls.events filter: 'SecurityControlChangeEvent'
#      expected_payload_format = security_control_change_format
#
#      expect(events).to match_format(event_format)
#      expect(events.map(&:payload)).to match_format(expected_payload_format)
#
#      events.map(&:payload).each do |payload|
#        payload.keys.map(&:to_sym).each do |key|
#          expect(payload.send(key)).to match_format(expected_payload_format[key].last)
#        end
#      end
#    end
#  end
#
#  context 'GET /api/events?filter=SiteChangeEvent' do
#    it 'returns a list of events' do
#      events = Controls.events filter: 'SiteChangeEvent'
#      expected_payload_format = site_change_format
#
#      expect(events).to match_format(event_format)
#      expect(events.map(&:payload)).to match_format(expected_payload_format)
#
#      events.map(&:payload).each do |payload|
#        payload.keys.map(&:to_sym).each do |key|
#          expect(payload.send(key)).to match_format(expected_payload_format[key].last)
#        end
#      end
#    end
#  end
#end
