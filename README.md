SQLite for General Data Shuffling
=================================

If there is any kind of structured data that you are collecting a
bunch of, SQLite is a handy tool for getting such data in an easy to
work with format.

This guide describes how to use SQLite to quickly store structured
data in a way that you can work with later in more complex
applications&mdash;e.g. collect a bunch of data and then use it later
in a web application.

Do check out the official documentation: [Appropriate Uses For
SQLite](https://sqlite.org/whentouse.html).

SQLite can play nice with other programs; for example, you may have
some (non-technical) friends help you enter a bunch of data into
Google docs in a consistent, tabular format. You can then export a
`.csv` file and read this into an SQLite database for easier
processing.

The `man` file for `sqlite` is not long at all; do take a look at it
to learn about all the things you can do with SQLite.

Using the Command Line Shell
----------------------------

SQLite includes a [Command Line Shell](https://sqlite.org/cli.html)
program which can be very handy.

### Flipping some switches for nice viewing

Let's play around in the command line program.

Make sure you are outputting to standard out (run `.output stdout`)
rather that writing to a file.

```
.mode columns
.headers ON
```

You can always adjust these settings later when you save your data.

### Example application: Link Spamming Friend Manager

Let's set up some tables for storing YouTube links people send you.
We'll be working with two tables, which I've designed as follows (I
put in some example values too):

Table 1: nerds

```
id   name   description
---- ------ -----------
001  alan   first author
002  nala   backwards author
003  derp   talks about keyboards too much
```

Table 2: links

```
id  author_id url                        comment
--- --------- ------                     -------
abc 001       https://google.com?q=ok    conversation about what is ok
abd 001       https://google.com?q=this  helpful for english grammar
abe 002       https://google.com?q=is    to be or not to be?
abf 003       https://google.com?q=not   negative
abg 003       https://google.com?q=very  clickbait
abh 003       https://google.com?q=fun   i dunno
```

Now, with a clear idea about what we want, it is not hard to set up
the appropriate tables. For more details, see [SQL As Understood By
SQLite](https://www.sqlite.org/lang.html).

```sql
CREATE TABLE nerds(
    id char(8) primary key, name char(20), description char(80)
);
INSERT INTO nerds VALUES(001, "alan", "first author");
INSERT INTO nerds VALUES(002, "nala", "backwards author");
INSERT INTO nerds VALUES(003, "derp", "talks about keyboards too much");
```

Check that everything looks at it should with `SELECT * FROM nerds`.

```sql
CREATE TABLE links(
    id         char(8) primary key,
    author_id  char(8),
    url        char(80),
    comment    char(120)
);

INSERT INTO links VALUES("abc", 001,
    "https://google.com?q=ok", "conversation about what is ok");
INSERT INTO links VALUES("abd", 001,
    "https://google.com?q=this", "helpful for english grammar");
INSERT INTO links VALUES("abe", 002,
    "https://google.com?q=is", "to be or not to be?");
INSERT INTO links VALUES("abf", 003,
    "https://google.com?q=not", "negative");
INSERT INTO links VALUES("abg", 003,
    "https://google.com?q=very","clickbait");
INSERT INTO links VALUES("abh", 003,
    "https://google.com?q=fun", "i dunno");
```
Check that everything looks at it should with `SELECT * FROM links`.

#### Joining tables

Great! Now that we have two tables, we can start to do more
interesting things. Suppose we wanted to see all the links but with
the associated nerd's names, not just IDs:

```sql
SELECT nerds.name, links.url
FROM nerds JOIN links ON links.author_id=nerds.id;
```

Or suppose we want to just see the nerds and their comments:

```sql
SELECT nerds.name, links.comment
FROM nerds JOIN links ON links.author_id=nerds.id;
```

### Saving your work

The command to save the SQL commands you ran to create tables, insert
values into them, etc. is `.dump`. Run `.dump` now and confirm it
looks like how you would like it to look.

Then, specify an output file.

```
.output my_file.sql
```

...and run `.dump` again. You won't see any output (to standard
output), but if you open your present working directory, you should
see the file you just named above, populated with the SQL commands you
ran.

Now, go back to outputting to standard out.

```
.output stdout
```

You can also just run `.output`; omitting a filename defaults output
to standard out.

#### Exporting table views

Suppose we want a comma separated file that contains the results of
some query. You may be asked to provide such a thing for a data
scientists, for instance.

```
1,alan,this is a message
2,nala,this is another message
```

We'll want *list* separated rows rather than whitespace/column
separated rows.

```
.mode list
.separator ","
```
Run a command like,

```sql
SELECT * FROM table1;
```

...to see if things look how you like.

If everything looks good, then you can set an output file. Then, dump
your data there. If you open up the dumped file with a text editor,
you'll see all the commands you ran there.

```
.output my_table.csv
```

Now, if you rerun your SQL statement your data will be saved to the
specified file.
