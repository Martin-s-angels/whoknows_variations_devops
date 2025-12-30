/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
export async function up(knex) {
  // Create enum type 'user_role' if it doesn't exist
  await knex.raw(`DO $$
    BEGIN
      IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
        CREATE TYPE user_role AS ENUM ('user', 'admin');
      END IF;
    END
  $$;`);

  // Add 'role' column to 'users' table with default 'user'
  await knex.schema.alterTable('users', table => {
    table.specificType('role', 'user_role').notNullable().defaultTo('user');
  });
}

/**
 * @param { import("knex").Knex } knex
 * @returns { Promise<void> }
 */
export async function down(knex) {
  // Drop the 'role' column
  await knex.schema.alterTable('users', table => {
    table.dropColumn('role');
  });

  // Drop the enum type if not used elsewhere
  await knex.raw(`DROP TYPE IF EXISTS user_role;`);
}
