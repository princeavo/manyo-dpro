require 'rails_helper'


User.create(name: 'Name1', email: 'exemple1@example.com',password: "nilerdtfgyuh", password_confirmation: 'nilerdtfgyuh',admin: :false)
User.create(name: 'Name1', email: 'admin@admin.com',password: "nilerdtfgyuh", password_confirmation: 'nilerdtfgyuh',admin: :true)


RSpec.describe 'fonctions de gestion des utilisateurs', type: :system do
  describe "fonction d'enregistrement" do
    context 'Si un utilisateur est enregistré' do
      it "Passage à l'écran de la liste des tâches." do
        visit new_user_path
        fill_in "user_name",	with: "sometext" 
        fill_in 'user_email', with: 'email@sometext.com'
        fill_in "user_password",	with: "sometext" 
        fill_in 'user_password_confirmation', with: 'sometext'
        click_button 'create-user'
        expect(page).to have_current_path(tasks_path)
      end
    end
    context "Si vous avez accédé à l'écran Liste des tâches sans vous connecter" do
      it "Vous êtes redirigé vers l'écran de connexion et le message « Veuillez vous connecter » s'affiche." do
        visit(tasks_path)
        expect(page).to have_current_path(login_path)
        expect(page).to have_content("Veuillez vous connecter")
      end
    end
  end

  describe 'Fonction de connexion' do
    context "Lorsque l'on est connecté en tant qu'utilisateur enregistré." do
      it "Vous serez redirigé vers l'écran de la liste des tâches et le message « 	Connecté » s'affichera." do
        login
        expect(page).to have_current_path(tasks_path)
        expect(page).to have_content("Connecté")
      end
      it 'Accès à votre propre écran de détail.' do
        login
        visit(show_profile_path)
        expect(page).to have_current_path(show_profile_path)
      end
      it "En accédant à l'écran de détails d'une autre personne, vous accédez à l'écran de la liste des tâches." do
      end
      it "Lors de la déconnexion, l'utilisateur est ramené à l'écran de connexion et le message « Déconnecté » s'affiche." do
        login
        find('input[value="Déconnexion"]').click
        expect(page).to have_current_path(login_path)
        expect(page).to have_content("Déconnecté") 
      end
    end
  end

  describe "Fonctions de l'administrateur" do
    context "Lorsque l'administrateur se connecte." do
      it "Accès à l'écran de la liste des utilisateurs." do
        login_admin
        visit(admin_users_path)
        expect(page).to  have_current_path(admin_users_path)
      end
      it 'Peut enregistrer des administrateurs.' do
        login_admin
        admin_add_user
        expect(page).to  have_current_path(admin_users_path)
        expect(page).to  have_content("J'ai enregistré un compte.")
        expect(page).to  have_content("valueRandomdfghjlk_esdtrfyguh_tgfhbjkn")
        expect(page).to  have_content("dcfv@tdgfrh.random")
      end
      it "Accès à l'écran des détails de l'utilisateur." do
        login_admin
        visit(admin_users_path)
        first_show_link = find("td a.show-user", match: :first)
        url = first_show_link[:href]
        match = url.match(/(\d+)$/)
        first_show_link.click
        expect(page).to  have_current_path(admin_user_path(id: match[1]))
      end
      it "Vous pouvez modifier d'autres utilisateurs que vous-même à partir de l'écran de modification de l'utilisateur." do
        login_admin
        admin_add_user
        visit (edit_admin_user_path(User.where(email: "dcfv@tdgfrh.random").first))
        fill_in 'user_name', with: 'updated_name'
        fill_in 'user_email', with: 'updated_email@newemail.com'
        click_on 'update-user'
        expect(page).to  have_current_path(admin_users_path)
        expect(page).to  have_content("updated_email@newemail.com")
      end
      it 'Les utilisateurs peuvent être supprimés.' do
        login_admin
        admin_add_user
        expect(page).to  have_current_path(admin_users_path)
        expect(page).to  have_content("valueRandomdfghjlk_esdtrfyguh_tgfhbjkn")
        visit(admin_users_path)
        find('a[href="' + edit_admin_user_path(User.where(email: "dcfv@tdgfrh.random").first) + '"]').click
        expect(page).not_to  have_content("valueRandomdfghjlk_esdtrfyguh_tgfhbjkn")
      end
    end
    context "Lorsqu'un utilisateur général accède à l'écran de la liste des utilisateurs" do
      it "Passage à l'écran de la liste des tâches avec le message d'erreur « Seul l'administrateur peut y accéder. »." do
        login
        visit(admin_users_path)
        expect(page).to  have_current_path(tasks_path)
        expect(page).to have_content("Seul l'administrateur peut y accéder.")
      end
    end
  end
end



private 
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