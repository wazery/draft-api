user1 = User.create(email: 'wazery@ubuntu.com', password: '123456789')

project1 = Project.create(name: 'TopCoder', scale: '1', unit: 'pt', color_format: 'Hex')

team1 = Team.create(project_id: project1.id)
Membership.create(user_id: user1.id, team_id: team1.id)

project2 = Project.create(name: 'Apple Pay', scale: '2', unit: 'px', color_format: 'HRGBA')

team2 = Team.create(project_id: project2.id)
Membership.create(user_id: user1.id, team_id: team2.id)

p 'Seeding Finished!'
