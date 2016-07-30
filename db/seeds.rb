# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#	 cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#	 Mayor.create(name: 'Emanuel', city: cities.first)
User.create([{
	email: 'administrador@aneib.cl',
	password: 'aneib123',
	name: 'Administrador',
	nickname: 'Admin',
	category: 1,
	status: 2,
	confirmed_at: Time.now
},
{
	email: 'delegado@aneib.cl',
	password: 'aneib123',
	name: 'Delegado',
	nickname: 'Delegado',
	category: 2, 
	status: 1,
	confirmed_at: Time.now
},
{
	email: 'socio@aneib.cl',
	password: 'aneib123',
	name: 'Socio',
	nickname: 'Socio',
	category: 3,
	status: 1,
	confirmed_at: Time.now
},
{
	email: 'media@aneib.cl',
	password: 'aneib123',
	name: 'Media Partner',
	nickname: 'Media',
	category: 4, 
	status: 1,
	confirmed_at: Time.now
}])