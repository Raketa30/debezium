CREATE SCHEMA schema_name;

CREATE TABLE schema_name.table_name
(
    id 			   SERIAL CONSTRAINT table_name_pk PRIMARY KEY,
    table_row_int  INT  NOT NULL,
    table_row_text TEXT NOT NULL
);

ALTER TABLE schema_name.table_name REPLICA IDENTITY FULL;

INSERT INTO schema_name.table_name (id, table_row_int, table_row_text) VALUES (1, 12, 'first');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text) VALUES (2, 234, 'second');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text) VALUES (3, 54, 'third');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text) VALUES (4, 123, 'fourth');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text) VALUES (5, 534, 'fifth');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text) VALUES (6, 231, 'sixth');