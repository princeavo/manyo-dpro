require 'rails_helper'

RSpec.describe 'Fonction de gestion des tâches', type: :system do
      describe 'Nouvelle fonction de création' do
        context 'Lors de la création de nouvelle tâche' do
          it 'La tâche créée saffiche' do
            visit new_task_path
            fill_in 'Titre', with: 'title_test_new'
            fill_in 'Contenu', with: 'content_test'
            fill_in 'Deadline on', with: '08/12/2024'
            select("Moyenne", from: "task_priority")
            select("Terminé", from: "Status")
            click_on 'Créer une tâche'
            expect(page).to have_content 'title_test_new'

          end
        end
      end

      describe 'Fonction daffichage trié' do
        context 'Si les tâches sont classées par ordre décroissant de date et de heure de création' do
          it 'Les nouvelles tâches apparaissent en haut de la liste.' do
            Task.delete_all
            Task.create(title: 'Titre1', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre2', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre3', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Autre test', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            visit tasks_path
            tasks_list = all('td')
            expect(tasks_list[0]).to have_content 'Autre test'
          end
        end
      end
  
      describe 'fonction de tri' do
        context 'Si vous cliquez sur le lien Date de fin' do
          it "Une liste de tâches triées par ordre croissant de date d'échéance s'affiche." do
            #Utilisez la méthode all pour vérifier l'ordre de plusieurs données de test.
            Task.delete_all
            Task.create(title: 'Titre1', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre2', content: 'nil',deadline_on: '2024-12-09',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre3', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Autre test', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Non démarré')
            visit tasks_path
            click_on 'Date de fin'
            tasks_list = all('td')
            expect(tasks_list[0]).to have_content 'Titre1'
          end
        end
        context 'Si vous cliquez sur le lien Priorité' do
          it "Une liste de tâches classées par priorité s'affiche." do
            # Utilisez la méthode all pour vérifier l'ordre de plusieurs données de test.
            Task.delete_all
            Task.create(title: 'priorité cliquez', content: 'nil',deadline_on: '2024-12-08',priority: :Elevée, status: 'Non démarré')
            Task.create(title: 'classées cliquez', content: 'nil',deadline_on: '2024-12-09',priority: :Moyenne, status: 'Non démarré')
            Task.create(title: 'tâches cliquez', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')
            visit tasks_path
            click_on 'Priorité'
            tasks_list = all('td')
            expect(tasks_list[0]).to have_content 'priorité cliquez'
          end
        end
      end
      describe 'fonction de recherche' do
        context "Lorsqu'une recherche floue est effectuée sur le titre" do
          it "Seules les tâches contenant des termes de recherche sont affichées." do
            Task.delete_all
            # Utilisez les fonctions to et not_to pour vérifier ce qui est affiché et ce qui ne l'est pas.
            Task.create(title: 'priorité cliquez', content: 'nil',deadline_on: '2024-12-08',priority: :Elevée, status: 'Non démarré')
            Task.create(title: 'classées cliquez', content: 'nil',deadline_on: '2024-12-09',priority: :Moyenne, status: 'Non démarré')
            Task.create(title: 'tâches clic', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')

            Task.create(title: 'Titre1', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre2', content: 'nil',deadline_on: '2024-12-09',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre3', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Autre test', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Non démarré')

            visit tasks_path

            fill_in 'title', with: 'cli'
            click_on 'Rechercher'
            tasks_list = all('td')
            expect(tasks_list.count).to eq 3*9
            expect(tasks_list[0]).to have_content 'priorité cliquez'
            expect(tasks_list[9]).to have_content 'classées cliquez'
            expect(tasks_list[18]).not_to have_content 'Autre test'
          end
        end
        context 'Recherche par statut.' do
          it "Seules les tâches correspondant au statut recherché sont affichées." do
            Task.delete_all
            # Utilisez les fonctions to et not_to pour vérifier ce qui est affiché et ce qui ne l'est pas.
            Task.create(title: 'priorité cliquez', content: 'nil',deadline_on: '2024-12-08',priority: :Elevée, status: 'Non démarré')
            Task.create(title: 'classées cliquez', content: 'nil',deadline_on: '2024-12-09',priority: :Moyenne, status: 'Non démarré')
            Task.create(title: 'tâches clic', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')

            Task.create(title: 'Titre1', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre2', content: 'nil',deadline_on: '2024-12-09',priority: :Faible, status: 'Terminé')
            Task.create(title: 'Titre3', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Autre test', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Terminé')
            Task.create(title: 'Autre', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Démarré')
            Task.create(title: 'Autre1', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Démarré')

            visit tasks_path

            select("Terminé", from: "status")

            click_on 'Rechercher'
            tasks_list = all('td')
            expect(tasks_list.count).to eq 2*9
            expect(tasks_list[0]).to have_content 'Titre2'
            expect(tasks_list[9]).to have_content 'Autre test'
            expect(tasks_list[18]).not_to have_content 'Autre'

            click_on 'Liste des tâches'

            select("Démarré", from: "status")
            click_on 'Rechercher'
            tasks_list = all('td')
            expect(tasks_list.count).to eq 2*9
            expect(tasks_list[0]).to have_content 'Autre'
            expect(tasks_list[0]).not_to have_content 'Autre test'


            click_on 'Liste des tâches'

            select("Non démarré", from: "status")
            click_on 'Rechercher'
            tasks_list = all('td')
            expect(tasks_list.count).to eq 5*9
            expect(tasks_list[0]).to have_content 'priorité cliquez'
            expect(tasks_list[18]).not_to have_content 'Autre test'
          end
        end
        context 'Recherche par titre et statut' do
          it "Seules les tâches dont le titre contient le mot recherché et qui correspondent au statut sont affichées." do
            Task.delete_all
            # Utilisez les fonctions to et not_to pour vérifier ce qui est affiché et ce qui ne l'est pas.
            Task.create(title: 'priorité cliquez', content: 'nil',deadline_on: '2024-12-08',priority: :Elevée, status: 'Non démarré')
            Task.create(title: 'classées cliquez', content: 'nil',deadline_on: '2024-12-09',priority: :Moyenne, status: 'Non démarré')
            Task.create(title: 'tâches clic', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Terminé')

            Task.create(title: 'Titre1', content: 'nil',deadline_on: '2024-12-08',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Titre2', content: 'nil',deadline_on: '2024-12-09',priority: :Faible, status: 'Terminé')
            Task.create(title: 'clic', content: 'nil',deadline_on: '2024-12-10',priority: :Faible, status: 'Non démarré')
            Task.create(title: 'Autre clic', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Terminé')
            Task.create(title: 'Autre', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Démarré')
            Task.create(title: 'Autre1', content: 'nil',deadline_on: '2024-12-11',priority: :Faible, status: 'Démarré')

            visit tasks_path

            fill_in 'title', with: 'cli'
            select("Terminé", from: "status")

            click_on 'Rechercher'

            td_list = all('td')

            expect(td_list.count).to eq 2*9
            expect(td_list[0]).to have_content 'tâches clic'
            expect(td_list[9]).not_to have_content 'Titre2'
          end
        end
      end
end