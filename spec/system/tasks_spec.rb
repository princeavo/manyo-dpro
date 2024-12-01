require 'rails_helper'

RSpec.describe 'Fonction de gestion des tâches', type: :system do
      describe 'Nouvelle fonction de création' do
        context 'Lors de la création de nouvelle tâche' do
          it 'La tâche créée saffiche' do
            visit new_task_path
            fill_in 'Titre', with: 'title_test'
            fill_in 'Contenu', with: 'content_test'
            click_on 'Créer une tâche'
            expect(page).to have_content 'title_test'

          end
        end
      end

      describe 'Fonction daffichage trié' do
        context 'Si les tâches sont classées par ordre décroissant de date et de heure de création' do
          it 'Les nouvelles tâches apparaissent en haut de la liste.' do
            Task.create(title: 'task1', content: 'description1')
            Task.create( title: 'task2', content: 'description2')
            Task.create(title: 'task3', content: 'description3')
            Task.create(title: 'task4', content: 'description4') 
            visit tasks_path
            tasks_list = all('td')
            expect(tasks_list[0]).to have_content 'task4'
          end
        end
      end
      
end