select * from position;
select * from people;
select * from tracks;
use project;


# QUERY 1 DONE!!!!
select position.po_pos, tracks.tr_title, people.name, tr_dateentered 
from position, tracks, people
where (position.po_date = '1968-09-07') and 
	  (position.po_track_id = tracks.tr_id) and
      (tracks.tr_artist_id = people.p_id)
      order by position.po_pos;


# QUERY 2 DONE!! maybe? gives 44 rows not 43?
select distinct tracks.tr_title, people.name 
from tracks, people, position
where (position.po_pos = 10) and
	  (tracks.tr_year = '1970') and
	  (position.po_track_id = tracks.tr_id) and 
      (tracks.tr_artist_id = people.p_id)
      order by tracks.tr_title;


# QUERY 3 DONE!!!!
select distinct people.name, tracks.tr_title, position.po_pos 
from people, tracks, position, wrote
where (tracks.tr_year = '1972') and
	  (position.po_pos = 1) and
      (position.po_track_id = tracks.tr_id) and
      (position.po_track_id = wrote.wr_track_id) and
      (wrote.wr_p_id = people.p_id)
      order by people.name;
      

# QUERY 4 DONE!!!
select distinct people.name, tracks.tr_title, tracks.tr_datepeaked, position.po_pos
from people, tracks, position
where (tracks.tr_year = '1969') and
      (position.po_pos = 1) and
      (position.po_track_id = tracks.tr_id) and 
      (tracks.tr_artist_id = people.p_id)
      order by tracks.tr_datepeaked;


# QUERY 5 DONE!!!!
select distinct tracks.tr_title, people.name, tracks.tr_highest
from tracks, people, position, wrote
where (tracks.tr_year = '1973') and
	  (tracks.tr_highest < 20) and
      (position.po_track_id = tracks.tr_id) and
      (position.po_track_id = wrote.wr_track_id) and
      (tracks.tr_artist_id = wrote.wr_p_id) and
      (wrote.wr_p_id = people.p_id);
	  

# QUERY 6 DONE!!! 
select distinct tracks.tr_title, tracks.tr_weeksCH
from tracks, position
where (position.po_date between '1972-01-01' and '1972-12-31') and
	  (tracks.tr_weeksCH > 30);


# QUERY 7 DONE!!!!
select distinct tracks.tr_title, people.name
from tracks, people, position
where (position.po_date between '1969-07-01' and '1969-07-31') and
	  (position.po_pos <= 10) and
      (position.po_track_id = tracks.tr_id) and
      (tracks.tr_artist_id = people.p_id)
      order by people.name;
      



# QUERY 8 NEEDS WORK!!!!
select t1.tr_title, name, t1.tr_highest, t1.tr_datepeaked
from tracks as t1
	inner join tracks as t2
    on t1.tr_id = t2.tr_id
    inner join people as artists
    on artists.p_id = t1.tr_artist_id = t2.tr_artist_id
    order by t1.tr_title, t1.tr_highest;





# QUERY 9 DONE!!!! Beatles were in all of the top five postions
select position.po_pos, tracks.tr_title, people.name
from tracks, people, position
where (position.po_date = '1964-04-04') and
	  (position.po_pos between 1 and 40) and
      (position.po_track_id = tracks.tr_id) and
      (tracks.tr_artist_id = people.p_id)
      order by position.po_pos;


# QUERY 10 DONE!!!!!
select distinct tracks.tr_title, people.name, tracks.tr_datepeaked, tracks.tr_highest
from tracks, people
where (tracks.tr_year = '1968') and
	  (tracks.tr_highest between 6 and 10) and
      (tracks.tr_artist_id = people.p_id)
      order by tracks.tr_datepeaked, 
      tracks.tr_highest;

# QUERY 11 What song titles are longer than 5 minutes in length and had position of 1 in the year 1974
select distinct tracks.tr_title, people.name, tracks.tr_time, tracks.tr_year, position.po_pos 
from tracks, people, position
where (tracks.tr_time > '5:00') and
	  (tracks.tr_artist_id = people.p_id) and
      (tracks.tr_year = '1974') and
      (position.po_pos = 1)
order by tracks.tr_time;
	  


