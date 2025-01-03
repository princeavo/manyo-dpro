require 'rails_helper'

RSpec.describe "Fonction du modèle d'étiquetage", type: :model do
  describe 'Tests de validation.' do
    context "Si le nom de l'étiquette est une lettre vide" do
      it 'La validation échoue.' do
        label = Label.create(name: '')
        expect(label).not_to be_valid
      end
    end

    context "Si le nom de l'étiquette a une valeur" do
      it 'Validation réussie' do
        label = Label.create(name: 'label = Label.create(name: '')expect(label).not_to be_valid')
        expect(label).not_to be_invalid
      end
    end
  end
end