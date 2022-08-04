create schema schema_name;

create table schema_name.table_name
(
    id             serial
        constraint table_name_pk
            primary key,
    table_row_int  int  not null,
    table_row_text text not null
);

INSERT INTO schema_name.table_name (id, table_row_int, table_row_text)
VALUES (1, 12, 'first');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text)
VALUES (2, 234, 'second');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text)
VALUES (3, 54, 'third');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text)
VALUES (4, 123, 'fourth');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text)
VALUES (5, 534, 'fifth');
INSERT INTO schema_name.table_name (id, table_row_int, table_row_text)
VALUES (6, 231, 'sixth');