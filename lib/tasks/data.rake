namespace :data do

  task :import => :environment do

    path = "#{File.dirname(__FILE__)}/../../public/annotation_inputs.csv"

    lines = File.readlines(path)

    lines.each do |line|
      Annotation.import_line line
    end

  end

  task :export => :environment do
    lines = Annotation.export_annotations
    puts lines.join("\n")
  end

  task :delete => :environment do
    Annotation.delete_all
  end

  task :reimport => :environment do
    Annotation.delete_all

    path = "#{File.dirname(__FILE__)}/../../public/annotation_inputs.csv"

    lines = File.readlines(path)

    lines.each do |line|
      Annotation.import_line line
    end

  end

end