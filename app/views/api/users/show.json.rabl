object false

child(:data) do
	child @user => :user do
		attributes :name, :last_name
	end
end


node(:status){ true }