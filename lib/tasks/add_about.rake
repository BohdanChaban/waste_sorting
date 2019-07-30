namespace :add_about do
  desc 'Generating about us text'
  task add_about_us_text: :environment do
    About.create(content: 'Waste Sorting a company that makes the world cleaner')
  end
end
