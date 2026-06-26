-- Local LSP test fixtures. Run with:
--   docker compose exec -T db mariadb -uroot -proot somedatabase < dev/seed.sql

SET @@session.sql_mode = '';

INSERT INTO users (id, login, password, pw, realname, is_admin, loginFailureCount) VALUES
  (1, 'alice',   SHA1('password'), '', 'Alice Wavetable',  1, 0),
  (2, 'bob',     SHA1('password'), '', 'Bob Bassline',     0, 0),
  (3, 'carol',   SHA1('password'), '', 'Carol Chiptune',   0, 0),
  (4, 'dave',    SHA1('password'), '', 'Dave Drumkit',     0, 0),
  (5, 'erin',    SHA1('password'), '', 'Erin Envelope',    0, 0);

-- files: (id, user_id, filename, license_id, category, subcategory, description, insert_date, update_date, rate, size, hash, downloads)
INSERT INTO files (user_id, filename, license_id, category, subcategory, description, insert_date, size, hash, downloads) VALUES
  (1, 'funky_bassline.mmpz',       8,  1, 31, 'A four-on-the-floor bassline to noodle on.',         NOW() - INTERVAL 1  DAY,  20480, SHA1(RAND()), 142),
  (2, 'chip_anthem.mmp',           14, 1, 34, 'Square waves all the way down.',                     NOW() - INTERVAL 2  DAY,  10240, SHA1(RAND()),  87),
  (3, 'jazz_sketch.mmpz',          11, 1, 30, 'A noodly jazz sketch with brush kit.',               NOW() - INTERVAL 3  DAY,  30720, SHA1(RAND()),  33),
  (4, '808_kick_pack.wav',         8,  2, 40, 'Twelve fat 808 kicks.',                              NOW() - INTERVAL 5  DAY, 819200, SHA1(RAND()), 514),
  (5, 'ambient_pad.ogg',           9,  2, 36, 'A lush evolving pad in C.',                          NOW() - INTERVAL 7  DAY, 524288, SHA1(RAND()), 201),
  (1, 'reese_bass.xpf',            8,  3, 13, 'Classic Reese bass preset.',                         NOW() - INTERVAL 9  DAY,   4096, SHA1(RAND()),  76),
  (2, 'mellow_pad.xpf',            8,  3, 44, 'A warm analog-style pad preset.',                    NOW() - INTERVAL 11 DAY,   4096, SHA1(RAND()),  44),
  (3, 'arp_sequence.xpf',          8,  3, 49, 'A bright arpeggiator patch.',                        NOW() - INTERVAL 14 DAY,   4096, SHA1(RAND()),  29),
  (4, 'lmms_basics.tar.gz',        4,  4, 25, 'A getting-started tutorial bundle.',                 NOW() - INTERVAL 21 DAY, 1048576, SHA1(RAND()), 312),
  (5, 'dark_ui.tar.bz2',           14, 6, 60, 'A dark theme for LMMS.',                             NOW() - INTERVAL 30 DAY, 102400, SHA1(RAND()),  98),
  (1, 'midnight_house.mmpz',       11, 1, 31, 'A late-night house groove.',                         NOW() - INTERVAL 4  DAY,  25600, SHA1(RAND()),  17),
  (2, 'industrial_loop.mmp',       7,  1, 27, 'Crunchy industrial loop.',                           NOW() - INTERVAL 6  DAY,  18432, SHA1(RAND()),  62),
  (3, 'snare_collection.wav',      8,  2, 39, 'Snares from cardboard to cannon.',                   NOW() - INTERVAL 8  DAY, 614400, SHA1(RAND()), 188),
  (4, 'choir_oohs.ogg',            9,  2, 35, 'Choir oohs sampled at 48k.',                         NOW() - INTERVAL 10 DAY, 460800, SHA1(RAND()),  73),
  (5, 'plucked_harp.xpf',          14, 3, 50, 'A plucked harp preset.',                             NOW() - INTERVAL 13 DAY,   4096, SHA1(RAND()),  21);

-- realname column on files is selected by get_latest but not present in schema; harmless if absent.

INSERT INTO ratings (file_id, user_id, stars) VALUES
  (1,2,5),(1,3,4),(1,4,5),
  (2,1,4),(2,4,3),(2,5,5),
  (3,1,4),(3,2,5),
  (4,1,5),(4,2,5),(4,3,4),(4,5,5),
  (5,1,4),(5,2,4),
  (6,3,5),(6,4,4),
  (7,2,3),(7,5,4),
  (8,1,5),
  (9,2,5),(9,3,5),(9,4,4),
  (10,1,4),(10,2,5),
  (11,3,3),
  (12,1,2),(12,4,4),
  (13,5,5),(13,2,4),
  (14,1,4),
  (15,2,5),(15,3,5);

INSERT INTO comments (user_id, file_id, text) VALUES
  (2, 1, 'Groovy bassline, used it in a track already!'),
  (3, 1, 'Could use a bit more low end imo.'),
  (1, 4, 'These kicks slap. Thanks for sharing.'),
  (5, 4, 'Nice variety, will use the round-robin in dnb.'),
  (4, 5, 'Beautiful pad, very lush.'),
  (2, 9, 'This tutorial saved me hours, thanks!'),
  (3, 10, 'Loving this dark theme.'),
  (1, 12, 'Industrial vibes!'),
  (5, 13, 'Solid snare pack.');
