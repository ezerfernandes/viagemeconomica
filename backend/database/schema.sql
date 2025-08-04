-- This creates the DB schema.

-- Make every table a JSON object. In particular, have only one "real" column and the rest generated from the JSON. So the typical table looks like:
-- CREATE TABLE IF NOT EXISTS Cookie (
--   cookie   TEXT    NOT NULL AS (Data->>'cookie')  STORED UNIQUE, -- PK
--   user_id   INTEGER NOT NULL AS (Data->>'user_id') STORED REFERENCES User (user_id),
--   created  INTEGER NOT NULL AS (unixepoch(Data->>'created')) STORED,
--   last_used INTEGER AS (unixepoch(Data->>'last_used')) CHECK (last_used>0),
--   data     JSONB   NOT NULL
-- );

-- --  #region Example table
-- CREATE TABLE IF NOT EXISTS example (
--     id UUID GENERATED ALWAYS AS ((data->>'id')::uuid) STORED NOT NULL UNIQUE, -- PK
--     tag TEXT GENERATED ALWAYS AS (data->>'tag') STORED NOT NULL,
--     template_text TEXT GENERATED ALWAYS AS (data->>'template_text') STORED NOT NULL,
--     active BOOLEAN GENERATED ALWAYS AS ((data->>'active')::boolean) STORED NOT NULL,
--     data JSONB NOT NULL,
--     created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
--     updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );

-- -- #endregion


-- Function to automatically update updated_at column
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- #region Users

CREATE TABLE IF NOT EXISTS users (
    id UUID GENERATED ALWAYS AS ((data->>'id')::uuid) STORED NOT NULL UNIQUE, -- PK
    email TEXT GENERATED ALWAYS AS (data->>'email') STORED NOT NULL UNIQUE,
    password_hash TEXT GENERATED ALWAYS AS (data->>'password_hash') STORED NOT NULL,
    name TEXT GENERATED ALWAYS AS (data->>'name') STORED,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_users_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

CREATE TABLE IF NOT EXISTS user_preferences (
    user_id UUID GENERATED ALWAYS AS ((data->>'user_id')::uuid) STORED NOT NULL REFERENCES users(id),
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_user_preferences_updated_at
BEFORE UPDATE ON user_preferences
FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

-- #endregion


-- #region Subscriptions

CREATE TABLE IF NOT EXISTS subscriptions (
    id UUID GENERATED ALWAYS AS ((data->>'id')::uuid) STORED NOT NULL UNIQUE, -- PK
    user_id UUID GENERATED ALWAYS AS ((data->>'user_id')::uuid) STORED NOT NULL REFERENCES users(id),
    plan_type TEXT GENERATED ALWAYS AS (data->>'plan_type') STORED,
    status TEXT GENERATED ALWAYS AS (data->>'status') STORED,
    stripe_subscription_id TEXT GENERATED ALWAYS AS (data->>'stripe_subscription_id') STORED,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_subscriptions_updated_at
BEFORE UPDATE ON subscriptions
FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

-- #endregion


-- #region Deals

CREATE TABLE IF NOT EXISTS deals (
    id UUID GENERATED ALWAYS AS ((data->>'id')::uuid) STORED NOT NULL UNIQUE, -- PK
    title TEXT GENERATED ALWAYS AS (data->>'title') STORED,
    price NUMERIC GENERATED ALWAYS AS ((data->>'price')::numeric) STORED,
    destination TEXT GENERATED ALWAYS AS (data->>'destination') STORED,
    deal_type TEXT GENERATED ALWAYS AS (data->>'deal_type') STORED,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_deals_updated_at
BEFORE UPDATE ON deals
FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

-- #endregion

-- #region Community

CREATE TABLE IF NOT EXISTS forums (
    id UUID GENERATED ALWAYS AS ((data->>'id')::uuid) STORED NOT NULL UNIQUE, -- PK
    title TEXT GENERATED ALWAYS AS (data->>'title') STORED,
    description TEXT GENERATED ALWAYS AS (data->>'description') STORED,
    created_by UUID GENERATED ALWAYS AS ((data->>'created_by')::uuid) STORED NOT NULL REFERENCES users(id),
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_forums_updated_at
BEFORE UPDATE ON forums
FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

CREATE TABLE IF NOT EXISTS forum_posts (
    id UUID GENERATED ALWAYS AS ((data->>'id')::uuid) STORED NOT NULL UNIQUE, -- PK
    forum_id UUID GENERATED ALWAYS AS ((data->>'forum_id')::uuid) STORED NOT NULL REFERENCES forums(id),
    user_id UUID GENERATED ALWAYS AS ((data->>'user_id')::uuid) STORED NOT NULL REFERENCES users(id),
    parent_post_id UUID GENERATED ALWAYS AS ((data->>'parent_post_id')::uuid) STORED REFERENCES forum_posts(id),
    title TEXT GENERATED ALWAYS AS (data->>'title') STORED,
    content TEXT GENERATED ALWAYS AS (data->>'content') STORED,
    data JSONB NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_forum_posts_updated_at
BEFORE UPDATE ON forum_posts
FOR EACH ROW
EXECUTE PROCEDURE update_updated_at_column();

-- #endregion
