# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( tasks/task_form.js )
Rails.application.config.assets.precompile += %w( tasks/edit.js )

Rails.application.config.assets.precompile += %w( tasks/star_priority_show.js )
Rails.application.config.assets.precompile += %w( tasks/drag&drop.js )
Rails.application.config.assets.precompile += %w( tasks/tasks.js )
Rails.application.config.assets.precompile += %w( projekt/sortable_project_tasks.js )
