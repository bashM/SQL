--=================================================
-- Filename:      createTables.sql
-- Author:        Daniel Guenther (565154853)
-- Date:          2016-02-07
-- Institution:   VIU
-- Class:         CSCI 370
-- Project:       assignment3
-- Purpose:       create the tables necessary for testing of assignment3
--             I'm going to populate the tables as needed
--=================================================

-- == describe all tables (uncomment if needed
--desc customer;
--desc location;
--desc service;
--desc device;
--desc phone;
--desc call;

-- == ensure these tables can be used
-- (drops are called in reverse order of creation)
drop table call;
drop table phone;
drop table device;
drop table service;
drop table location;
drop table customer;

CREATE TABLE Customer (
      cid CHAR(9) PRIMARY KEY,
      name VARCHAR(20) NOT NULL,
      billingAddress VARCHAR(80)
      );

CREATE TABLE Location (
      areaCode CHAR(3) PRIMARY KEY,
      name VARCHAR(20) NOT NULL,
      description VARCHAR(256)
      ); 

CREATE TABLE Service (
      fromArea CHAR(3) REFERENCES Location,
      toArea CHAR(3) REFERENCES Location,
      price DECIMAL(10,2),
      PRIMARY KEY (fromArea, toArea)
      );

CREATE TABLE Device (
      areaCode CHAR(3) REFERENCES Location,
      deviceId CHAR(7),
      status int,
      PRIMARY KEY (areaCode, deviceId)
      );

CREATE TABLE Phone (
      areaCode CHAR(3),
      pNumber CHAR(7),
      address VARCHAR(80),
      deviceId CHAR(7),
      cid CHAR(9) REFERENCES Customer,
      PRIMARY KEY (areaCode, pNumber),
      FOREIGN KEY (areaCode, deviceId) REFERENCES Device
      );

CREATE TABLE Call (
      rid INT PRIMARY KEY,
      fromArea CHAR(3),
      fromNumber CHAR(7),
      toArea CHAR(3),
      toNumber CHAR(7),
      startDate DATE NOT NULL,
      startTime TIMESTAMP NOT NULL,
      duration int,
      FOREIGN KEY (fromArea, fromNumber) REFERENCES Phone,
      FOREIGN KEY (toArea, toNumber) REFERENCES Phone,
      FOREIGN KEY (fromArea, toArea) REFERENCES Service
      );
/*
insert into customer values (1, 'Marilyn Price', null);
insert into customer values (2, 'Ashley Davis', '82 Surrey Junction');
insert into customer values (3, 'Sharon Patterson', null);
insert into customer values (4, 'Stephen Burke', '62566 Division Terrace');
insert into customer values (5, 'Ronald Austin', '66429 Scott Court');
insert into customer values (6, 'Ryan Howard', '2780 Lighthouse Bay Alley');
insert into customer values (7, 'Chris Lewis', '9 La Follette Center');
insert into customer values (8, 'Maria West', null);
insert into customer values (9, 'Sharon Murray', '1324 Lyons Junction');
insert into customer values (10, 'Philip Schmidt', '2891 Grim Road');
insert into customer values (11, 'Denise Jones', '9 Autumn Leaf Park');
insert into customer values (12, 'Keith Rodriguez', '0 Bayside Place');
insert into customer values (13, 'Diane White', null);
insert into customer values (14, 'Jane Garza', '07976 Bluejay Plaza');
insert into customer values (15, 'Rebecca Ramirez', '33364 Magdeline Trail');
insert into customer values (16, 'Mark Shaw', '1 Messerschmidt Terrace');
insert into customer values (17, 'Diane Morrison', '4 Stephen Lane');
insert into customer values (18, 'Jonathan Duncan', '5424 Blaine Trail');
insert into customer values (19, 'John Elliott', '0 Moose Alley');
insert into customer values (20, 'Dorothy Perez', '5181 Truax Street');
insert into customer values (21, 'Clarence Ross', '30 Manley Trail');
insert into customer values (22, 'Dorothy Scott', null);
insert into customer values (23, 'Pamela Foster', '682 Lillian Hill');
insert into customer values (24, 'Fred Duncan', '28769 Arrowood Crossing');
insert into customer values (25, 'Norma Cox', null);
insert into customer values (26, 'Joshua Young', null);
insert into customer values (27, 'Walter Riley', '6 Fairview Road');
insert into customer values (28, 'Eugene Kelly', '8415 Stoughton Drive');
insert into customer values (29, 'Joe Myers', '4870 Trailsway Alley');
insert into customer values (30, 'Wanda Knight', '0323 Jenifer Point');
insert into customer values (31, 'Joan Nichols', '3635 Jana Way');
insert into customer values (32, 'Ruth Barnes', '55 Old Shore Alley');
insert into customer values (33, 'Willie Perez', null);
insert into customer values (34, 'Sara Payne', '9 Vahlen Alley');
insert into customer values (35, 'Kevin Payne', '1 Mcguire Avenue');
insert into customer values (36, 'Jean Wilson', '9972 Warbler Way');
insert into customer values (37, 'Rebecca Bishop', null);
insert into customer values (38, 'Andrea Jordan', '1770 Oak Terrace');
insert into customer values (39, 'Jennifer Rogers', '7 Continental Court');
insert into customer values (40, 'Stephen Arnold', '2 Brentwood Center');
insert into customer values (41, 'Justin Nelson', '8526 Corscot Place');
insert into customer values (42, 'Arthur Fuller', '2007 Forest Way');
insert into customer values (43, 'Charles Rose', '1633 Alpine Road');
insert into customer values (44, 'Pamela White', '455 Luster Circle');
insert into customer values (45, 'Heather Watkins', '77 Schiller Park');
insert into customer values (46, 'Kenneth Cook', '23553 Vidon Crossing');
insert into customer values (47, 'Jose Myers', '9 Old Shore Crossing');
insert into customer values (48, 'Martin Black', '5502 Waxwing Terrace');
insert into customer values (49, 'Kathleen Young', '243 Clarendon Point');
insert into customer values (50, 'Kenneth Burns', '6 Schlimgen Circle');
insert into customer values (51, 'Pamela Chavez', '91314 Towne Terrace');
insert into customer values (52, 'George Duncan', '85678 Ridgeview Way');
insert into customer values (53, 'Nicole Morris', '951 Emmet Lane');
insert into customer values (54, 'Mark Wells', null);
insert into customer values (55, 'Andrea Marshall', '8272 Leroy Drive');
insert into customer values (56, 'Ruby Graham', '16765 Kennedy Point');
insert into customer values (57, 'Nancy Smith', '31 Dunning Circle');
insert into customer values (58, 'Joshua Romero', null);
insert into customer values (59, 'Wanda Smith', '842 Fisk Street');
insert into customer values (60, 'Shirley Austin', '8052 Meadow Valley Lane');
insert into customer values (61, 'Billy Fisher', '362 Forest Run Hill');
insert into customer values (62, 'Frank Arnold', '69043 Namekagon Street');
insert into customer values (63, 'Gary Johnston', '65 Forster Pass');
insert into customer values (64, 'John Garcia', '2915 Mariners Cove Place');
insert into customer values (65, 'Michael Bailey', '7306 Spenser Way');
insert into customer values (66, 'Larry Jackson', '49946 Lyons Pass');
insert into customer values (67, 'Craig Payne', '82 Kinsman Court');
insert into customer values (68, 'Rachel Ramos', null);
insert into customer values (69, 'Juan Rose', '4 Evergreen Point');
insert into customer values (70, 'Bonnie Ortiz', '26055 Lighthouse Bay Point');
insert into customer values (71, 'Helen Hall', '351 Hoard Plaza');
insert into customer values (72, 'Diana Castillo', null);
insert into customer values (74, 'Kevin Stanley', '5 Dawn Hill');
insert into customer values (75, 'Fred Perry', '889 Farmco Street');
insert into customer values (76, 'Phillip Bowman', '76 East Street');
insert into customer values (77, 'Stephen Rice', '3 Elka Trail');
insert into customer values (78, 'Patricia Banks', '819 Everett Hill');
insert into customer values (79, 'Carlos Romero', '9 Londonderry Park');
insert into customer values (80, 'Harry Arnold', null);
insert into customer values (81, 'Emily Franklin', '22949 Arrowood Place');
insert into customer values (82, 'Phillip Cook', '35 Tennessee Alley');
insert into customer values (83, 'Alan Wallace', '089 Calypso Street');
insert into customer values (84, 'Harold Ray', '2 Alpine Avenue');
insert into customer values (85, 'Barbara Jacobs', '52866 Straubel Parkway');
insert into customer values (86, 'Elizabeth Harvey', null);
insert into customer values (87, 'Kathryn Cook', '2 Carberry Terrace');
insert into customer values (88, 'Jonathan Fowler', '2062 Kennedy Pass');
insert into customer values (89, 'Kenneth Martin', '59 Troy Center');
insert into customer values (90, 'Steve Adams', '63554 Grover Alley');
insert into customer values (91, 'Phyllis Dean', '72 John Wall Court');
insert into customer values (92, 'Marie Ellis', '1 Valley Edge Way');
insert into customer values (93, 'Matthew Freeman', null);
insert into customer values (94, 'Carolyn Simmons', '3996 Fieldstone Terrace');
insert into customer values (95, 'Adam Banks', '90 Warbler Terrace');
insert into customer values (96, 'Martha Andrews', '32543 Summit Place');
insert into customer values (97, 'Brenda Robertson', '789 Welch Alley');
insert into customer values (98, 'Rachel Russell', '376 Kensington Pass');
insert into customer values (99, 'Linda Murray', null);
insert into customer values (100, 'Rose Fox', '25559 Ramsey Pass');

insert into location (areaCode, name, description) values (492, 'Suruhan', null);
insert into location (areaCode, name, description) values (511, 'Chemal', null);
insert into location (areaCode, name, description) values (807, 'La Esperanza', null);
insert into location (areaCode, name, description) values (405, 'Jojoima', null);
insert into location (areaCode, name, description) values (529, 'Simitli', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.');
insert into location (areaCode, name, description) values (894, 'Zainsk', null);
insert into location (areaCode, name, description) values (427, 'Apucarana', null);
insert into location (areaCode, name, description) values (260, 'Qinshi', '');
insert into location (areaCode, name, description) values (222, 'Bagjasari', null);
insert into location (areaCode, name, description) values (319, 'Hronov', null);
insert into location (areaCode, name, description) values (227, 'Calgary', null);
insert into location (areaCode, name, description) values (802, 'Ostružnica', null);
insert into location (areaCode, name, description) values (268, 'Jianggezhuang', null);
insert into location (areaCode, name, description) values (965, 'Cinunjang', null);
insert into location (areaCode, name, description) values (160, 'Tourcoing', null);
insert into location (areaCode, name, description) values (123, 'Erfangping', null);
insert into location (areaCode, name, description) values (152, 'Paris 15', null);
insert into location (areaCode, name, description) values (259, 'Gorodishche', null);
insert into location (areaCode, name, description) values (12, 'Danxi', null);
insert into location (areaCode, name, description) values (959, 'Parque Industrial', null);
insert into location (areaCode, name, description) values (907, 'Tha Wang Pha', null);
insert into location (areaCode, name, description) values (310, 'Kaum', null);
insert into location (areaCode, name, description) values (906, 'Na Klang', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.');
insert into location (areaCode, name, description) values (253, 'Talmest', null);
insert into location (areaCode, name, description) values (776, 'Sada', '');
insert into location (areaCode, name, description) values (98, 'Guararé', null);
insert into location (areaCode, name, description) values (550, 'Wangsi', null);
insert into location (areaCode, name, description) values (866, 'Thị Trấn Thọ Xuân', null);
insert into location (areaCode, name, description) values (381, 'Bata Tengah', null);
insert into location (areaCode, name, description) values (188, 'Moneghetti', null);
insert into location (areaCode, name, description) values (145, 'Xom Tan Long', null);
insert into location (areaCode, name, description) values (718, 'Louiseville', null);
insert into location (areaCode, name, description) values (653, 'Shakhtars’k', null);
insert into location (areaCode, name, description) values (841, 'Dokolo', null);
insert into location (areaCode, name, description) values (427, 'Camalote', null);
insert into location (areaCode, name, description) values (98, 'Fengle', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into location (areaCode, name, description) values (627, 'Tân Châu', null);
insert into location (areaCode, name, description) values (512, 'Chotepe', null);
insert into location (areaCode, name, description) values (530, 'Oke Ila', null);
insert into location (areaCode, name, description) values (227, 'Ōhara', null);
insert into location (areaCode, name, description) values (16, 'Ramain', null);
insert into location (areaCode, name, description) values (590, 'Arrifes', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.');
insert into location (areaCode, name, description) values (169, 'Pytalovo', null);
insert into location (areaCode, name, description) values (187, 'Alegre', null);
insert into location (areaCode, name, description) values (176, 'Taungdwingyi', null);
insert into location (areaCode, name, description) values (749, 'Gonābād', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.');
insert into location (areaCode, name, description) values (942, 'Montalegre', null);
insert into location (areaCode, name, description) values (565, 'Wałcz', null);
insert into location (areaCode, name, description) values (7, 'Zaki Biam', null);
insert into location (areaCode, name, description) values (297, 'Namerikawa', null);
insert into location (areaCode, name, description) values (262, 'Xiaomei', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.');
insert into location (areaCode, name, description) values (624, 'Jiaoyang', null);
insert into location (areaCode, name, description) values (651, 'Souto da Costa', null);
insert into location (areaCode, name, description) values (992, 'São João das Lampas', null);
insert into location (areaCode, name, description) values (505, 'La Trinidad', null);
insert into location (areaCode, name, description) values (86, 'Thị Trấn Ngải Giao', null);
insert into location (areaCode, name, description) values (487, 'Newark', '');
insert into location (areaCode, name, description) values (101, 'Malishka', null);
insert into location (areaCode, name, description) values (274, 'Huating', '');
insert into location (areaCode, name, description) values (542, 'Beitou', null);
insert into location (areaCode, name, description) values (634, 'Kirovsk', null);
insert into location (areaCode, name, description) values (691, 'Xilian', null);
insert into location (areaCode, name, description) values (448, 'Marne-la-Vallée', null);
insert into location (areaCode, name, description) values (109, 'Monte Plata', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.');
insert into location (areaCode, name, description) values (660, 'Sanxiang', null);
insert into location (areaCode, name, description) values (114, 'Nadvoitsy', null);
insert into location (areaCode, name, description) values (203, 'Kauniainen', null);
insert into location (areaCode, name, description) values (5, 'Shapaja', null);
insert into location (areaCode, name, description) values (10, 'Jinshi', null);
insert into location (areaCode, name, description) values (626, 'Dado', null);
insert into location (areaCode, name, description) values (942, 'Tangjian', null);
insert into location (areaCode, name, description) values (190, 'Ol’gino', null);
insert into location (areaCode, name, description) values (457, 'Xintang', null);
insert into location (areaCode, name, description) values (585, 'Sibulan', null);
insert into location (areaCode, name, description) values (936, 'Wādī al ‘Uyūn', null);
insert into location (areaCode, name, description) values (650, 'Dianbu', null);
insert into location (areaCode, name, description) values (159, 'Ipala', '');
insert into location (areaCode, name, description) values (685, 'Corbeil-Essonnes', null);
insert into location (areaCode, name, description) values (462, 'Camilo Aldao', null);
insert into location (areaCode, name, description) values (772, 'Ten’gushevo', null);
insert into location (areaCode, name, description) values (603, 'Tashang', '');
insert into location (areaCode, name, description) values (720, 'Santa Teresa', null);
insert into location (areaCode, name, description) values (627, 'Bayḩān', null);
insert into location (areaCode, name, description) values (826, 'Norwalk', null);
insert into location (areaCode, name, description) values (894, 'Nol', null);
insert into location (areaCode, name, description) values (46, 'Mirny', null);
insert into location (areaCode, name, description) values (771, 'Grande Cache', null);
insert into location (areaCode, name, description) values (102, 'Longvic', null);
insert into location (areaCode, name, description) values (814, 'Jaboatão', null);
insert into location (areaCode, name, description) values (16, 'Milówka', null);
insert into location (areaCode, name, description) values (598, 'Jangheung', null);
insert into location (areaCode, name, description) values (14, 'Blatná', null);
insert into location (areaCode, name, description) values (999, 'Oemollo', null);
insert into location (areaCode, name, description) values (921, 'Bendosari', null);
insert into location (areaCode, name, description) values (750, 'Paterson', null);
insert into location (areaCode, name, description) values (101, 'San Francisco', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into location (areaCode, name, description) values (319, 'Morani', null);
insert into location (areaCode, name, description) values (970, 'Kendari', '');
insert into location (areaCode, name, description) values (38, 'Ţūlkarm', '');
insert into location (areaCode, name, description) values (954, 'Shuanggang', null);
*/
--Customer data:
insert into customer
values ('001', 'Jone Doe', '005 Main Street Alberta');

insert into customer
values ('002', 'Jane Donally', '8314 Columbia Street Victoria');

insert into customer
values ('003', 'Fred Test', '1111 Tan Street Duncan');

insert into customer
values ('004', 'Johnny Ericson', '1234 Finlay Road Vancouver');

--Location data:
insert into location
values ('250', 'Vancouver Island', 'Service area for Vancouver Island');

insert into location
values ('604', 'Lower Mainland', 'Service area for the lower mainland');

insert into location
values ('305', 'Alberta', 'Service area for the Alberta area');

--Service data:
insert into service
values ('250', '250', 0.1);

insert into service
values ('250', '305', 0.5);

insert into service
values ('250', '604', 0.2);

insert into service
values ('604', '604', 0.1);

insert into service
values ('604', '250', 0.2);

insert into service
values ('604', '305', 0.5);

insert into service
values ('305', '305', 0.1);

insert into service
values ('305', '250', 0.5);

insert into service
values ('305', '604', 0.5);

--Device data:
insert into device
values ('250', 'Vic1', 1);

insert into device
values ('250', 'Vic2', 0);

insert into device
values ('305', 'Alb1', 1);

insert into device
values ('305', 'Alb2', 1);

insert into device
values ('250', 'Dun1', 1);

insert into device
values ('250', 'Dun2', 1);

insert into device
values ('250', 'Dun3', 1);

insert into device
values ('604', 'Van1', 1);

insert into device
values ('604', 'Van2', 0);

--Phone data:
insert into phone
values ('305', '7771001', '005 Main Street Alberta', 'Alb1', '001');

insert into phone
values ('305', '7771002', '006 Main Street Alberta', 'Alb2', '001');

insert into phone
values ('250', '7401001', '1111 Tan Street Duncan', 'Dun1', '003');

insert into phone
values ('250', '7431001', '8314 Columbia Street Victoria', 'Vic1', '002');

insert into phone
values ('250', '7401002', '1112 Tan Street Duncan', 'Dun2', '003');

insert into phone
values ('250', '7401003', '1113 Tan Street Duncan', 'Dun3', '003');

insert into phone
values ('604', '6201001', '1234 Finlay Road Vancouver', 'Van1', '004');

--Call data:
insert into call
values (001, '305', '7771001', '604', '6201001', to_date('20-1-2015', 'dd-mm-yyyy'), to_timestamp('20-1-2015 08:00:00', 'dd-mm-yyyy HH24:Mi:SS'), 5);

insert into call
values (002, '305', '7771002', '250', '7431001', to_date('21-1-2015', 'dd-mm-yyyy'), to_timestamp('21-1-2015 10:00:00', 'dd-mm-yyyy HH24:Mi:SS'), 8);

insert into call
values (003, '250', '7401001', '250', '7431001', to_date('1-1-2015', 'dd-mm-yyyy'), to_timestamp('1-1-2015 11:00:00', 'dd-mm-yyyy HH24:Mi:SS'), 10);

insert into call
values (004, '250', '7401002', '250', '7431001', to_date('5-2-2015', 'dd-mm-yyyy'), to_timestamp('5-2-2015 13:00:00', 'dd-mm-yyyy HH24:Mi:SS'), 7);
insert into call
values (005, '641', '7401002', '250', '7431001', to_date('5-2-2015', 'dd-mm-yyyy'), to_timestamp('5-2-2015 13:00:00', 'dd-mm$

insert into call
values (008, '255', '7401066', '604', '6201001', to_date('7-3-2015', 'dd-mm-yyyy'), to_timestamp('7-3-2015 09:00:00', 'dd-mm$

insert into call
values (007, '778', '7701001', '305', '7771002', to_date('8-3-2015', 'dd-mm-yyyy'), to_timestamp('8-3-2015 10:00:00', 'dd-mm$






insert into call
values (009, '440', '7401003', '604', '6201001', to_date('7-3-2015', 'dd-mm-yyyy'), to_timestamp('7-3-2015 09:00:00', 'dd-mm-yyyy HH24:Mi:SS'), 10);

insert into call
values (077, '641', '777701', '305', '7771002', to_date('8-3-2015', 'dd-mm-yyyy'), to_timestamp('8-3-2015 10:00:00', 'dd-mm-yyyy HH24:Mi:SS'), 15);

