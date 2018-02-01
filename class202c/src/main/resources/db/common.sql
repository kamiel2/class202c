CREATE SEQUENCE  "SEQ_BOARD"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 201 CACHE 20 NOORDER  NOCYCLE ;

DROP TABLE ids;

CREATE TABLE ids (
    table_name   VARCHAR2(20),
    next_id      NUMBER(30,0)
);

DROP TABLE files;

CREATE TABLE files (
    file_id   VARCHAR2(16),
    file_n    VARCHAR2(100),
    file_u    VARCHAR2(100),
    file_s    VARCHAR2(4000),
    c_type    VARCHAR2(100),
    link      VARCHAR2(4000)
);

DROP TABLE board;

CREATE TABLE board (
    b_number    NUMBER,
    member_id   VARCHAR2(16),
    category    VARCHAR2(10),
    title       VARCHAR2(100),
    r_date      VARCHAR2(8),
    click_num   NUMBER,
    file_id     VARCHAR2(16),
    contents    VARCHAR2(4000)
);

DROP TABLE code;

CREATE TABLE code (
    main_code        VARCHAR2(8),
    main_code_name   VARCHAR2(100),
    sub_code         VARCHAR2(4),
    sub_code_name    VARCHAR2(100)
);