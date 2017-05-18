# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

elen = User.create(name: 'elen', pass: 'pass', token: 'token')
almin = User.create(name: 'almin', pass: 'pass', token: 'token')
mikasa = User.create(name: 'mikasa', pass: 'pass', token: 'token')

ap1 = AccessPoint.create(ssid: '1号館', bssid: 'bssid1')
ap2 = AccessPoint.create(ssid: '2号館', bssid: 'bssid2')
ap3 = AccessPoint.create(ssid: '3号館', bssid: 'bssid3')
ap4 = AccessPoint.create(ssid: '4号館', bssid: 'bssid4')
ap5 = AccessPoint.create(ssid: '5号館', bssid: 'bssid5')
cpsf11 = AccessPoint.create(ssid: '岩井研 11F', bssid: 'bssid6')
cpsf14 = AccessPoint.create(ssid: '岩井研 14F', bssid: 'bssid7')

ap1.follows.create(user: elen)
ap2.follows.create(user: elen)
ap5.follows.create(user: elen)
cpsf11.follows.create(user: elen)
cpsf14.follows.create(user: elen)
ap1.follows.create(user: mikasa)
cpsf11.follows.create(user: mikasa)
cpsf11.follows.create(user: almin)
cpsf14.follows.create(user: almin)


ap1.checkins.create(user: elen)
ap2.checkins.create(user: elen)
ap5.checkins.create(user: elen)
cpsf11.checkins.create(user: elen)
ap1.checkins.create(user: mikasa)
cpsf11.checkins.create(user: mikasa)
cpsf11.checkins.create(user: almin)
cpsf14.checkins.create(user: almin)
