FactoryBot.define do
    factory :task do
      title { 'test_title' }
      content { 'test_content' }
      deadline_on { '2024-12-08'}
      priority {:Faible}
      status{:Terminé}
    end
    factory :second_task, class: Task do
      title { 'Test name' }
      content { 'Test description' }
      deadline_on { '2024-12-09'}
      priority {:Faible}
      status{:Terminé}
    end
end