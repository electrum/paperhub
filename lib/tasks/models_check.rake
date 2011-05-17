namespace :models do
  desc 'Check models for problems'
  task :check => :environment do
    Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each do |f|
      model = eval File.basename(f)[0..-4].camelize
      next unless model.superclass == ActiveRecord::Base
      print "#{model.name}: "
      if model.column_names.exclude? model.primary_key
        abort "bad primary key: #{model.primary_key}"
      end
      model.reflect_on_all_associations.each do |reflection|
        association = reflection.name.to_s
        begin
          reflection.klass
          eval "model.new.#{association}"
        rescue
          abort "bad association: #{association}"
        end
      end
      puts "ok"
    end
  end
end
