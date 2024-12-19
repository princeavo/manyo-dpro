require 'rails_helper'

RSpec.describe User, type: :model do
  describe "enregistrement ou de la modification d'un compte" do
    context 'Les messages de validation' do
      it "Si le nom n'est pas entré" do
        user = User.create(name: nil, email: 'avohouprince10@gmail.com',password: 'password',password_confirmation: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:name]).to eq ['Veuillez entrer votre nom']
      end
    end
    context 'Les messages de validation' do
      it "Si l'adresse e-mail n'est pas renseignée" do
        user = User.create(name: "nil", email: nil,password: 'password',password_confirmation: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("Veuillez entrer votre adresse e-mail")
      end
    end
    context 'Les messages de validation' do
      it "Si l'adresse e-mail est déjà utilisée" do
        User.create(name: 'Name1', email: 'avohouprince@example.com',password: 'password', password_confirmation: 'password',admin: :false)
        user = User.create(name: 'Name1', email: 'avohouprince@example.com',password: 'password', password_confirmation: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:email]).to include("L'adresse e-mail est déjà utilisée")
      end
    end
    context 'Les messages de validation' do
      it "Si le mot de passe n'est pas saisi" do
        user = User.create(name: 'Name1', email: 'exemple1@example.com',password: nil, password_confirmation: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("Veuillez entrer votre mot de passe")
      end
    end
    context 'Les messages de validation' do
      it "Si votre mot de passe comporte moins de 6 caractères" do
        user = User.create(name: 'Name1', email: 'exemple1@example.com',password: "nil", password_confirmation: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:password]).to include("Veuillez saisir un mot de passe d'au moins 6 caractères.")
      end
    end
    context 'Les messages de validation' do
      it "Si le mot de passe et le mot de passe (confirmation) ne correspondent pas" do
        user = User.create(name: 'Name1', email: 'exemple1@example.com',password: "nilerdtfgyuh", password_confirmation: 'password')
        expect(user).to_not be_valid
        expect(user.errors[:password_confirmation]).to include("Le mot de passe (confirmer) et la saisie du mot de passe ne correspondent pas")
      end
    end
    context "Si le nom de l'utilisateur a une valeur, l'adresse électronique est une valeur inutilisée et le mot de passe comporte au moins 6 caractères." do
      it 'Validation réussie' do
        user = User.create(name: 'Name1', email: 'exemple1@example.com',password: "nilerdtfgyuh", password_confirmation: 'nilerdtfgyuh',admin: :true)
        expect(user).to be_valid
      end
    end
  end
end
