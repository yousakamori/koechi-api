table_names = %w[users spaces]
table_names.each do |table_name|
  path = Rails.root.join('db/seeds', table_name + '.rb')
  if File.exist?(path)
    puts "Creating #{table_name}..."
    require path
  end
end

tables = %w[talks comments]
tables.each do |table|
  puts "Creating #{table}..."
  sql = File.read("db/sql_backup/#{table}.sql")
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do
    statements.each do |statement|
      ActiveRecord::Base.connection.execute(statement)
    end
  end
end

# table_names = %w[talks likes]
# table_names.each do |table_name|
#   path = Rails.root.join('db/seeds', table_name + '.rb')
#   if File.exist?(path)
#     puts "Creating #{table_name}..."
#     require path
#   end
# end
