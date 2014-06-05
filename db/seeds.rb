# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
UserType.create(name: 'Admin')
UserType.create(name: 'Consultant')
UserType.create(name: 'User')

TicketState.create(name:'Open')
TicketState.create(name:'Pending')
TicketState.create(name:'Pending/External')
TicketState.create(name:'Pending/User')
TicketState.create(name:'Closed')
TicketState.create(name:'Cancelled')

TicketPriority.create(name:'Critical')
TicketPriority.create(name:'High')
TicketPriority.create(name:'Medium')
TicketPriority.create(name:'Low')

IssueType.create(name:'Database')
IssueType.create(name:'Email')
IssueType.create(name:'FileServer')
IssueType.create(name:'GeneralSoftware')
IssueType.create(name:'Hardware')
IssueType.create(name:'LoginFailure')
IssueType.create(name:'Network')
IssueType.create(name:'OS-Reinstallation')
IssueType.create(name:'Printer')
IssueType.create(name:'Setup')
IssueType.create(name:'Uncategorized')

User.create(username: 'system', user_types_id: '3',first_name:'Helpdesk',last_name:'System',password:'foobar',password_confirmation:'foobar',email:'system@helpdesk-mmrc-k.org')
User.create(username: 'sipi', user_types_id: '2',first_name:'Sipitwi',last_name:'Nakitu',password:'foobar',password_confirmation:'foobar',email:'example1@railstutorial.org')
User.create(username: 'mmchome', user_types_id: '1',first_name:'Mirii',last_name:'Kinundu',password:'foobar',password_confirmation:'foobar',email:'mirimchome@gmail.com')
User.create(username: 'niwa', user_types_id: '3',first_name:'Newkim',last_name:'Kimbo',password:'foobar',password_confirmation:'foobar',email:'example3@railstutorial.org')
User.create(username: 'saphina', user_types_id: '1',first_name:'Nyanyinya',last_name:'Kachumbari',password:'foobar',password_confirmation: 'foobar',email:'example4@railstutorial.org')
