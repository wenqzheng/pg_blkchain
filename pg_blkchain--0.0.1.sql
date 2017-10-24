-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_blkchain" to load this file. \quit


CREATE TYPE CTx AS (hash BYTEA, version BIGINT, locktime BIGINT);
CREATE FUNCTION get_tx(bytea) RETURNS CTx
AS '$libdir/pg_blkchain'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE CTxIn AS (n INT, prevout_hash BYTEA, prevout_n INT, scriptsig BYTEA, sequence INT);
CREATE FUNCTION get_vin(bytea) RETURNS SETOF CTxIn
AS '$libdir/pg_blkchain'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE CTxOut AS (n INT, value BIGINT, scriptpubkey BYTEA);
CREATE FUNCTION get_vout(bytea) RETURNS SETOF CTxOut
AS '$libdir/pg_blkchain'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE CScriptOp AS (op_sym TEXT, op INT, data BYTEA);
CREATE FUNCTION parse_script(bytea) RETURNS SETOF CScriptOp
AS '$libdir/pg_blkchain'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION verify_sig(bytea, bytea, int) RETURNS bool
AS '$libdir/pg_blkchain'
LANGUAGE C IMMUTABLE STRICT;

-- experimental
CREATE FUNCTION get_vout_arr(bytea) RETURNS TxOut[]
AS '$libdir/pg_blkchain'
LANGUAGE C IMMUTABLE STRICT;
