--BOASTUSER
insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 100, 'Felix', 'felix.wimberger@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 101, 'Raphi', 'raphael.scharrer@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 102, 'Jannis', 'jannis.sideras@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 103, 'Teo', 'teofan.mihaescu@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 104, 'Andrei', 'andrei.brehar@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 105, 'Lana', 'lana.sekerija@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 106, 'Yasin', 'yasin.erkol@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 107, 'Sebi', 'sebastian.feichtenschlager@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 108, 'Julian', 'julian.jaklitsch@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 109, 'elYanuki', 'yanik.kendler@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 110, 'Jana', 'jana.krenn@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 111, 'Michi', 'michael.leisch@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 112, 'Tommy', 'tommy.neumaier@icloud.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 113, 'Malte', 'malte.ostermann@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 114, 'Ana', 'ana.paripovic@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 115, 'Sara', 'sara.radic@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 116, 'Oli', 'oliver.schatzberger@icloud.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 117, 'Nati', 'natalie.schmitzberger@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 118, 'Romana', 'romana.schned@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 119, 'Leonie', 'leonie.schwarz@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 120, 'Tuana', 'tuana.sevic@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 121, 'Leon', 'leon.steinhuber@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 122, 'Heiko', 'heiko.vichtbauer@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 123, 'Janine', 'janine.wenninger@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 124, 'Mario', 'mario.meister@gmail.com');


--POST
insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 103, 100,
        'Swift Test',
        'I bet we will have to retake the Test in MC',
        'POLL', 'OPEN');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 100, 101,
        'School',
        'I bet Teo will not be able to have an autism-free day this week',
        'POLL', 'OPEN');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 101, 102,
        'UFC 293',
        'I bet Strickland wont win against Adesanya',
        'POLL', 'OPEN');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 100, 103,
        'Attendance',
        'I bet Raphi will be 5min late today',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 104,
        'Smoking',
        'I bet Felix will start smoking by the end of February',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 101, 105,
        'Eating',
        'I bet after next years Summer break Teo will be overweight',
        'POLL', 'CANCELED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 103, 106,
        'Class',
        'I bet everybody in our class will make it to 5BHITM',
        'POLL', 'CANCELED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 107,
        '1. Sem ending',
        'I bet Teo will have a grade average of 4.5 by the end of the first Semester',
        'POLL', 'OPEN');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 108,
        'Hair',
        'I bet Raphi will start a successful Business by 21.',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 101, 109,
        'Football',
        'I bet Italy will win the EM.',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 100, 110,
        'Ronaldo retirement',
        'I bet Ronaldo will retire in 5 years',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 111,
        'School',
        'I bet the 2nd Semester will be harder than the first',
        'POLL', 'CLOSED');

--POSTDETAIL
insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1000);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1001);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 101, 1002);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1003);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 102, 1004);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1005);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1006);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 101, 1007);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 102, 1008);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1009);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1010);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 102, 1011);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1012);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1013);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 101, 1014);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1015);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 102, 1016);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1017);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 101, 1018);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 102, 1019);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 103, 1020);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1021);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 102, 1022);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 101, 1023);

insert into POSTDETAIL (CREATEDON, CREATOR_USERID, POSTDETAILSID)
values (current_timestamp, 100, 1024);

--POLL_POST
insert into POLL_POST (POSTID)
values (100);

insert into POLL_POST (POSTID)
values (101);

insert into POLL_POST (POSTID)
values (102);

insert into POLL_POST (POSTID)
values (103);

insert into POLL_POST (POSTID)
values (104);

insert into POLL_POST (POSTID)
values (105);

insert into POLL_POST (POSTID)
values (106);

insert into POLL_POST (POSTID)
values (107);

insert into POLL_POST (POSTID)
values (108);

insert into POLL_POST (POSTID)
values (109);

insert into POLL_POST (POSTID)
values (110);

insert into POLL_POST (POSTID)
values (111);

--POLL_POSTANSWER
insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (100, 1000, 'never');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (100, 1001, 'it is likely');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (101, 1002, 'definitely');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (101, 1003, 'definitely not');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (102, 1004, 'very possible');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (102, 1005, 'sure buddy');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (103, 1006, 'ofc');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (103, 1007, 'nah');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (104, 1009, 'never');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (104, 1010, 'yeah, maybe');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (105, 1011, 'yes');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (105, 1012, 'no');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (106, 1013, 'No');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (106, 1014, 'Yes');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (107, 1015, 'over');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (107, 1016, 'under');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (108, 1017, 'definitely');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (108, 1018, 'hairline will stay');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (109, 1019, 'Italy for the win');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (109, 1020, 'Turkey will win');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (109, 1020, 'France will win');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (110, 1021, 'Definitely');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (110, 1022, 'after 5 years');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (111, 1023, 'yeah sure');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (111, 1024, 'can not be');

--POLL_POSTDETAIL
insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1000, 1000, 100);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1001, 1001, 100);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1002, 1002, 101);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1003, 1003, 101);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1004, 1004, 102);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1005, 1005, 102);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1006, 1006, 103);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1007, 1007, 103);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1008, 1008, 103);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1009, 1009, 104);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1010, 1010, 104);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1011, 1011, 105);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1012, 1012, 105);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1013, 1013, 106);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1014, 1014, 106);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1015, 1015, 107);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1016, 1016, 107);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1017, 1017, 108);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1018, 1018, 108);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1019, 1019, 109);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1020, 1020, 109);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1021, 1021, 110);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1022, 1022, 110);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1023, 1023, 111);

insert into POLL_POSTDETAIL (POLLANSWER_POLL_ANSWERID, POSTDETAILSID, POSTID)
VALUES (1023, 1024, 111);
