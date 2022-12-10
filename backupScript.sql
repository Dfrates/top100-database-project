set sql_safe_updates = 0;

select * from top100;

alter table top100 rename column yearrank to yearlyrank;
alter table people rename column p_name to name;
alter table artists rename column p_id to a_id;
alter table people rename column pid to p_id;


# creates tracks table
create table tracks
(
	tr_id int not null auto_increment,
    tr_labelandnum varchar(40) not null,
    tr_title varchar(100) not null,
    tr_dateentered date not null,
    tr_year char(4) not null,
    tr_yearlyrank char(4) not null,
    primary key (tr_id)
);

select * from tracks;
truncate tracks;

# creates people table
create table people
(
	p_id int not null auto_increment,
    name varchar(100),
    primary key (p_id)
);

drop table people;
truncate people;

drop table writlink;

desc people;
select * from people;

# inserts into people table
insert into people (name)
select artist from top100
where artist is not null
union
select writtenby1 from top100
where writtenby1 is not null
union
select writtenby2 from top100
where writtenby2 is not null
union
select writtenby3 from top100
where writtenby3 is not null
union
select writtenby4 from top100
where writtenby4 is not null
union
select writtenby4 from top100
where writtenby4 is not null
union
select writtenby5 from top100
where writtenby5 is not null
union
select writtenby6 from top100
where writtenby6 is not null
union
select writtenby7 from top100
where writtenby7 is not null
union
select writtenby8 from top100
where writtenby8 is not null;

create table artists like people;

# do not use, updated to people table
insert into artists (name)
select artist from top100 where artist is not null
union
select artist from top100 where artist is not null;

select * from artists;

# Removes duplicates from artists table
create table new_artists select distinct a_id, name from artists;
drop table artists;
alter table new_artists rename to artists;

select tracks.tr_title, count(tracks.tr_title)
from tracks
group by tracks.tr_title
having count(tracks.tr_title) > 1;

select people.name, count(people.name)
from people
group by people.name
having count(people.name) > 1;

select people.name from people
where people.name = 'Tommy James and the Shondells';

delete S1 from artists as S1
inner join artists as S2
where S1.a_id < S2.a_id;

drop table WRITLINK;

desc artists;
truncate artists;
drop table artists;


drop table tracks;
desc tracks;
drop table position;

desc WRITLINK;
select * from writlink
order by writ_tr_id;
truncate WRITLINK;
truncate perflink;

select writ_tr_id, name from writlink, people
where (writlink.wr_id = people.p_id);

select * from tracks;
select * from perflink;
select * from people;

select wr_id from writlink
where wr_id = 2;

insert into perflink (perf_tr_id, perf_id)
select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle= tracks.tr_title)
and (top100.artist = people.name);

insert into perflink (perf_id)
select people.p_id from people, top100
where (top100.artist = people.name);

      


insert into writlink (writ_tr_id, wr_id)
select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby1 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby2 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby3 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby4 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby5 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby6 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby7 = people.name)
      union
      select tracks.tr_id, people.p_id from tracks, people, top100
where (top100.tracktitle = tracks.tr_title) and 
	  (top100.writtenby8 = people.name);
      
		



insert into writlink (a_id, p_id)
select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby1 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby2 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby3 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby4 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby5 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby6 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby7 = people.name)
      union
      select artists.a_id, people.p_id from artists, people, top100
where (top100.artist = artists.name) and 
	  (top100.writtenby8 = people.name);
		
      
select artists.name, people.name from artists, people, WRITLINK
where (artists.a_id = WRITLINK.a_id) and (people.p_id = WRITLINK.p_id)
order by artists.name;

truncate tracks;
desc tracks;

# inserts in to tracks table
insert into tracks (tr_labelandnum, tr_title, tr_dateentered, tr_year, tr_yearlyrank)
select labelandnum, tracktitle, dateentered, year, yearlrank  from top100;

# deletes duplicate rows
delete c1 from people c1
inner join people c2
where c1.p_id > c2.p_id and c1.name = c2.name;

select * from tracks;
select * from people;

