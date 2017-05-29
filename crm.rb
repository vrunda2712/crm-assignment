require_relative 'contact'

class CRM


  def initialize

  end

  def main_menu
    while true
     print_main_menu
     user_selected = gets.to_i
     call_option(user_selected)
    end
  end

  def print_main_menu
    puts
    puts '[1] Add a new contact'
    puts '[2] Modify an existing contact'
    puts '[3] Delete a contact'
    puts '[4] Display all the contacts'
    puts '[5] Search by attribute'
    puts '[6] Exit'
    puts 'Enter a number: '
  end

  def call_option(user_selected)
    case user_selected
      when 1 then add_new_contact
      when 2 then modify_existing_contact
      when 3 then delete_contact
      when 4 then display_all_contacts
      when 5 then search_by_attribute
      when 6 then exit
    end
  end

  def add_new_contact
    print 'Enter First Name: '
    first_name = gets.chomp

    print 'Enter Last Name: '
    last_name = gets.chomp

    print 'Enter Email Address: '
    email = gets.chomp

    print 'Enter a Note: '
    note = gets.chomp

    # Contact.create(first_name, last_name, email, note)

    contact = Contact.create(
      first_name: first_name,
      last_name: last_name,
      email: email,
      note: note
    )
  end

  def modify_existing_contact
    print 'Search contact to modify by - (first_name): '
    search = gets.chomp

    modify_contact = Contact.find_by("first_name" => search)

    print 'Enter attribute to change by - (first_name, last_name, email, note): '
    value = gets.chomp

    print 'Enter new value: '
    new_value = gets.chomp

    modify_contact.update(value => new_value)
  end

  def delete_contact
    print 'Enter contact ID to delete: '
    id = gets.to_i
    contact = Contact.find(id)
    contact.delete

    display_all_contacts
  end

  def display_all_contacts
    Contact.all.each do |contact|
      p "ID: #{contact.id} FIRST NAME: #{contact.first_name} LAST NAME: #{contact.last_name} EMAIL: #{contact.email} NOTE: #{contact.note}"
    end
  end

  def search_by_attribute
    print 'Enter attribute to search by - (first_name, last_name, email, note): '
    value = gets.chomp

    print 'Enter value to search for: '
    search = gets.chomp

    p Contact.find_by(value => search)
  end

  at_exit do
    ActiveRecord::Base.connection.close
  end

end


a_crm_app = CRM.new
a_crm_app.main_menu
