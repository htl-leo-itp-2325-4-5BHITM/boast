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

insert into BOASTUSER (CREATEDON, USERID, USERNAME, EMAIL) VALUES (null, 100, 'max', 'email');