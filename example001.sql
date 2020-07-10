PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE nerds(
    id char(8) primary key, name char(20), description char(80)
);
INSERT INTO nerds VALUES('1','alan','first author');
INSERT INTO nerds VALUES('2','nala','backwards author');
INSERT INTO nerds VALUES('3','derp','talks about keyboards too much');
CREATE TABLE links(
    id         char(8) primary key,
    author_id  char(8),
    url        char(80),
    comment    char(120)
);
INSERT INTO links VALUES('abc','1','https://google.com?q=ok','conversation about what is ok');
INSERT INTO links VALUES('abd','1','https://google.com?q=this','helpful for english grammar');
INSERT INTO links VALUES('abe','2','https://google.com?q=is','to be or not to be?');
INSERT INTO links VALUES('abf','3','https://google.com?q=not','negative');
INSERT INTO links VALUES('abg','3','https://google.com?q=very','clickbait');
INSERT INTO links VALUES('abh','3','https://google.com?q=fun','i dunno');
COMMIT;
