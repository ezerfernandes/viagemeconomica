from environs import Env


env = Env()


__all__ = [
    "PORT",
]


PORT = env.int("PORT", 8000)
