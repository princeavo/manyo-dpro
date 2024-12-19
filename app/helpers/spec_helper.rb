module SpecHelper

  require 'faker'
  def create_test_users
    User.create(name: 'Name1', email: 'exemple1@example.com',password: "nilerdtfgyuh", password_confirmation: 'nilerdtfgyuh',admin: :false)
    User.create(name: 'Name1', email: 'admin@admin.com',password: "nilerdtfgyuh", password_confirmation: 'nilerdtfgyuh',admin: :true)
  end
  def login
    visit(login_path)
    fill_in 'email', with: 'exemple1@example.com'
    fill_in "password",	with: "nilerdtfgyuh" 
    find('input[value="Se connecter"]').click
  end
  def login_admin
    visit(login_path)
    fill_in 'email', with: 'admin@admin.com'
    fill_in "password",	with: "nilerdtfgyuh" 
    find('input[value="Se connecter"]').click
  end
  def admin_add_user
    visit(admin_users_path)
    find("#add-user").click
    fill_in 'user_name', with: 'valueRandomdfghjlk_esdtrfyguh_tgfhbjkn'
    fill_in 'user_email', with: 'dcfv@tdgfrh.random'
    fill_in 'user_password', with: 'azerty@azerty.com'
    fill_in 'user_password_confirmation', with: 'azerty@azerty.com'
    find("#user_admin").click
    click_on 'create-user'
  end
  def create_task
    Task.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      content: Faker::Lorem::paragraph(sentence_count: 2),
      deadline_on: Faker::Date.forward(days: 14),
      priority: [:low, :medium, :high].sample,
      status: ["Not Started", "In Process", :Complete].sample,
      user: user
    )
  end
  def create_many_tasks
    20.times do
      create_task
    end
  end
  def user
    return User.where(email: 'exemple1@example.com').first
  end
end
