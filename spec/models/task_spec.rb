require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'If the task title is empty' do
      it 'Validation fails' do
        task = Task.create(title: '', content: 'Un contenu')
        expect(task).not_to be_valid
      end
    end
    context ' La validation échoue si la description de la tâche est vide' do
      it 'Validation fails' do
        task = Task.create(title: 'Titre non vide', content: '')
        expect(task).not_to be_valid
      end
    end
    context 'Si tout est bon' do
      it 'Validation fails' do
        task = Task.create(title: 'Titre non vide', content: 'nil')
        expect(task).not_to be_invalid
      end
    end
  end
end