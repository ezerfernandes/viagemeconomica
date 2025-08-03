-- This creates the DB schema.

-- Make every table a JSON object. In particular, have only one "real" column and the rest generated from the JSON. So the typical table looks like:
-- CREATE TABLE IF NOT EXISTS Cookie (
--   cookie   TEXT    NOT NULL AS (Data->>'cookie')  STORED UNIQUE, -- PK
--   user_id   INTEGER NOT NULL AS (Data->>'user_id') STORED REFERENCES User (user_id),
--   created  INTEGER NOT NULL AS (unixepoch(Data->>'created')) STORED,
--   last_used INTEGER AS (unixepoch(Data->>'last_used')) CHECK (last_used>0),
--   data     JSONB   NOT NULL
-- );
