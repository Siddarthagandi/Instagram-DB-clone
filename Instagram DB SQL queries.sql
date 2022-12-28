create database ig_clone;
use ig_clone;

#|1|.We want to reward the user who has been around the longest, Find the 5 oldest users
#Query:
select * from users;
select Id,username as OldestUsers,Created_at from users order by created_at asc limit 5; 

#******************************************************************************************************************************************#
#|2|.To understand when to run the ad campaign, figure out the day of the week most users register on? 
#Query:
SELECT DAYNAME(created_at) AS WEEKDAY,COUNT(*) AS NO_OF_REGISTRATIONS FROM users
GROUP BY WEEKDAY ORDER BY NO_OF_REGISTRATIONS DESC;

#******************************************************************************************************************************************#
#|3|.To target inactive users in an email ad campaign, find the users who have never posted a photo.
#Query:
SELECT * FROM USERS;
SELECT * FROM PHOTOS;
select USERS.ID,USERNAME,ifnull('Never Posted a Photo',photos.id) as PHOTOS  
from users left join photos on users.id= photos.user_id where photos.id is null order by users.ID asc ;

#******************************************************************************************************************************************#
#|4|.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
#Query:
SELECT USERNAME, photos.id AS PHOTO_ID, photos.IMAGE_URL, COUNT(*) AS TOTAL_NO_OF_LIKES FROM users
INNER JOIN photos ON users.id = photos.user_id inner JOIN likes ON photos.id = likes.photo_id 
GROUP BY photos.id
ORDER BY TOTAL_NO_OF_LIKES DESC limit 1;

#******************************************************************************************************************************************#
#|5|.The investors want to know how many times does the average user post.   
#Query:
select ceil(( SELECT COUNT(photos.id) FROM photos ) / ( SELECT COUNT(users.id) FROM users )) as Avg_User_Post;

#******************************************************************************************************************************************#
#|6|.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
#Query:
select upper(tag_name) as Hashtags,count(tag_name) as No_oF_Hashtags from tags inner join 
photo_tags on tags.id=photo_tags.tag_id group by tags.id order by count(tag_name) desc limit 5;

#******************************************************************************************************************************************#
#|7|.To find out if there are bots, find users who have liked every single photo on the site.
#Query:
select USERS.ID,USERNAME AS 'USERS WHO LIKED ALL PHOTOS',count(*) as 'TOTAL_LIKES' from users
inner join likes on users.id=likes.user_id
group by users.id  having TOTAL_LIKES = (select count(photos.id)from photos);

#******************************************************************************************************************************************#
#|8|.To know who the celebrities are, find users who have never commented on a photo.
#Query:
select USERS.ID,USERNAME as USERS,IFNULL('EMPTY',COMMENT_TEXT) AS COMMENTS from users 
left join comments on users.id=comments.user_id
where comments.user_id is null group by users.id;

#******************************************************************************************************************************************#
