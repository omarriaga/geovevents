object false

child (:data) do
	child @token => :session do
		attributes :auth_token, :expire_time
		node(:expire_time) { |auth| auth.expire_time.strftime("%F %r") }
	end 
end

node(:status) { true }