select * from position;

drop table position;

# creates position table
create table position
(
  po_track_id int not null,
  po_week int not null,
  po_date date not null,
  po_pos int not null,
  PRIMARY KEY (po_track_id, po_week),
  CONSTRAINT po_track_fk FOREIGN KEY (po_track_id) REFERENCES tracks(tr_id)
);

# inserts into position table
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 1, tr_dateentered, week1 from tracks, top100
where (week1 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 2, tr_dateentered + interval (2-1)*7 day, week2 from tracks, top100
where (week2 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 3, tr_dateentered + interval (3-1)*7 day, week3 from tracks, top100
where (week3 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 4, tr_dateentered + interval (4-1)*7 day, week4 from tracks, top100
where (week4 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 5, tr_dateentered + interval (5-1)*7 day, week5 from tracks, top100
where (week5 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 6, tr_dateentered + interval (6-1)*7 day, week6 from tracks, top100
where (week6 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 7, tr_dateentered + interval (7-1)*7 day, week7 from tracks, top100
where (week7 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 8, tr_dateentered + interval (8-1)*7 day, week8 from tracks, top100
where (week8 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 9, tr_dateentered + interval (9-1)*7 day, week9 from tracks, top100
where (week9 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 10, tr_dateentered + interval (10-1)*7 day, week10 from tracks, top100
where (week10 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 11, tr_dateentered + interval (11-1)*7 day, week11 from tracks, top100
where (week11 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 12, tr_dateentered + interval (12-1)*7 day, week12 from tracks, top100
where (week12 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 13, tr_dateentered + interval (13-1)*7 day, week13 from tracks, top100
where (week13 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 14, tr_dateentered + interval (14-1)*7 day, week14 from tracks, top100
where (week14 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 15, tr_dateentered + interval (15-1)*7 day, week15 from tracks, top100
where (week15 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 16, tr_dateentered + interval (16-1)*7 day, week16 from tracks, top100
where (week16 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 17, tr_dateentered + interval (17-1)*7 day, week17 from tracks, top100
where (week17 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 18, tr_dateentered + interval (18-1)*7 day, week18 from tracks, top100
where (week18 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 19, tr_dateentered + interval (19-1)*7 day, week19 from tracks, top100
where (week19 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 20, tr_dateentered + interval (20-1)*7 day, week20 from tracks, top100
where (week20 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 21, tr_dateentered + interval (21-1)*7 day, week21 from tracks, top100
where (week21 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 22, tr_dateentered + interval (22-1)*7 day, week22 from tracks, top100
where (week22 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 23, tr_dateentered + interval (23-1)*7 day, week23 from tracks, top100
where (week23 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 24, tr_dateentered + interval (24-1)*7 day, week24 from tracks, top100
where (week24 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 25, tr_dateentered + interval (25-1)*7 day, week25 from tracks, top100
where (week25 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 26, tr_dateentered + interval (26-1)*7 day, week26 from tracks, top100
where (week26 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 27, tr_dateentered + interval (27-1)*7 day, week27 from tracks, top100
where (week27 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 28, tr_dateentered + interval (28-1)*7 day, week28 from tracks, top100
where (week28 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 29, tr_dateentered + interval (29-1)*7 day, week29 from tracks, top100
where (week29 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 30, tr_dateentered + interval (30-1)*7 day, week30 from tracks, top100
where (week30 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 31, tr_dateentered + interval (31-1)*7 day, week31 from tracks, top100
where (week31 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 32, tr_dateentered + interval (32-1)*7 day, week32 from tracks, top100
where (week32 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 33, tr_dateentered + interval (33-1)*7 day, week33 from tracks, top100
where (week33 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 34, tr_dateentered + interval (34-1)*7 day, week34 from tracks, top100
where (week34 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 35, tr_dateentered + interval (35-1)*7 day, week35 from tracks, top100
where (week35 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 36, tr_dateentered + interval (36-1)*7 day, week36 from tracks, top100
where (week36 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 37, tr_dateentered + interval (37-1)*7 day, week37 from tracks, top100
where (week37 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 38, tr_dateentered + interval (38-1)*7 day, week38 from tracks, top100
where (week38 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 39, tr_dateentered + interval (39-1)*7 day, week39 from tracks, top100
where (week39 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 40, tr_dateentered + interval (40-1)*7 day, week40 from tracks, top100
where (week40 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 41, tr_dateentered + interval (41-1)*7 day, week41 from tracks, top100
where (week41 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 42, tr_dateentered + interval (42-1)*7 day, week42 from tracks, top100
where (week42 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 43, tr_dateentered + interval (43-1)*7 day, week43 from tracks, top100
where (week43 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 44, tr_dateentered + interval (44-1)*7 day, week44 from tracks, top100
where (week44 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 45, tr_dateentered + interval (45-1)*7 day, week45 from tracks, top100
where (week45 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 46, tr_dateentered + interval (46-1)*7 day, week46 from tracks, top100
where (week46 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 47, tr_dateentered + interval (47-1)*7 day, week47 from tracks, top100
where (week47 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 48, tr_dateentered + interval (48-1)*7 day, week48 from tracks, top100
where (week48 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 49, tr_dateentered + interval (49-1)*7 day, week49 from tracks, top100
where (week49 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 50, tr_dateentered + interval (50-1)*7 day, week50 from tracks, top100
where (week50 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 51, tr_dateentered + interval (51-1)*7 day, week51 from tracks, top100
where (week51 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 52, tr_dateentered + interval (52-1)*7 day, week52 from tracks, top100
where (week52 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 53, tr_dateentered + interval (53-1)*7 day, week53 from tracks, top100
where (week53 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 54, tr_dateentered + interval (54-1)*7 day, week54 from tracks, top100
where (week54 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 55, tr_dateentered + interval (55-1)*7 day, week55 from tracks, top100
where (week55 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 56, tr_dateentered + interval (56-1)*7 day, week56 from tracks, top100
where (week56 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 57, tr_dateentered + interval (57-1)*7 day, week57 from tracks, top100
where (week57 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 58, tr_dateentered + interval (58-1)*7 day, week58 from tracks, top100
where (week58 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 59, tr_dateentered + interval (59-1)*7 day, week59 from tracks, top100
where (week59 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 60, tr_dateentered + interval (60-1)*7 day, week60 from tracks, top100
where (week60 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 61, tr_dateentered + interval (61-1)*7 day, week61 from tracks, top100
where (week61 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 62, tr_dateentered + interval (62-1)*7 day, week62 from tracks, top100
where (week62 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 63, tr_dateentered + interval (63-1)*7 day, week63 from tracks, top100
where (week63 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 64, tr_dateentered + interval (64-1)*7 day, week64 from tracks, top100
where (week64 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 65, tr_dateentered + interval (65-1)*7 day, week65 from tracks, top100
where (week65 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 66, tr_dateentered + interval (66-1)*7 day, week66 from tracks, top100
where (week66 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 67, tr_dateentered + interval (67-1)*7 day, week67 from tracks, top100
where (week67 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 68, tr_dateentered + interval (68-1)*7 day, week68 from tracks, top100
where (week68 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 69, tr_dateentered + interval (69-1)*7 day, week69 from tracks, top100
where (week69 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 70, tr_dateentered + interval (70-1)*7 day, week70 from tracks, top100
where (week70 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 71, tr_dateentered + interval (71-1)*7 day, week71 from tracks, top100
where (week71 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 72, tr_dateentered + interval (72-1)*7 day, week72 from tracks, top100
where (week72 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 73, tr_dateentered + interval (73-1)*7 day, week73 from tracks, top100
where (week73 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 74, tr_dateentered + interval (74-1)*7 day, week74 from tracks, top100
where (week74 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
insert into position (po_track_id,po_week, po_date, po_pos)
select tr_id, 75, tr_dateentered + interval (75-1)*7 day, week75 from tracks, top100
where (week75 > 0) and (tr_title = tracktitle) and (tr_year = year) and (tr_yearlyrank = yearlyrank);
