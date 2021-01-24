namespace :data do
  desc "generate random data to see how things look"
  task :random do
    Grisaille.plugin?(:blog) { FactoryGirl.create_list :post, 10 }
    FactoryGirl.create :exhibition, :future
    FactoryGirl.create :exhibition, :ongoing
    FactoryGirl.create :exhibition, :past
  end

  desc "clean out the database"
  task :wipe => [:'dm:drop', :'dm:auto:migrate', :seed]
end
