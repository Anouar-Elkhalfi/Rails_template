# template.rb

# Ajouter les gems essentielles
gem 'devise'
gem 'pundit'
gem 'administrate'
gem 'sidekiq'
gem 'letter_opener'
gem 'dotenv-rails', groups: [:development, :test]

# Installer les gems après la génération de l’application
after_bundle do
  # Configurer Devise
  generate 'devise:install'
  generate 'devise User'

  # Configurer Pundit
  generate 'pundit:install'

  # Configurer Administrate
  generate 'administrate:install'

  # Ajouter Sidekiq pour le traitement en arrière-plan
  environment "config.active_job.queue_adapter = :sidekiq"

  # Ajouter Bootstrap (optionnel)
  run "yarn add bootstrap @popperjs/core"
  inject_into_file 'app/javascript/application.js', "\nimport 'bootstrap'", after: "import 'controllers'"

  # Configurer une page d'accueil par défaut
  route "root to: 'pages#home'"
  generate :controller, "pages home"

  # Initialiser un repo Git
  git :init
  git add: "."
  git commit: %Q{ -m 'Initial commit with template' }
end
