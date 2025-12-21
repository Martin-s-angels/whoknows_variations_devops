import dotenv from 'dotenv'
dotenv.config({ path: '../dotenv/.env' })

/**
 * @type { Object.<string, import("knex").Knex.Config> }
 */
export default {

    development: {
        client: 'pg',
        connection: {
            host: '127.0.0.1',
            port: 5432,
            user: process.env.POSTGRES_USER,
            password: process.env.POSTGRES_PASSWORD,
            database: process.env.POSTGRES_DB
        },
        pool: { min: 2, max: 10 },
        migrations: { tableName: 'knex_migrations' }
    },

    staging: {
        client: 'pg',
        connection: {
            connectionString: process.env.DB_URI_DEV,
            ssl: { rejectUnauthorized: false }
        },
        pool: { min: 2, max: 10 },
        migrations: { tableName: 'knex_migrations' }
    },

    sqlite: {
        client: 'sqlite3',
        connection: {
            filename: '../db/whoknows.db'
        },
        useNullAsDefault: true,
    },

    staging: {
        client: 'pg',
        connection: {
            connectionString: process.env.DB_URI_DEV,
            ssl: { rejectUnauthorized: false }
        },
        pool: { min: 2, max: 10 },
        migrations: { tableName: 'knex_migrations' }
    },

    production: {
        client: 'pg',
        connection: {
            host: '127.0.0.1',
            port: 5432,
            user: process.env.POSTGRES_USER,
            password: process.env.POSTGRES_PASSWORD,
            database: process.env.POSTGRES_DB
        },
        pool: { min: 2, max: 10 },
        migrations: { tableName: 'knex_migrations' }
    },

}
