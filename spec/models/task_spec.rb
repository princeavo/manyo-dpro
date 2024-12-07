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
        task = Task.create(title: 'Titre non vide', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
        expect(task).not_to be_invalid
      end
    end
  end
  
  describe 'fonction de recherche' do
    task = Task.create(title: 'test_title', content:'test_content', deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
    second_task = Task.create(title: 'Test name', content:'Test description', deadline_on: '2024-12-09',priority: :Faible, status: :Terminé)
    third_task = Task.create(title: 'third_task', content:'third_task description', deadline_on: '2024-12-19',priority: :Moyenne, status: :Démarré)
    context "Si une recherche floue d'un titre est effectuée à l'aide de la méthode scope" do
      it "Les tâches contenant des termes de recherche sont réduites." do
        # Utilisez les filtres to et not_to pour vérifier à la fois ce qui a été recherché et ce qui ne l'a pas été.
        # Vérifier le nombre de données de test récupérées.
        expect(Task.search_title('test_')).to include(task)
        expect(Task.search_title('itle')).not_to include(second_task)
        expect(Task.search_title('Test').count).to eq 1
      end
    end
    context "Si une recherche de statut est effectuée à l'aide de la méthode scope" do
      it "Les tâches qui correspondent exactement au statut sont réduites." do
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する

        expect(Task.search_status(:Démarré)).to include(third_task)
        expect(Task.search_status('Démarré')).not_to include(second_task)
        expect(Task.search_status('Terminé').count).to eq 1
      end
    end
    context "Recherche de titres et de statuts ambigus dans la méthode du champ d'application" do
      it "Les tâches dont le titre contient le terme de recherche et qui correspondent exactement au statut sont réduites." do
        # toとnot_toのマッチャを使って検索されたものとされなかったものの両方を確認する
        # 検索されたテストデータの数を確認する
        expect(Task.search_title('est_').search_status('Non démarré')).to include(task)
        expect(Task.search_title('itle').search_status('Terminé')).not_to include(second_task)
        expect(Task.search_title('name').search_status('Terminé').count).to eq 1
      end
    end
  end

end