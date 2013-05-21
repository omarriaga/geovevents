object false

child (:data) do
	child @user => :confirmation do
		attributes :confirmation_token => :token
		node(:token_expires) { |user| user.confirmation_expires.strftime("%F %r") }
	end
end

node(:status) { true }