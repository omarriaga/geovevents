object false

child(:data) do
	child @ranking => :reputation do
		attributes :total_events, :effective_events, :ranking, :rank_total, :last_date_event
		node(:last_date_event) { |r| if !r.last_date_event.nil?; r.last_date_event.strftime("%F") else; "No regístra" end}
	end

end


node(:status){ true }