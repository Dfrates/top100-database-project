
# fills tracks table
insert into tracks (tr_title, tr_year, tr_yearlyrank,
        tr_artist_id, tr_time, tr_labelandnum,
        tr_dateentered, tr_datepeaked, tr_highest, tr_weeksCH)
select 
		tracktitle, year, yearlyrank,
        p_id, time, labelandnum,
        dateentered, datepeaked, PeakPos, weeksCHART
from top100, people
where
     (top100.artist = people.name);
     
truncate tracks;


select * from tracks;
select * from wrote;

insert into tracks (tr_highest)
select top100.PeakPos from top100, people
where top100.artist = people.name;


# creates table wrote 
create table wrote
(
  wr_track_id int not null,
  wr_seq int not null,
  wr_p_id int not null,
  PRIMARY KEY (wr_track_id, wr_seq),
  CONSTRAINT wr_track_fk FOREIGN KEY (wr_track_id) REFERENCES tracks(tr_id),
  CONSTRAINT wr_people_fk FOREIGN KEY (wr_p_id) REFERENCES people(p_id)
);

# fills table wrote
insert into wrote (wr_track_id,wr_seq,wr_p_id)
  select tr_id, 1, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby1 is not null) and (writtenby1 <> '') and
          (writtenby1 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 2, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby2 is not null) and (writtenby2 <> '') and
          (writtenby2 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 3, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby3 is not null) and (writtenby3 <> '') and
          (writtenby3 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 4, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby4 is not null) and (writtenby4 <> '') and
          (writtenby4 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 5, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby5 is not null) and (writtenby5 <> '') and
          (writtenby5 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 6, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby6 is not null) and (writtenby6 <> '') and
          (writtenby6 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 7, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby7 is not null) and (writtenby7 <> '') and
          (writtenby7 = name) and
          (tr_title = tracktitle)
UNION
  select tr_id, 8, p_id from tracks, people, top100
  where (tr_year= year) and (tr_yearlyrank = yearlyrank)
          and
          (writtenby8 is not null) and (writtenby8 <> '') and
          (writtenby8 = name) and
          (tr_title = tracktitle);