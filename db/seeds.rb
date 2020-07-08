# t.string "name"
def create_companies
  8.times do 
    Company.create(name: Faker::Company.unique.name, username: Faker::Alphanumeric.alpha(number: 6), password: Faker::Alphanumeric.alphanumeric(number: 6))
  end
end

# t.string "name"
def create_owners
  8.times do
    Owner.create(name: Faker::Name.unique.name)
  end
end

# t.integer "company_id"
# t.integer "owner_id"
# t.string "location"
# t.integer "profit"
def create_franchises
  8.times do 
    Franchise.create(company_id: Company.all.sample.id, owner_id: Owner.all.sample.id, location: Faker::Address.city, profit: Faker::Number.within(range: -1000.00..1000000.00))
  end
end

create_companies

create_owners

create_franchises