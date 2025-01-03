require 'rails_helper'

include SpecHelper
create_test_users


RSpec.describe 'Fonctions de gestion des étiquettes', type: :system do
  describe "fonction d'enregistrement" do
    context 'Lorsque les étiquettes sont enregistrées' do
      it 'Les étiquettes enregistrées sont affichées.' do
        login
        visit new_label_path
        fill_in 'label_name', with: 'label_name_test'
        click_on 'Enregistrer'
        expect(page).to have_current_path(labels_path)
        expect(page).to have_content("label_name_test") 
      end
    end
  end
  describe "fonction d'affichage de liste" do
    context "Si la transition se fait vers l'écran de synthèse" do
      it "La liste des étiquettes enregistrées s'affiche." do
        visit labels_path
        expect(page).to have_content("Liste des labels")
      end
    end
  end
end