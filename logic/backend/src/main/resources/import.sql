--BOASTUSER
insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 100, 'Felix', 'felix.wimberger@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 101, 'Raphael', 'raphael.scharrer@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 102, 'JannisBeVibing', 'jannis.sideras@gmail.com');

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL)
VALUES (current_timestamp, 103, 'Teofan', 'teofan.mihaescu@gmail.com');

--POST
insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 103, 100, 'Swift Test',
        'Do you think that we have to retake the Test in MC?', 'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 100, 101, 'Buzz Cut',
        'Should I buzz my hair?', 'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 101, 102, 'Athletic',
        'Am I the most athletic guy at school?',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 100, 103, 'New Car',
        'Should I buy another Tesla?',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 104, 'Smoking',
        'Should I quit smoking and start taking crack?',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 103, 105, 'Eating',
        'Should the bulk continue?', 'POLL',
        'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 103, 106, 'Class',
        'Do you think that everybody in our class will make it to 5BHITM?',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 101, 107, 'Adult',
        'Do you think that I should act more maturely?',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 108, 'Hair',
        'Should I change my Hairstyle?',
        'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 103, 109, 'Training',
        'Should I start calisthenics?', 'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 100, 110, 'Sigma',
        'Do you think that I should stop helping Classmates?', 'POLL', 'CLOSED');

insert into POST (CREATEDON, CREATOR_USERID, POSTID, TITLE, DEFINITION, POSTTYPE, STATUS)
values (current_timestamp, 102, 111, 'Aggression',
        'I want to beat Julian Jaklitsch to a pulp. Should I do that?',
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
values (current_timestamp, 103, 1018);

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
VALUES (100, 1000, 'yes');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (100, 1001, 'no');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (101, 1002, 'definitely');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (101, 1003, 'definitely not');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (102, 1004, 'sure buddy');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (102, 1005, 'LMAO');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (103, 1006, 'ofc');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (103, 1007, 'nah, you broke');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (103, 1008, 'start gambling instead');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (104, 1009, 'Yes');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (104, 1010, 'YES');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (105, 1011, 'start cutting');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (105, 1012, 'yes, you are skinny');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (106, 1013, 'No');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (106, 1014, 'Yes');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (107, 1015, 'Do it already');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (107, 1016, 'stay a child');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (108, 1017, 'Pls do not');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (108, 1018, 'about time');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (109, 1019, 'NO. You are fat');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (109, 1020, 'Give it a shot');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (110, 1021, 'Definitely');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (110, 1022, 'Skibidi Toilet');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (111, 1023, 'yeah sure');

insert into POLL_POSTANSWER (POLLPOST_POSTID, POLL_ANSWERID, TITLE)
VALUES (111, 1024, 'DO NOT HURT MY POOKIE');

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

--IGNORE FOR NOW
/*insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
VALUES (1000, 'Teo', 'Raphi', 'Workout Challenge',
        'Try to do 10 Sit-Ups in the shortest possible time and submit your time in seconds');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1001, 'Felix', 'Teo', 'Blindfolded Food Eating Challenge',
        'Blindfold a friend and have them eat random foods. The one who guesses most of them wins');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1002, 'Raphi', 'Jannis', 'Ice Bath Challenge',
        'Fill your bathtub up with cold water and then add 3kg of ice, the person who stays in there the longest wins');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1003, 'Felix', 'Raphi', 'Balloon-In-Air Challenge',
        'Each person gets a balloon filled up with Radon [Rn 86]. Try keeping the balloon airborne by blowing against it.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1004, 'Jannis', 'Felix', 'Building A Cheese Cracker House',
        'Everybody knows how to build a tower out of card, now do it with Cheez its. The Person who accomplishes this the fastest wins.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1005, 'Teo', 'Felix', 'Mimicry Challenge',
        'Impersonate someone we know. After 30 rounds, the person with the most correct guesses wins.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1006, 'Teo', 'Raphi', 'Stuffing A Pancake Challenge',
        'Prepare huge pancakes for this food challenge, and whoever finishes their pancake first wins. Hot-Sauce must be poured on to the pancake.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1007, 'Raphi', 'Jannis', 'Brain Freezer Challenge',
        'Stand in ice cold water and answer trivia questions. With every wrong questions more ice gets added. Answer most questions correctly and wins.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1008, 'Jannis', 'Teo', 'Talk To A Stranger',
        'Your friends need to go out and start a conversation with a random stranger. The one to keep the conversation going the longest wins.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1009, 'Teo', 'Raphi', 'Drinking Challenge',
        'Drink a shot accompanied by 3 push ups. The one who drank the most shots wins.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1010, 'Felix', 'Teo', 'Jump Rope Challenge',
        'The person who manages to continue skipping the longest wins.');

insert into POST (POSTID, CREATOR, WINNER, TITLE, DEFINITION)
values (1011, 'Jannis', 'Jannis', 'Silent Library',
        'Be an asshole and make noise in a library for 5min. The one who gets shushed the least amount of times wins.');

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1000, 'Raphi', '16s', 1000);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1001, 'Felix', '19s', 1000);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1002, 'Jannis', '19s', 1000);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1003, 'Teo', '17s', 1000);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1004, 'Raphi', '5 guesses', 1001);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1005, 'Felix', '6 guesses', 1001);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1006, 'Jannis', '9 guesses', 1001);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1007, 'Teo', '15 guesses', 1001);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1008, 'Raphi', '3min 40s', 1002);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1009, 'Felix', '32s', 1002);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1010, 'Jannis', '10min', 1002);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1011, 'Teo', '5min 33s', 1002);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1012, 'Raphi', '21s', 1003);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1013, 'Felix', '19s', 1003);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1014, 'Jannis', '5s', 1003);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1015, 'Teo', '12s', 1003);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1016, 'Raphi', '52s', 1004);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1017, 'Felix', '27s', 1004);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1018, 'Jannis', '1min', 1004);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1019, 'Teo', '2min 13s', 1004);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1020, 'Raphi', '6 guesses', 1005);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1021, 'Felix', '13 guesses', 1005);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1022, 'Jannis', '7 guesses', 1005);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1023, 'Teo', '4 guesses', 1005);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1024, 'Raphi', '8s', 1006);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1025, 'Felix', '13s', 1006);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1026, 'Jannis', '12s', 1006);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1027, 'Teo', '10s', 1006);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1028, 'Raphi', '11/15 correct', 1007);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1029, 'Felix', '12/15 correct', 1007);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1030, 'Jannis', '13/15 correct', 1007);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1031, 'Teo', '12/15 correct', 1007);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1032, 'Raphi', '1min 5s', 1008);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1033, 'Felix', '2min 41s', 1008);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1034, 'Jannis', '3min 19s', 1008);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1035, 'Teo', '7min 4s', 1008);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1036, 'Raphi', '13 shots', 1009);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1037, 'Felix', '4 shots', 1009);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1038, 'Jannis', '8 shots', 1009);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1039, 'Teo', 'puked...', 1009);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1040, 'Raphi', '1min 39s', 1010);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1041, 'Felix', '1min 12s', 1010);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1042, 'Jannis', '44s', 1010);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1043, 'Teo', '1min 54s', 1010);

insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1044, 'Raphi', '7 shushes', 1011);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1045, 'Felix', '5 shushes', 1011);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1046, 'Jannis', '0 shushes', 1011);
insert into POSTDETAIL (POSTDETAILSID, CREATOR, BET, POSTID)
VALUES (1047, 'Teo', '14 shushes', 1011);*/
