#this file creates the db. 
#as shown https://github.com/who-knows-inc/EK_DAT_DevOps_2025_Autumn/blob/main/00._Course_Material/01._Assignments/02._Conventions_OpenAPI_DotEnv/01._Before/go_and_ruby_sqlite_setup.md
# use this line to make the db: bundle exec ruby init_db.rb

require 'sqlite3'

db = SQLite3::Database.new 'whoknows.db' #instantiate db


schema_sql = File.read(File.join(__dir__, 'schema.sql'))#get schema as File, so we may read it.

db.execute_batch(schema_sql) #run schema


