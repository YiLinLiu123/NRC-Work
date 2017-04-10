CREATE DATABASE TwitterDB;
SHOW DATABASES;
USE twitterdb;

CREATE TABLE status
(
	text	VARCHAR(1000), 
    favorited	BOOLEAN,
    favoriteCount	INTEGER,
    replyToSN	VARCHAR(200),
    created    DATE,
    truncated	VARCHAR(1000),
    replyToSID	VARCHAR(1000),
    id	VARCHAR(200) ,
    replyToUID	VARCHAR(1000),
    statusSource	VARCHAR(1000),
    screenName	VARCHAR(100),
    retweetCount	INTEGER,
    isRetweet	BOOLEAN,
    retweeted	BOOLEAN,
    longitude	FLOAT,
    latitude	FLOAT,
    PRIMARY KEY(id)
    
);





SHOW TABLES;
DESCRIBE status;
SELECT * FROM status;

LOAD DATA LOCAL INFILE 'P:\\University\\During Uni\\2nd Year\\School\\ottawa co-op\\API Project\\Twitter\\Twitter Report\\DB_Data.txt'
INTO TABLE status;


SELECT * FROM status;