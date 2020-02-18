ApiUser.destroy_all
Meetinginterval.destroy_all
Programminglanguage.destroy_all
Wish.destroy_all
Experience.destroy_all
users = ApiUser.create!([
                {first_name: 'Mary', last_name: 'Black', city: 'Dublin', mentor: true, mentee: true, email: 'Test_email_1@example.com', password_digest: 'password1', username: 'user1'}, 
              {first_name: 'Bob', last_name: 'Dylan', city: 'New York', mentor: true, mentee: true, email: 'Test_email_2@example.com', password_digest: 'password2', username: 'user2'}, 
               {first_name: 'Jane', last_name: 'Smith', city: 'Edinburgh', mentor: false, mentee: true, email: 'Test_email3@example.com', password_digest: 'password3', username: 'user3' }
               ])
weekly_meet = Meetinginterval.create!(interval: 'weekly')
daily_meet =  Meetinginterval.create!(interval: 'daily')
python_lang = Programminglanguage.create!(language: 'python')
scala_lang =  Programminglanguage.create!(language: 'SCALA')

users.first.wishes.create!([{available_offline: false, available_online: true, goal: 'Code real good', programminglanguage: python_lang, meetinginterval: weekly_meet}])
users.second.wishes.create!([{available_offline: true, available_online: true, goal: 'Get smarter', programminglanguage: python_lang, meetinginterval: daily_meet}])
users.first.wishes.create!([{available_offline: false, available_online: true, goal: 'Code really well in Python', programminglanguage: scala_lang, meetinginterval: weekly_meet}])

users.second.experiences.create!([{available_offline: true, available_online: true, qualification: 'Help students learn', programminglanguage: python_lang, meetinginterval: daily_meet}])

p "Created #{ApiUser.count} api_user entries"
p "Created #{Meetinginterval.count} meeting interval entries"
p "Created #{Programminglanguage.count} programming language entries"
p "Created #{Wish.count} wish entries"
p "Created #{Experience.count} experience entries"

