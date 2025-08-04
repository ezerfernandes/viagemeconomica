from environs import Env


env = Env()


__all__ = [
    "PORT",
]


PORT = env.int("PORT", 8000)
DB_NAME = env("DB_NAME", "viagemeconomica")
DB_USER = env("DB_USER", "postgres")
DB_PASSWORD = env("DB_PASSWORD", "postgres")
DB_HOST = env("DB_HOST", "localhost")
DB_PORT = env.int("DB_PORT", 5432)
