# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Task.create([
    { title: "Apple", content:"Lorem ipsum",priority: :low,status: 'Not Started', deadline_on:'2024-12-08'},
    { title: "Watermelon", content:"Lorem1",priority: :low ,status: 'Not Started', deadline_on:'2024-12-09'},
    { title: "Orange", content:"Lorem2" ,priority: :low,status: 'Not Started', deadline_on:'2024-12-10'},
    { title: "Pear", content:"Lorem3" ,priority: :low,status: 'Not Started', deadline_on:'2024-12-11'},
    { title: "Cherry", content:"Lorem4" ,priority: :low,status: 'Not Started', deadline_on:'2024-12-12'},
    { title: "Strawberry", content:"Lorem5" ,priority: :medium,status: 'In Process', deadline_on:'2024-12-13'},
    { title: "Nectarine", content:"Lorem6",priority: :medium,status: 'In Process' , deadline_on:'2024-12-14'},
    { title: "Grape", content:"Lorem7" ,priority: :medium,status: 'In Process', deadline_on:'2024-12-15'},
    { title: "Mango", content:"Lorem8" ,priority: :medium,status: 'In Process', deadline_on:'2024-12-16'},
    { title: "Blueberry", content:"Lorem9" ,priority: :medium,status: 'In Process', deadline_on:'2024-12-17'},
    { title: "Pomegranate", content:"Lorem 10" ,priority: :medium,status: 'In Process', deadline_on:'2024-12-18'},
    { title: "Plum", content:"Lorem 11" ,priority: :high,status: 'Complete', deadline_on:'2024-12-19'},
    { title: "Banana", content:"Lorem 12"  ,priority: :high,status: 'Complete', deadline_on:'2024-12-20'},
    { title: "Raspberry", content:"Lorem 13"  ,priority: :high,status: 'Complete',  deadline_on:'2024-12-21'},
    { title: "Mandarin", content:"Lorem 14"  ,priority: :high,status: 'Complete', deadline_on:'2024-12-22'},
    { title: "Jackfruit", content:"Lorem 15"  ,priority: :high,status: 'Complete', deadline_on:'2024-12-23'}
  ])