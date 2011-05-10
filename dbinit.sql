/*

CREATE DATABASE lrdata;

CREATE USER 'lrdata'@'localhost' IDENTIFIED BY 'test';
GRANT ALL PRIVILEGES ON lrdata.* TO 'lrdata'@'localhost' WITH GRANT OPTION;

USE lrdata;

*/


CREATE TABLE IF NOT EXISTS USER (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	lr_id CHAR(24) NOT NULL,
	username VARCHAR(30),
	CONSTRAINT UNIQUE(lr_id),
	CONSTRAINT UNIQUE(username)
);

CREATE TABLE IF NOT EXISTS ROOM (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(200),
	CONSTRAINT UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS ARTIST (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(200),
	CONSTRAINT UNIQUE(name)
);

CREATE TABLE IF NOT EXISTS ALBUM (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	artist_id INT NOT NULL,
	name VARCHAR(200),
	CONSTRAINT UNIQUE(artist_id, name),
	CONSTRAINT FOREIGN KEY (artist_id) REFERENCES ARTIST (id)
);

CREATE TABLE IF NOT EXISTS TRACK (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	artist_id INT NOT NULL,
	name VARCHAR(200),
	CONSTRAINT UNIQUE(artist_id, name),
	CONSTRAINT FOREIGN KEY (artist_id) REFERENCES ARTIST (id)
);

CREATE TABLE IF NOT EXISTS TRACK_PLAY (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	lr_id CHAR(24) NOT NULL,
	track_id INT NOT NULL,
	user_id INT NOT NULL,
	room_id INT NOT NULL,
	album_id INT NULL,
	played DATETIME NOT NULL,
	CONSTRAINT UNIQUE(track_id, room_id, played),
	CONSTRAINT FOREIGN KEY (track_id) REFERENCES TRACK (id),
	CONSTRAINT FOREIGN KEY (user_id) REFERENCES USER (id),
	CONSTRAINT FOREIGN KEY (room_id) REFERENCES ROOM (id),
	CONSTRAINT FOREIGN KEY (album_id) REFERENCES ALBUM (id)
);

CREATE TABLE IF NOT EXISTS TRACK_PLAY_REPORT (
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	play_id INT NOT NULL,
	user_id INT NOT NULL,
	ip VARCHAR(15) NOT NULL,
	CONSTRAINT UNIQUE(play_id, user_id),
	CONSTRAINT FOREIGN KEY (play_id) REFERENCES TRACK_PLAY (id),
	CONSTRAINT FOREIGN KEY (user_id) REFERENCES USER (id)
);
