# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create([{
	email: 'administrador@aneib.cl',
	password: 'administrador123',
	name: 'Administrador',
	nickname: 'Admin',
	category: 1, 
},
{
	email: 'delegado@aneib.cl',
	password: 'delegado123',
	name: 'Delegado',
	nickname: 'Delegado',
	category: 2, 
},
{
	email: 'socio@aneib.cl',
	password: 'socio123',
	name: 'Socio',
	nickname: 'Socio',
	category: 3, 
},
{
	email: 'media@aneib.cl',
	password: 'media123',
	name: 'Media Partner',
	nickname: 'Media',
	category: 4, 
}])