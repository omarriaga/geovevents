object false

node :errors do
  @errors.map { |data| data }
end

node(:status) { false }