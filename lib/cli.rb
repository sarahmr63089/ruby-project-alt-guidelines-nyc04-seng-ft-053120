class CLI
  def get_company
    puts "Please enter your company name"
    company_name = gets.strip.to_s
    company = Company.find_by(name: company_name)
  end
  
  def display_franchises(company)
    company.franchises.select { |franchise| puts "Franchise #{franchise.id} in #{franchise.location}" }
  end

  def valid_franchise_choice(company, id)
    # to be a valid choice, the franchise must be one owned by the company
    if !company.franchises.exists?(id)
      puts "Please select an id from the list above next time or find an owner to purchase a franchise!"
      # return to menu
    end
  end
  
  def change_franchise_owner(company)
    # get company name and display franchises
    display_franchises(company)
    # ask which franchise to change owner
    puts "Please enter the id number for the franchise whose ownership has changed."
    # get input
    id = gets.strip
    # is this a valid choice?
    valid_franchise_choice(company, id)
    # ask for owner name
    puts "Please enter the name of the new owner."
    # get input
    new_owner = gets.strip.to_s
    # update owner
    franchise = Franchise.where(id: id).update(owner_id: Owner.find_by(name: new_owner).id)
    # display change
    franchise.select { |franchise| puts "Franchise #{franchise.id} has new owner #{franchise.owner.name}." }
  end
  
  def delete_franchise(company)
    # get company name and display franchises
    display_franchises(company)
    # ask which franchise
    puts "Please enter the id number for the franchise you would like to close."
    # get franchise id input
    id = gets.strip
    # valid choice?
    valid_franchise_choice(company, id)
    # delete the franchise they choose
    Franchise.find(id).destroy
  end
  
  def franchise_with_highest_profit
    big_earner = Franchise.all.max_by { |franchise| franchise.profit }
    puts "Franchise #{big_earner.id} has the highest profit, having earned #{big_earner.profit}. It is owned by #{big_earner.owner.name} and the company #{big_earner.company.name}."
  end
end