DROP DATABASE animalShelter;
CREATE DATABASE IF NOT EXISTS animalShelter;

grant all privileges on animalShelter.* to 'webapp'@'%';
flush privileges;

USE animalShelter;

CREATE TABLE IF NOT EXISTS volunteerCoordinator(
    coordinator_id INTEGER UNIQUE NOT NULL,
    work_email VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    number_volunteers INTEGER NOT NULL,
    PRIMARY KEY (coordinator_id)
);

CREATE TABLE IF NOT EXISTS receptionist (

    floor INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    language VARCHAR(50) NOT NULL,
    work_email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    coordinator_id INTEGER NOT NULL,
    employee_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (employee_id),
    CONSTRAINT coordID
       FOREIGN KEY (coordinator_id) REFERENCES volunteerCoordinator(coordinator_id)
);

CREATE TABLE IF NOT EXISTS CaretakerVolunteer
(
    work_email    VARCHAR(50) NOT NULL,
    experience     INTEGER     NOT NULL,
    caretaker_id   INTEGER     UNIQUE NOT NULL,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    animal_specialty VARCHAR(50) NOT NULl,
    coordinator_id INTEGER NOT NULL,
    PRIMARY KEY (caretaker_id),
    CONSTRAINT coordIDC
        FOREIGN KEY (coordinator_id) REFERENCES volunteerCoordinator(coordinator_id)
);

CREATE TABLE IF NOT EXISTS OperationVolunteer
(
    operation_id INTEGER UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    work_email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    coordinator_id INTEGER NOT NULL,
    PRIMARY KEY (operation_id),
    CONSTRAINT opID
        FOREIGN KEY (coordinator_id) REFERENCES volunteerCoordinator(coordinator_id)
);

CREATE TABLE IF NOT EXISTS AnimalInventory (
    brand VARCHAR(50) NOT NULL,
    quantity INTEGER NOT NULL,
    item_category VARCHAR(50) NOT NULL,
    date_received VARCHAR(50) NOT NULL,
    operation_id INTEGER NOT NULL,
    item_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(item_id),
    CONSTRAINT opIDAI
        FOREIGN KEY (operation_id) REFERENCES OperationVolunteer(operation_id)
);

CREATE TABLE IF NOT EXISTS Donor (
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    donation_amount FLOAT(2) NOT NULL,
    operation_id INTEGER NOT NULL,
    donation_id INTEGER NOT NULL,
    PRIMARY KEY(donation_id),
    CONSTRAINT opIDD
        FOREIGN KEY (operation_id) REFERENCES OperationVolunteer(operation_id)
);

CREATE TABLE IF NOT EXISTS Visitor (
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    visit_time DATETIME NOT NULL,
    animal_interest VARCHAR(50) NOT NULL,
    PRIMARY KEY(visit_time, last_name)
);

CREATE TABLE IF NOT EXISTS Rec_Vis(
    employee_id INTEGER NOT NULL,
    visit_time DATETIME NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_id, visit_time, last_name),
    CONSTRAINT empID
        FOREIGN KEY (employee_id) REFERENCES receptionist (employee_id),
    CONSTRAINT vLlN
        FOREIGN KEY (visit_time, last_name) REFERENCES Visitor (visit_time, last_name)
);

CREATE TABLE IF NOT EXISTS vetClinician (
    vetID INTEGER UNIQUE NOT NULL,
    field_concentration VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    work_email VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    degree VARCHAR(50) NOT NULL,
    PRIMARY KEY(vetID)
);


CREATE TABLE IF NOT EXISTS veterinaryNurse (
    nurseID INTEGER UNIQUE NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    work_email VARCHAR(50) NOT NULL,
    qualification VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    vet_id INTEGER NOT NULL,
    PRIMARY KEY(nurseID),
    CONSTRAINT vID
        FOREIGN KEY (vet_id) REFERENCES vetClinician(vetID)
);

CREATE TABLE IF NOT EXISTS dog (
    location INTEGER NOT NULL,
    walk_duration INTEGER NOT NULL,
    group_play_time VARCHAR(50) NOT NULL,
    need_food BOOLEAN NOT NULL,
    need_clean BOOLEAN NOT NULL,
    need_walk BOOLEAN NOT NULL,
    name_dog VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    chip_status BOOLEAN NOT NULL,
    breed VARCHAR(50) NOT NULL,
    weight INTEGER NOT NULL,
    housebroken BOOLEAN NOT NULL,
    temperament BOOLEAN NOT NULL,
    dietary_restriction VARCHAR(50) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    caretaker_id INTEGER NOT NULL,
    vet_id INTEGER NOT NULL,
    dog_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(dog_id),
    CONSTRAINT caretakeID
        FOREIGN KEY (caretaker_id) REFERENCES CaretakerVolunteer(caretaker_id),
    CONSTRAINT vetid
        FOREIGN KEY (vet_id)  REFERENCES vetClinician(vetID)
);

CREATE TABLE IF NOT EXISTS cat (
    catID INTEGER UNIQUE NOT NULL,
    location INTEGER NOT NULL,
    need_food BOOLEAN NOT NULL,
    need_litter_cleaning BOOLEAN NOT NULL,
    breed VARCHAR(50) NOT NULL,
    chip_status BOOLEAN NOT NULL,
    name_cat VARCHAR(50) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    neutered BOOLEAN NOT NULL,
    temperament BOOLEAN NOT NULL,
    dietary_restrictions VARCHAR(50) NOT NULL,
    weight INTEGER NOT NULL,
    caretaker_id INTEGER NOT NULL,
    vet_id INTEGER NOT NULL,
    PRIMARY KEY (catID),
    CONSTRAINT careID
        FOREIGN KEY (caretaker_id) REFERENCES CaretakerVolunteer(caretaker_id),
    CONSTRAINT vIDCat
        FOREIGN KEY (vet_id) REFERENCES vetClinician(vetID)
);

CREATE TABLE IF NOT EXISTS supplier (
    supplierID INTEGER UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    service_rep_email VARCHAR(50) UNIQUE NOT NULL,
    service_rep_phone_number VARCHAR(15) UNIQUE NOT NULL,
    operation_id INTEGER NOT NULL,
    PRIMARY KEY(supplierID),
    CONSTRAINT opIDSupplier
        FOREIGN KEY (operation_id) REFERENCES OperationVolunteer(operation_id)
);


-- Inputting data for table 'volunteerCoordinator'

INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('chalhead0@sakura.ne.jp','Charlot','Halhead','757-961-4691',51,1);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('cmarlen1@slideshare.net','Caroline','Marlen','309-552-5448',82,2);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('ccausnett2@scribd.com','Constantina','Causnett','735-854-0647',8,3);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('emeehan3@go.com','Ellery','Meehan','664-328-3010',15,4);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('kalkin4@nytimes.com','Keefe','Alkin','624-699-5196',64,5);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('ldady5@comcast.net','Leelah','Dady','560-543-9009',80,6);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('wartrick6@ox.ac.uk','Worth','Artrick','425-231-6677',10,7);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('btailour7@latimes.com','Barrie','Tailour','121-262-8106',91,8);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('slarkby8@histats.com','Starr','Larkby','379-816-2906',49,9);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('lmaclaren9@linkedin.com','Luz','MacLaren','506-191-1702',95,10);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('gpitkeathlya@bbc.co.uk','Gayle','Pitkeathly','649-896-3283',82,11);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('ggylleb@taobao.com','Gertrude','Gylle','137-256-4137',84,12);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('smerrickc@sfgate.com','Sabrina','Merrick','194-968-0296',22,13);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('sboichatd@kickstarter.com','Sheelagh','Boichat','543-994-5819',79,14);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('afairholmee@histats.com','Alic','Fairholme','201-272-5204',96,15);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('hstedallf@xing.com','Helga','Stedall','539-621-5056',90,16);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('dasbreyg@dagondesign.com','Dot','Asbrey','495-129-0539',1,17);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('agrisardh@vk.com','Allistir','Grisard','345-819-6090',82,18);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('lheadechi@paypal.com','Lexi','Headech','307-339-0289',39,19);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('nwoollerj@time.com','Nanice','Wooller','556-227-4739',82,20);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('shekk@netscape.com','Siana','Hek','493-452-4075',36,21);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('breditl@technorati.com','Blane','Redit','835-240-6864',70,22);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('hpotterym@unblog.fr','Harmonie','Pottery','482-796-6108',28,23);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('habban@wired.com','Hoebart','Abba','679-808-2530',30,24);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('fgerdtso@wp.com','Forester','Gerdts','490-345-7177',18,25);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('fstrewthersp@wordpress.com','Forrester','Strewthers','323-673-2301',89,26);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('jleifq@irs.gov','Joela','Leif','918-404-9140',16,27);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('jwaringr@skype.com','Jany','Waring','809-340-8444',93,28);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('eheimess@nsw.gov.au','Emmalynn','Heimes','257-811-3986',66,29);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('kcozzit@hhs.gov','Kelci','Cozzi','199-625-0660',75,30);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('cbootu@dedecms.com','Corty','Boot','570-227-0180',80,31);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('bsoanev@narod.ru','Britni','Soane','840-660-0506',68,32);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('dshimmanw@people.com.cn','Danya','Shimman','453-626-4264',57,33);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('ctatchellx@businesswire.com','Charlotte','Tatchell','423-912-6695',44,34);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('mmoreinisy@upenn.edu','Maxy','Moreinis','555-412-2405',20,35);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('dholmez@exblog.jp','Daron','Holme','256-643-0092',25,36);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('rworms10@cam.ac.uk','Randall','Worms','516-941-5583',98,37);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('mdobrowski11@is.gd','Marnia','Dobrowski','577-659-0313',1,38);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('asheddan12@netlog.com','Arabela','Sheddan','291-298-5407',100,39);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('cheadrick13@bing.com','Caroline','Headrick','283-379-3683',63,40);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('csimonnin14@de.vu','Charin','Simonnin','992-266-9450',36,41);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('gsutcliffe15@smh.com.au','Gizela','Sutcliffe','448-499-9608',48,42);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('nyann16@wiley.com','Nelie','Yann','879-359-4514',75,43);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('ebiskupiak17@ted.com','Eberhard','Biskupiak','494-107-6589',30,44);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('djanodet18@instagram.com','Danya','Janodet','887-351-2779',79,45);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('lredmain19@skyrock.com','Lanny','Redmain','649-329-7832',41,46);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('epurvey1a@reverbnation.com','Elisabeth','Purvey','621-123-1585',95,47);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('evivyan1b@marriott.com','Erik','Vivyan','141-294-1604',71,48);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('lkeam1c@dion.ne.jp','Louella','Keam','993-927-4868',17,49);
INSERT INTO volunteerCoordinator(work_email,first_name,last_name,phone_number,number_volunteers,coordinator_id) VALUES ('rlowndsborough1d@reverbnation.com','Rosalynd','Lowndsborough','392-244-2588',94,50);


-- Inputting data for table 'receptionist'

INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Luca','Lodemann','Malayalam','llodemann0@facebook.com','334-767-3815',19,1);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Janel','Dibdale','Lao','jdibdale1@forbes.com','445-710-8526',48,2);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Rock','Davidai','Burmese','rdavidai2@de.vu','659-205-7166',6,3);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Wayland','Moncrieffe','Māori','wmoncrieffe3@zimbio.com','304-748-1993',30,4);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Dulcea','Ledingham','Dutch','dledingham4@comsenz.com','900-308-6014',39,5);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Christina','Mayou','Malayalam','cmayou5@uiuc.edu','428-826-4791',18,6);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Reynard','Malenfant','Khmer','rmalenfant6@hao123.com','627-815-9950',32,7);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Othello','Dane','Kashmiri','odane7@artisteer.com','465-724-8513',31,8);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Kordula','Mills','Zulu','kmills8@topsy.com','155-469-8211',27,9);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Brian','Philpots','Tsonga','bphilpots9@microsoft.com','748-661-4176',11,10);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Rois','Bentsen','Latvian','rbentsena@ustream.tv','666-927-0682',42,11);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Jacinthe','Grunwall','Tamil','jgrunwallc@reference.com','980-364-3124',39,13);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Trevar','Levensky','Finnish','tlevenskyd@bing.com','401-193-1604',29,14);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Nonah','Snook','Latvian','nsnooke@yellowbook.com','365-837-3157',35,15);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Merrill','Lehrer','Filipino','mlehrerf@cyberchimps.com','980-847-7969',5,16);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Leopold','Tappin','Oriya','ltapping@dagondesign.com','959-167-9445',45,17);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Monty','McTavy','Lao','mmctavyh@geocities.jp','715-713-6709',3,18);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Colin','Dunston','Belarusian','cdunstoni@nasa.gov','849-549-5546',34,19);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Marcy','Blackborne','Kyrgyz','mblackbornej@dion.ne.jp','582-292-0470',7,20);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Burton','Arendt','Somali','barendtk@163.com','428-160-8833',45,21);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Carlos','Southeran','Malayalam','csoutheranl@hp.com','238-960-0441',8,22);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Tadeas','Thandi','Kashmiri','tthandim@arizona.edu','612-617-7684',6,23);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Reena','Wherrit','Aymara','rwherritn@ucsd.edu','750-680-7773',3,24);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Moselle','Goutcher','Gujarati','mgoutchero@netscape.com','422-555-8261',32,25);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Deedee','Tritten','Macedonian','dtrittenp@e-recht24.de','410-990-4430',38,26);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Papageno','Kuhne','Haitian Creole','pkuhneq@vk.com','176-757-6975',1,27);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Lorry','Brunnen','Malay','lbrunnenr@wisc.edu','111-727-2666',25,28);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Roana','Ericsson','Korean','rericssons@geocities.jp','584-191-0032',5,29);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Natty','McCooke','Malay','nmccooket@live.com','429-438-6793',4,30);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Lissi','Pickup','Hungarian','lpickupu@hp.com','460-996-5806',28,31);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Rachel','Innocenti','Quechua','rinnocentiv@tiny.cc','227-833-8517',42,32);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Claudina','Blest','Tsonga','cblestw@google.de','135-648-6750',6,33);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Marlyn','Goldin','New Zealand Sign Language','mgoldinx@paypal.com','676-724-5748',41,34);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Ros','MacSweeney','Kashmiri','rmacsweeneyy@hibu.com','735-418-0899',28,35);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Earvin','Roly','Hiri Motu','erolyz@example.com','978-412-5295',42,36);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Wenonah','Skarman','Greek','wskarman10@abc.net.au','938-444-1153',1,37);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Lee','Kneebone','Montenegrin','lkneebone11@sfgate.com','923-917-9261',46,38);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Mitchell','Fortesquieu','Dzongkha','mfortesquieu12@soundcloud.com','949-854-5922',10,39);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Leia','Jillions','Hindi','ljillions13@bandcamp.com','387-894-5390',24,40);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Orsola','Coot','Filipino','ocoot14@posterous.com','609-797-5762',48,41);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Hadria','Hornbuckle','West Frisian','hhornbuckle15@dailymotion.com','552-871-2883',20,42);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Munroe','Chetham','Czech','mchetham16@hc360.com','462-228-6277',28,43);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Ezekiel','Clemens','Tswana','eclemens17@163.com','843-105-7038',34,44);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Gussi','Keeney','Oriya','gkeeney18@bbc.co.uk','820-281-3104',32,45);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (2,'Cecilia','Trout','Assamese','ctrout19@ustream.tv','702-510-4596',45,46);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Ami','Faltin','Kannada','afaltin1a@statcounter.com','638-806-4674',15,47);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Ailee','Burrage','Aymara','aburrage1b@examiner.com','584-562-4139',33,48);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Andrei','Lethieulier','Aymara','alethieulier1c@themeforest.net','209-906-1189',27,49);
INSERT INTO receptionist(floor,first_name,last_name,language,work_email,phone_number,coordinator_id,employee_id) VALUES (1,'Aldus','McGuiness','Indonesian','amcguiness1d@google.cn','918-922-9504',47,50);



-- Inputting data into table 'Visitor'

INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Hartley','Hoy','495-537-5266',76,'2022-07-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Myca','Burfoot','906-324-8012',51,'2022-05-27');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Adrian','Anthiftle','131-195-9888',86,'2022-11-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Phyllys','Dongate','959-302-0469',23,'2022-10-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Hermann','Broune','212-168-0542',12,'2023-04-14');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Loria','Morefield','247-661-2490',12,'2022-05-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Gennie','Dumbelton','934-791-3059',23,'2023-03-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Martha','Creber','993-565-1942',59,'2023-03-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ogden','Radcliffe','859-972-1391',56,'2022-12-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Selma','Kilbane','718-424-9997',21,'2023-02-08');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Hasty','Hulks','642-668-8419',45,'2023-02-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Junia','Sudell','515-449-9667',22,'2022-08-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Dorine','Hauger','784-230-5563',62,'2022-12-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Nestor','Snoddon','751-441-0659',21,'2023-04-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Bradly','Mandel','141-666-3000',40,'2023-01-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Codi','Westbury','672-735-1940',59,'2022-05-08');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Marna','Nevins','187-996-6205',1,'2022-07-08');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rubina','Goligher','527-351-2777',26,'2023-02-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Germana','Snedden','253-222-3509',47,'2023-01-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Wade','Colhoun','205-717-7722',95,'2022-05-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Thebault','Semper','665-966-3036',55,'2022-05-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ivette','Crosfeld','639-926-2356',56,'2022-09-17');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Johannah','Inold','198-454-0451',87,'2022-06-14');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Blair','Shortell','394-983-6525',79,'2023-02-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Maurizio','Epps','610-263-4038',17,'2022-06-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Darb','Dolling','146-169-9456',98,'2022-08-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Garret','Madgin','431-672-2493',90,'2022-07-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jory','Timberlake','387-375-5944',15,'2022-08-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ase','Garie','165-466-9321',38,'2023-01-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Crichton','Deacock','863-975-0452',58,'2022-08-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Alyda','Janeway','288-156-2016',72,'2022-10-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Sherlocke','Oakey','916-369-6726',63,'2022-11-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Beulah','Hessentaler','778-789-4574',71,'2022-10-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Randell','Starkey','866-478-1309',91,'2022-05-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Chelsae','Saggs','115-547-8564',68,'2022-11-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Janos','Tyhurst','626-952-4377',83,'2022-12-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Emmi','Lalonde','209-614-1591',60,'2023-03-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Nealon','Mart','123-914-8178',62,'2022-04-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Linda','Schubbert','372-254-0824',62,'2022-12-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Kathlin','Curdell','897-210-1864',95,'2023-02-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Kacy','Dunk','711-169-7605',48,'2023-02-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Vivyan','Keesman','948-693-8247',80,'2022-06-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Prudence','Lulham','852-393-2643',100,'2022-11-08');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Suzy','Taggett','391-826-9573',22,'2022-06-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ivory','Wortman','403-925-5479',100,'2022-04-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Evie','Matessian','145-295-7143',80,'2022-05-21');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Waylan','Kilbane','535-561-8820',29,'2022-07-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Manfred','Buntin','909-888-8805',7,'2022-07-17');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tomas','Loche','947-846-5966',97,'2022-04-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Siobhan','Petegre','650-527-7348',9,'2022-10-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ericka','Roxburch','979-202-6394',67,'2022-08-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Auria','Lowers','516-360-7996',17,'2023-03-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Querida','Timoney','498-744-3980',21,'2022-05-21');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ingeberg','Hatherell','596-251-4135',85,'2022-05-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Nahum','Louder','109-371-9640',79,'2023-02-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Guillermo','Piell','897-493-4080',36,'2022-12-31');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Calhoun','Dowker','683-105-8659',13,'2022-06-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cassandry','Brind','725-589-9415',89,'2022-09-21');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Finn','Cripin','562-474-0186',78,'2023-03-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Aurthur','Camier','297-818-6883',33,'2022-06-17');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Sandor','Persent','771-347-8688',67,'2023-01-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jarib','Dearman','728-533-7788',98,'2022-07-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Melvyn','Cereceres','393-361-9458',51,'2022-09-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tessi','Odegaard','769-394-6157',27,'2022-04-17');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ray','Kringe','558-723-8657',2,'2022-08-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rosaleen','Klima','765-430-5032',34,'2022-11-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rodrique','Sneath','576-402-8862',50,'2022-07-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Maude','Whorf','364-135-3276',10,'2022-04-17');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Isa','Newns','248-425-6278',78,'2022-09-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Herbie','Verriour','217-630-2745',29,'2023-04-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Luise','Gillbe','469-221-7689',86,'2023-01-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Florri','Presidey','133-710-6320',39,'2022-09-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Avrom','Brome','501-483-7527',41,'2023-03-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Manda','Harwin','831-389-1257',12,'2022-12-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Garwood','Lehrle','550-755-6019',92,'2022-08-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cathrin','Ottery','135-282-2669',48,'2022-08-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Morey','Gyngell','329-523-9126',61,'2022-12-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Maddy','Becconsall','850-402-4289',79,'2022-12-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Orsola','Tather','498-396-8746',21,'2022-04-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Michele','Tunstall','518-463-6596',56,'2023-01-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Shirley','Fritter','751-357-2665',100,'2023-02-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lotti','Cockarill','490-704-5638',91,'2022-10-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Otes','Morot','514-256-5103',46,'2022-08-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Zachary','Ramme','439-797-2298',91,'2022-12-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Engelbert','Mewe','413-182-9339',75,'2023-02-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Denny','Dubbin','220-790-5257',51,'2022-09-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Wright','Attack','169-124-0638',69,'2022-09-23');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Hermione','Coche','339-131-5874',97,'2023-04-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Daphne','Howels','474-448-3893',73,'2022-08-31');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Minerva','Annear','889-376-2794',96,'2022-08-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cristie','Conyer','314-863-9574',1,'2022-06-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Elias','Rousel','845-633-9525',25,'2023-03-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rosanne','Rigmond','560-517-2565',63,'2022-07-31');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Axel','Garnsworth','504-617-3892',22,'2022-06-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Laurel','Cow','637-876-7030',78,'2022-07-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Shaylynn','Smaile','131-397-4660',3,'2022-07-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Albert','Peverell','854-185-0851',34,'2022-07-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Carrissa','Dutton','426-480-5986',52,'2022-07-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Nelli','Geerdts','905-991-8141',74,'2022-11-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lemmie','Cherry Holme','440-624-5241',77,'2023-04-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rebbecca','Lansdowne','788-758-6358',95,'2022-12-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jacqui','Knobell','765-855-2828',96,'2023-02-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Thorsten','Titterrell','689-833-5511',24,'2022-09-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Marianne','Wylder','188-425-0342',94,'2022-08-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Sterne','Domenici','635-450-0426',28,'2022-06-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Frederic','Alten','167-739-1249',44,'2023-02-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Fanny','Braunter','496-335-8944',56,'2022-12-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Pat','Rimmington','994-432-1130',93,'2022-06-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Hewie','Keaton','777-620-9773',51,'2022-07-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Leandra','Whorlton','564-263-9169',67,'2023-01-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Clare','Heater','920-738-4378',1,'2022-12-08');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Domeniga','Downs','461-849-5255',1,'2023-02-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Wake','Szymaniak','718-553-0822',100,'2022-10-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Trefor','Dufer','658-988-2786',39,'2022-06-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Howard','Bridson','119-795-0102',23,'2022-09-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Alice','Bolver','799-917-4865',21,'2022-06-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Venus','St Ange','906-153-6673',48,'2023-04-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tamma','Breem','507-434-1794',50,'2022-08-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Stace','Dufton','698-760-5819',84,'2023-01-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Julissa','Milius','256-717-8836',23,'2022-04-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Dori','Reace','538-820-2069',43,'2022-07-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lynelle','Kleinplatz','657-658-0946',6,'2022-09-04');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rosalia','Vigietti','182-301-9418',37,'2022-10-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Laurette','O''Brian','525-512-1952',80,'2023-01-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Phillida','Bownes','659-589-2365',58,'2023-01-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Vin','Instock','821-737-3685',98,'2022-06-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jessika','Lisett','839-109-4372',98,'2022-10-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Sula','Adshed','345-111-0385',56,'2022-12-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Inesita','Moss','823-614-2005',50,'2022-08-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Brandi','Bentje','266-548-0161',13,'2022-12-21');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Bonny','Huckel','748-935-5719',79,'2023-01-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Mara','McCaughren','915-137-8755',58,'2022-08-08');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Elora','Labeuil','524-414-8150',80,'2022-04-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tim','Greenwood','777-149-8201',72,'2022-06-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Alick','Fear','122-528-7544',80,'2023-01-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lindy','Wandrey','151-538-1582',48,'2023-03-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Grange','Farnaby','530-864-8945',33,'2022-11-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lenee','Siley','266-106-6281',33,'2023-03-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Goldina','Simonutti','544-402-7218',99,'2023-02-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rea','Rastrick','278-133-1424',33,'2023-01-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Merrili','Scholtz','131-881-0193',100,'2022-07-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Augie','Inseal','163-727-6184',95,'2022-10-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lu','Boeter','923-697-4371',37,'2022-08-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tomaso','Ballham','353-650-0530',47,'2022-05-31');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Nicholle','Bunstone','580-893-1498',69,'2022-05-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Catina','O''Rourke','857-728-1398',100,'2022-10-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tamera','Najera','273-290-6794',53,'2022-12-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Mayor','Minnis','382-382-2080',42,'2022-11-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Mary','Swatton','652-632-7489',66,'2022-10-27');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Arlette','Gjerde','606-251-1000',58,'2023-03-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jesse','Stave','842-373-7035',26,'2022-12-23');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Paulita','Jovasevic','235-564-8809',71,'2022-12-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Edd','Langdridge','552-790-9454',90,'2022-05-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Roger','Postill','193-627-5190',1,'2022-04-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Heidi','Putton','756-923-6290',39,'2022-07-04');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('West','Yesenin','648-242-9190',10,'2023-04-14');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Nicky','Merrgen','172-601-1654',54,'2022-07-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ezmeralda','Klimas','110-605-3647',99,'2023-02-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lilas','Pawfoot','472-445-7967',64,'2023-03-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Andee','Blees','340-830-4043',48,'2023-03-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Erina','Tingey','343-589-9847',60,'2023-04-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Valaria','McChesney','706-192-4028',57,'2023-02-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Winifred','Bus','235-320-6147',2,'2022-05-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Gratia','Clay','943-617-8486',77,'2022-12-31');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Edee','Oakly','681-438-1676',78,'2022-09-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Patty','Fiske','818-247-2121',45,'2022-09-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Abdel','Taysbil','114-540-7710',87,'2023-03-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Velvet','Wakerley','899-197-7922',28,'2022-11-07');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Dara','Arthan','871-466-4737',24,'2022-06-04');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Whit','Howgate','299-942-7240',70,'2023-01-21');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Andres','Lundbeck','287-497-7334',39,'2022-10-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Burty','Hartle','940-630-1459',88,'2022-09-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ellie','Mathiassen','318-458-7745',99,'2022-06-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Alanna','Gascard','869-329-0509',29,'2022-07-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cris','Oglesbee','955-272-8610',60,'2023-01-23');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Barny','Devonish','122-311-6614',83,'2022-09-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Aile','Bowling','878-136-5281',62,'2023-02-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tony','Blucher','896-951-7510',35,'2022-11-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cariotta','Bancroft','226-953-3626',39,'2022-11-11');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ilyse','Giffon','528-522-9253',82,'2022-12-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Candie','Wabersich','874-657-2307',63,'2023-04-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Olvan','Giron','318-516-0922',78,'2022-07-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Richardo','Spraggs','862-660-4765',25,'2023-04-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Eirena','Lampel','626-430-7035',65,'2022-06-05');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Neal','Ambrozewicz','615-909-0935',52,'2022-11-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rozamond','Sherington','151-306-3260',73,'2023-03-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Raul','Mc Trusty','211-201-4395',28,'2022-04-27');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Carline','McKinstry','149-138-7463',44,'2022-05-14');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Marita','Purkins','455-910-1364',8,'2022-10-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Chandler','Tookill','101-127-0205',76,'2022-12-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Bee','Dimitrijevic','916-591-5892',54,'2023-03-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Norma','Amorts','163-339-6070',51,'2022-08-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Celestine','Gallen','303-894-5474',30,'2022-07-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Bellina','Birkenshaw','517-903-1551',48,'2022-06-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Haydon','Abrami','280-212-2552',58,'2023-01-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Dare','Buttriss','978-852-9678',13,'2022-10-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jasmin','Milesap','476-484-8935',74,'2022-08-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Derrek','Poznan','206-780-4978',39,'2022-08-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('June','Adolthine','540-305-8112',5,'2023-03-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Marice','Barensky','958-973-0935',18,'2023-02-21');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Torrey','McNickle','964-938-2724',63,'2023-01-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Fabien','Winscom','990-473-8051',86,'2022-12-04');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jena','Ewings','349-536-1283',77,'2022-12-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cissy','Lavies','934-482-2281',63,'2022-09-23');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Taryn','Cantu','708-353-0141',85,'2022-05-25');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Camella','Tunn','952-239-3247',5,'2022-05-12');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Wesley','Keher','162-813-0318',30,'2022-07-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Torrin','Wye','797-496-6103',6,'2022-10-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lolita','Durrett','298-757-3200',54,'2022-11-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Dyanne','Clemmens','642-336-2805',95,'2022-04-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Benjy','Wadge','127-126-9332',17,'2023-03-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rhoda','Nisuis','812-517-3814',90,'2022-10-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Auguste','Ben-Aharon','943-910-4637',95,'2022-08-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Row','Gailor','968-474-4998',56,'2022-06-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Mikol','Reinbach','857-750-1998',69,'2022-06-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Clarette','Andrichak','961-766-3989',61,'2022-12-04');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Harlie','Rustadge','813-228-5188',82,'2022-12-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Geri','Matthessen','986-129-7155',99,'2022-09-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Evered','Hitter','190-942-2810',46,'2022-06-23');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Claudianus','Cardiff','476-152-7935',12,'2022-08-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Juieta','Fiddeman','935-469-1143',20,'2022-12-15');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lory','Gilders','722-387-2982',68,'2022-09-20');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Joana','Cubin','273-753-7540',41,'2023-02-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Sampson','Attack','230-378-9381',59,'2022-08-27');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Caria','Shard','216-496-3192',58,'2022-05-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Frants','Bythway','663-371-9499',95,'2022-09-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Lanita','Jeannel','693-613-9708',23,'2022-07-16');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Finley','Alman','825-554-4940',59,'2023-04-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Hayyim','Snibson','891-483-3435',40,'2022-05-24');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Timmie','Nodes','902-775-4345',15,'2022-05-02');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Rodney','Devericks','678-722-9042',27,'2022-07-28');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Dorisa','Stirley','311-176-8588',27,'2022-09-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Egon','Wimsett','937-779-4563',38,'2023-01-22');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Jaimie','Kubera','863-340-1170',46,'2022-05-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Madalena','Artois','735-529-4656',41,'2022-05-04');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Mattheus','Fonso','118-576-2189',72,'2023-02-26');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Joyous','Sampson','698-381-9498',92,'2022-07-03');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Quintana','Newland','510-852-2111',80,'2022-08-13');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Netty','Heliar','598-674-3774',18,'2022-12-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Cad','Comins','655-368-0161',34,'2022-12-06');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Elenore','Trethowan','893-788-5395',33,'2023-01-01');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Elsbeth','McCreedy','587-570-2130',19,'2022-07-29');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Beaufort','Lavell','835-990-2129',95,'2022-12-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Felicle','Starton','831-794-8000',57,'2022-11-10');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Devondra','Lissandri','708-456-2658',21,'2022-10-19');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Demetri','Calcraft','865-555-2365',50,'2022-08-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Timmy','Lochead','780-247-4612',3,'2022-12-09');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Tine','Briars','120-104-5548',85,'2023-03-30');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Ninnetta','Skyram','975-332-4570',40,'2022-06-18');
INSERT INTO Visitor(first_name,last_name,phone_number,animal_interest,visit_time) VALUES ('Phillip','Ferrarello','868-403-7575',18,'2022-12-31');


-- Inputting data into Rec_Vis

INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (27,'2022-12-31','Ferrarello');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (35,'2023-01-21','Howgate');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (50,'2023-03-22','Wadge');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (33,'2023-02-08','Kilbane');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (43,'2022-05-21','Matessian');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (34,'2023-01-11','O''Brian');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (31,'2022-10-25','O''Rourke');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (29,'2022-09-10','Cereceres');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (37,'2022-10-25','Cockarill');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (40,'2023-01-06','Fear');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (36,'2022-11-07','Wakerley');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (4,'2022-06-04','Arthan');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (38,'2022-08-30','Calcraft');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (20,'2022-06-23','Hitter');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (40,'2022-11-13','Minnis');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (39,'2022-07-11','Scholtz');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (43,'2023-02-26','Hulks');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (7,'2022-11-13','Durrett');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (16,'2022-12-04','Andrichak');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (14,'2022-05-22','Semper');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (5,'2022-12-30','Tookill');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (50,'2022-04-26','Clemmens');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (18,'2022-08-25','Ottery');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (13,'2022-09-30','Bythway');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (39,'2023-01-13','Gillbe');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (1,'2022-05-26','Bunstone');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (9,'2022-11-01','Geerdts');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (3,'2023-03-19','Gjerde');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (4,'2022-11-08','Lulham');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (43,'2022-09-22','Titterrell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (35,'2022-10-10','Vigietti');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (5,'2022-09-03','Devonish');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (18,'2023-02-02','Fritter');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (36,'2022-04-19','Postill');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (20,'2022-10-18','Wye');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (16,'2022-05-03','Starkey');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (48,'2023-02-11','Downs');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (43,'2022-04-17','Whorf');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (29,'2022-12-28','Tyhurst');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (41,'2022-11-11','Bancroft');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (11,'2022-06-14','Inold');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (50,'2022-05-30','Hatherell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (39,'2022-12-04','Andrichak');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (25,'2023-01-01','Trethowan');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (37,'2022-10-27','Swatton');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (38,'2023-03-30','Dumbelton');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (28,'2022-06-04','Arthan');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (24,'2022-06-12','Garnsworth');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (48,'2023-02-28','Shortell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (43,'2022-05-08','Westbury');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (31,'2023-01-28','McNickle');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (37,'2022-12-22','Schubbert');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (18,'2022-09-30','Bythway');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (17,'2022-05-22','Semper');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (3,'2022-06-18','Instock');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (15,'2022-07-24','Keaton');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (24,'2023-02-16','Curdell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (42,'2022-10-16','Lisett');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (50,'2023-03-12','Sherington');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (27,'2022-05-30','Shard');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (8,'2023-01-21','Howgate');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (26,'2022-08-07','Kringe');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (7,'2022-08-10','Moss');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (17,'2023-01-26','Bownes');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (48,'2023-03-10','Lalonde');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (18,'2022-07-07','Smaile');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (10,'2022-06-28','Mathiassen');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (32,'2023-01-29','Whorlton');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (38,'2023-03-19','Gjerde');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (14,'2022-09-12','Presidey');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (30,'2022-06-17','Camier');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (23,'2023-01-28','McNickle');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (15,'2022-08-03','Sudell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (29,'2022-12-09','Najera');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (33,'2022-12-22','Schubbert');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (26,'2022-12-04','Andrichak');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (4,'2022-07-16','Jeannel');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (31,'2022-08-22','Cardiff');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (42,'2022-09-22','Titterrell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (17,'2022-04-22','Wortman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (35,'2022-12-23','Stave');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (21,'2023-04-13','Cherry Holme');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (8,'2022-06-24','Bolver');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (46,'2022-06-26','Greenwood');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (46,'2022-08-25','Ottery');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (17,'2022-09-30','Bythway');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (21,'2022-04-29','Loche');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (1,'2022-10-01','Nisuis');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (26,'2022-04-22','Wortman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (30,'2022-12-22','Schubbert');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (35,'2022-12-10','Harwin');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (22,'2022-11-01','Geerdts');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (4,'2022-10-20','Purkins');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (10,'2023-04-13','St Ange');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (9,'2022-06-14','Inold');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (19,'2022-05-25','Cantu');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (28,'2022-10-25','O''Rourke');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (30,'2022-10-24','Janeway');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (40,'2022-10-16','Inseal');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (11,'2023-01-18','Tunstall');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (18,'2022-07-06','Dearman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (14,'2023-04-06','Tingey');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (10,'2022-09-30','Bythway');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (27,'2022-05-12','Tunn');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (4,'2022-05-14','McKinstry');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (5,'2022-04-30','Labeuil');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (1,'2023-02-20','Bowling');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (33,'2023-02-21','Barensky');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (11,'2022-12-18','Gyngell');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (25,'2022-08-31','Howels');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (38,'2022-07-16','Sneath');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (20,'2023-03-30','Dumbelton');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (44,'2022-08-07','Kringe');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (30,'2023-01-18','Tunstall');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (40,'2022-08-06','Poznan');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (26,'2023-03-30','Briars');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (19,'2022-06-12','Epps');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (50,'2022-11-26','Blucher');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (17,'2022-12-28','Tyhurst');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (45,'2023-01-26','Bownes');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (27,'2023-04-15','Snoddon');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (50,'2022-07-03','Sampson');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (22,'2023-01-06','Fear');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (15,'2022-10-02','Petegre');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (23,'2022-05-21','Timoney');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (13,'2022-12-15','Fiddeman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (40,'2022-06-25','Dowker');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (47,'2022-09-20','Gilders');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (3,'2022-05-24','Snibson');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (21,'2022-12-21','Bentje');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (2,'2022-06-24','Bolver');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (33,'2022-12-31','Clay');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (34,'2022-11-26','Ambrozewicz');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (41,'2023-01-23','Oglesbee');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (11,'2022-12-10','Harwin');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (15,'2023-02-08','Kilbane');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (38,'2023-04-01','Alman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (32,'2022-05-21','Matessian');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (20,'2023-03-10','Cripin');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (14,'2022-05-19','Colhoun');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (40,'2022-08-19','Deacock');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (31,'2022-11-26','Blucher');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (37,'2023-01-25','Huckel');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (46,'2022-10-18','Wye');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (19,'2023-01-01','Mandel');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (33,'2022-12-09','Lochead');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (43,'2022-08-27','Attack');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (30,'2022-12-15','Fiddeman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (15,'2023-03-30','Briars');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (5,'2022-06-29','Keesman');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (18,'2023-04-13','St Ange');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (13,'2022-08-26','Morot');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (8,'2022-08-22','Cardiff');
INSERT INTO Rec_Vis(employee_id,visit_time,last_name) VALUES (9,'2022-04-22','Wortman');

-- Inputting data into 'CaretakerVolunteer'

INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('jraynes0@uol.com.br',37,'Joyan','Raynes','547-283-5927','dog',2,1);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('rghidoni1@sina.com.cn',51,'Randi','Ghidoni','610-281-5999','cat',23,2);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('emattiuzzi2@ox.ac.uk',24,'Eldin','Mattiuzzi','635-897-7451','cat',25,3);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('jreiner3@about.com',20,'Juliana','Reiner','136-959-0799','cat',32,4);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('btirone4@theatlantic.com',12,'Barnett','Tirone','280-968-0661','cat',6,5);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('mharron5@webnode.com',2,'Maddi','Harron','722-138-7749','cat',40,6);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dsmithson6@elpais.com',48,'Dion','Smithson','246-699-2822','cat',20,7);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('vpennicott7@booking.com',46,'Victoria','Pennicott','466-835-6693','cat',42,8);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('jsowte8@nature.com',42,'Job','Sowte','444-766-5919','dog',49,9);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('kkembrey9@behance.net',57,'Kimberlee','Kembrey','889-885-8314','dog',10,10);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ppinnockea@blinklist.com',10,'Philomena','Pinnocke','967-488-4410','cat',44,11);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('bcappb@squidoo.com',50,'Bette','Capp','671-857-8371','dog',50,12);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ialdridgec@blinklist.com',9,'Idaline','Aldridge','138-344-8039','dog',15,13);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dpaudind@nytimes.com',37,'Deane','Paudin','719-842-6562','cat',32,14);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('smcewane@cam.ac.uk',9,'Sybille','McEwan','163-634-3417','dog',16,15);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('vgladtbachf@livejournal.com',2,'Vachel','Gladtbach','263-361-9397','dog',19,16);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('hdagwellg@unesco.org',58,'Herc','Dagwell','881-250-7916','cat',13,17);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('bsapwellh@wsj.com',44,'Bogey','Sapwell','784-212-0809','cat',43,18);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lheinreichi@utexas.edu',23,'Lorettalorna','Heinreich','386-691-9349','dog',32,19);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ecellierj@engadget.com',29,'Enoch','Cellier','314-892-3313','dog',2,20);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('hcollcottk@comsenz.com',1,'Hort','Collcott','396-665-3457','dog',42,21);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('amacrael@auda.org.au',46,'Aldis','Macrae','512-961-9445','dog',25,22);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ogarzm@nih.gov',23,'Othilia','Garz','345-581-9940','cat',34,23);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('cyepiskovn@prweb.com',56,'Caritta','Yepiskov','463-328-8848','cat',39,24);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('myglesiaso@wikia.com',45,'Marijn','Yglesias','262-503-7272','dog',28,25);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('fgaganp@imdb.com',40,'Fraser','Gagan','209-979-8488','dog',12,26);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('rthormwellq@cdc.gov',22,'Royal','Thormwell','576-380-3096','cat',19,27);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('uzuanr@wix.com',23,'Ulrikaumeko','Zuan','292-778-1058','cat',38,28);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('gsillwoods@bravesites.com',15,'Gary','Sillwood','531-230-4156','dog',25,29);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lsallingt@ucsd.edu',22,'Lilli','Salling','481-622-6419','dog',1,30);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ebrashu@xinhuanet.com',2,'Emilio','Brash','622-459-7600','dog',41,31);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lhinckesv@hugedomains.com',50,'Loree','Hinckes','184-124-4637','dog',20,32);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('akobeltw@microsoft.com',52,'Athene','Kobelt','253-300-7546','dog',42,33);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('bfrancesconex@independent.co.uk',26,'Bendick','Francescone','281-572-6873','dog',14,34);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lrabidgey@xing.com',58,'Leonie','Rabidge','170-520-4958','dog',25,35);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('tfritzz@businessweek.com',53,'Theodora','Fritz','276-574-7438','dog',8,36);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dmanon10@google.co.uk',33,'Damiano','Manon','864-557-0291','cat',9,37);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('hswedeland11@quantcast.com',25,'Huntley','Swedeland','865-418-9868','dog',44,38);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('mmacglory12@newsvine.com',7,'Malva','MacGlory','867-722-2117','dog',3,39);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('bgillson13@narod.ru',33,'Burlie','Gillson','514-838-1078','cat',1,40);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('sgoaley14@nih.gov',40,'Susie','Goaley','360-602-7607','cat',3,41);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('wfitchett15@posterous.com',44,'Willard','Fitchett','104-377-4723','dog',20,42);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('abrenston16@xrea.com',45,'Alisha','Brenston','473-802-1715','cat',31,43);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('skisby17@ca.gov',60,'Sigfrid','Kisby','229-884-3315','cat',24,44);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('rlucian18@cyberchimps.com',3,'Robbi','Lucian','646-583-6116','cat',33,45);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ezorer19@surveymonkey.com',30,'Emmett','Zorer','831-408-0501','cat',6,46);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('nchesson1a@marriott.com',23,'Nelson','Chesson','607-973-7556','dog',16,47);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('rdonohue1b@wired.com',38,'Rona','Donohue','643-295-6978','dog',23,48);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('tmurby1c@dedecms.com',53,'Tonie','Murby','522-986-8937','dog',12,49);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('akeyhoe1d@gov.uk',57,'Ardeen','Keyhoe','582-798-2779','dog',26,50);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('tdauber1e@reference.com',47,'Thomasina','Dauber','159-784-6387','cat',25,51);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('equinane1f@over-blog.com',20,'Elysee','Quinane','378-411-2952','cat',27,52);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dfumagallo1g@who.int',21,'Duane','Fumagallo','444-220-5652','cat',1,53);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('gduchatel1h@newyorker.com',1,'Geneva','Duchatel','389-366-3752','dog',24,54);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('sgroom1i@mapy.cz',40,'Stephi','Groom','490-280-5476','dog',17,55);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('jbeecheno1j@drupal.org',43,'Janeva','Beecheno','795-511-7835','cat',45,56);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('aalsop1k@joomla.org',15,'Anthea','Alsop','738-387-2052','cat',2,57);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('vtomczykowski1l@businessweek.com',54,'Virge','Tomczykowski','558-797-3164','dog',18,58);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('bdufaire1m@usgs.gov',60,'Brok','Dufaire','100-428-4691','cat',47,59);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('haldrich1n@google.es',1,'Hope','Aldrich','370-734-2793','cat',11,60);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dwimbury1o@bing.com',48,'Davida','Wimbury','610-996-2448','cat',19,61);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('efielden1p@so-net.ne.jp',17,'Emlen','Fielden','395-825-6620','cat',7,62);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lballham1q@chicagotribune.com',30,'Leanora','Ballham','674-419-6434','cat',34,63);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('pnelthropp1r@ask.com',50,'Pete','Nelthropp','248-555-7195','dog',12,64);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('geglaise1s@photobucket.com',29,'Gypsy','Eglaise','916-264-6742','cat',35,65);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('fwhatford1t@wufoo.com',16,'Ferdinande','Whatford','139-600-6466','cat',27,66);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dgreenhaugh1u@illinois.edu',14,'Dom','Greenhaugh','773-310-5424','cat',50,67);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lhearsey1v@amazon.co.jp',27,'Lewes','Hearsey','407-818-3763','cat',6,68);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('screech1w@macromedia.com',6,'Sinclair','Creech','636-209-3557','dog',14,69);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('anund1x@cafepress.com',25,'Antony','Nund','439-795-4481','cat',31,70);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lupstell1y@cam.ac.uk',23,'Lyn','Upstell','423-431-4208','cat',7,71);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('tlaidler1z@mtv.com',55,'Tammi','Laidler','112-898-3106','cat',37,72);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('cbavister20@t-online.de',21,'Cullen','Bavister','705-423-4619','dog',8,73);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('smochar21@tamu.edu',16,'Skip','Mochar','584-599-7559','dog',40,74);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('fviste22@geocities.jp',53,'Federica','Viste','482-733-0609','cat',16,75);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('mstarbuck23@ustream.tv',50,'Miner','Starbuck','573-593-6912','cat',2,76);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('kaspray24@google.ru',11,'Keven','Aspray','800-507-3519','cat',42,77);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('dlatham25@reuters.com',22,'Dag','Latham','684-286-2248','cat',7,78);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lkeast26@webmd.com',30,'Ludvig','Keast','613-481-0886','dog',18,79);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('wdanton27@mozilla.org',19,'Wilie','Danton','502-192-1328','cat',40,80);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('kkildea28@github.com',4,'Keelby','Kildea','461-688-9156','dog',44,81);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('vpacey29@marriott.com',48,'Vidovic','Pacey','661-195-9586','dog',4,82);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('escoular2a@geocities.jp',6,'Elsi','Scoular','926-958-2108','cat',33,83);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('scoade2b@naver.com',2,'Shae','Coade','984-469-9290','cat',30,84);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('aallden2c@usatoday.com',15,'Adena','Allden','812-517-4107','cat',27,85);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('tdemicoli2d@statcounter.com',12,'Teodoro','Demicoli','555-222-1949','dog',25,86);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('imcgriffin2e@eepurl.com',54,'Isak','McGriffin','923-457-1862','cat',37,87);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lalthorp2f@uiuc.edu',27,'Lorilee','Althorp','941-186-1676','dog',45,88);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('sskydall2g@vkontakte.ru',39,'Salmon','Skydall','526-693-3340','cat',22,89);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('agreenwell2h@flickr.com',46,'Aimil','Greenwell','701-176-7348','dog',7,90);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('mmagowan2i@vistaprint.com',60,'Mathian','Magowan','444-287-3770','dog',49,91);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('rsisey2j@angelfire.com',18,'Roseline','Sisey','567-162-9352','dog',6,92);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('cwarby2k@google.fr',1,'Cele','Warby','774-405-2754','dog',35,93);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('goneal2l@360.cn',60,'Gwendolen','O''Neal','915-797-8408','dog',38,94);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('zstrank2m@drupal.org',14,'Zulema','Strank','873-464-6719','cat',32,95);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ebortolazzi2n@yale.edu',4,'Eolande','Bortolazzi','396-459-8252','dog',20,96);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('agambie2o@angelfire.com',31,'Any','Gambie','872-602-7123','dog',33,97);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('ldewes2p@hhs.gov',44,'Lyndel','Dewes','101-652-5896','dog',15,98);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('klawly2q@dmoz.org',60,'Kristine','Lawly','699-633-3843','cat',5,99);
INSERT INTO CaretakerVolunteer(work_email,experience,first_name,last_name,phone_number,animal_specialty,coordinator_id,caretaker_id) VALUES ('lhallbord2r@hatena.ne.jp',35,'Lissa','Hallbord','256-593-6397','cat',34,100);


-- Inputting data for table 'vetClinician'

INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Felisha','Norwood','fnorwood0@jalbum.net','Female','Animal Behavior',1);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Flora','Dale','fdale1@infoseek.co.jp','Female','Genetics',2);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Latashia','Grime','lgrime2@biglobe.ne.jp','Female','Equine Science',3);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Hayden','Shaul','hshaul3@latimes.com','Male','Genetics',4);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Stanwood','Skace','sskace4@clickbank.net','Male','Animal Behavior',5);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Maiga','MacClenan','mmacclenan5@51.la','Agender','Biology',6);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Trude','Bannister','tbannister6@usgs.gov','Female','Genetics',7);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Gordie','Gwilt','ggwilt7@elpais.com','Male','Equine Science',8);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Sallee','Babbs','sbabbs8@nytimes.com','Female','Oceanography',9);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Demott','Trussman','dtrussman9@topsy.com','Male','Equine Science',10);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Therine','Caldayrou','tcaldayroua@cmu.edu','Female','Neurobiology',11);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Marcy','Whiteoak','mwhiteoakb@forbes.com','Female','Zoology',12);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Arther','Menendez','amenendezc@blog.com','Male','Oceanography',13);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Dwight','Batiste','dbatisted@twitter.com','Male','Veterinary Technology',14);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Yolande','Menendez','ymenendeze@eepurl.com','Female','Marine Biology',15);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Dalli','Pennycock','dpennycockf@cnet.com','Male','Biology',16);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Albertina','Marconi','amarconig@ifeng.com','Female','Animal Behavior',17);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Hartwell','Gyngell','hgyngellh@utexas.edu','Male','Neurobiology',18);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Vivyan','Fisher','vfisheri@latimes.com','Female','Oceanography',19);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Bren','Beeden','bbeedenj@cnbc.com','Male','Marine Biology',20);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Patience','Dowles','pdowlesk@europa.eu','Female','Doctor of Veterinary Medicine',21);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Ikey','Hanney','ihanneyl@list-manage.com','Male','Equine Science',22);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Germaine','Tosh','gtoshm@ustream.tv','Male','Oceanography',23);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Editha','Crinage','ecrinagen@baidu.com','Non-binary','Animal Behavior',24);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Robinette','Setford','rsetfordo@examiner.com','Female','Equine Science',25);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Enrichetta','Kirby','ekirbyp@github.io','Female','Genetics',26);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Karon','Colqueran','kcolqueranq@youtu.be','Female','Veterinary Technology',27);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Hendrik','Allchin','hallchinr@paypal.com','Male','Marine Biology',28);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dermatology','Allx','Vaskov','avaskovs@nymag.com','Female','Genetics',29);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Aldous','Mailey','amaileyt@netvibes.com','Male','Veterinary Technology',30);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Emmye','Petyt','epetytu@taobao.com','Female','Zoology',31);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Aldridge','Cromly','acromlyv@wired.com','Male','Doctor of Veterinary Medicine',32);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Rosana','Skentelbery','rskentelberyw@theglobeandmail.com','Female','Genetics',33);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Yankee','Gatherell','ygatherellx@senate.gov','Male','Neurobiology',34);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Janel','Whitmell','jwhitmelly@blinklist.com','Female','Veterinary Nursing',35);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Salvidor','Filasov','sfilasovz@weebly.com','Male','Marine Biology',36);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Abbey','McComas','amccomas10@hostgator.com','Female','Veterinary Nursing',37);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Camilla','Houdhury','choudhury11@unesco.org','Female','Neurobiology',38);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Brier','Musso','bmusso12@qq.com','Female','Veterinary Nursing',39);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Sophie','Nacci','snacci13@senate.gov','Female','Genetics',40);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Kinna','Nobles','knobles14@soup.io','Female','Veterinary Technology',41);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dermatology','Katerine','Angelo','kangelo15@army.mil','Genderqueer','Genetics',42);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Aymer','Walwood','awalwood16@1688.com','Male','Animal Behavior',43);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Putnam','Clemas','pclemas17@merriam-webster.com','Male','Genetics',44);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Saba','Meys','smeys18@ovh.net','Non-binary','Veterinary Technology',45);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Catlee','Radish','cradish19@dot.gov','Female','Animal Nutrition',46);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Maddy','Vannuccini','mvannuccini1a@blogger.com','Male','Marine Biology',47);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Wilmer','Stockle','wstockle1b@about.me','Male','Animal Nutrition',48);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Rupert','Sines','rsines1c@mayoclinic.com','Male','Animal Nutrition',49);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Aube','Ciccone','aciccone1d@cnet.com','Male','Animal Behavior',50);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Bran','Easson','beasson1e@sakura.ne.jp','Male','Doctor of Veterinary Medicine',51);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dermatology','Wenona','Ouver','wouver1f@ucsd.edu','Female','Biology',52);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Inigo','Morgue','imorgue1g@virginia.edu','Male','Doctor of Veterinary Medicine',53);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Eula','Garaway','egaraway1h@bandcamp.com','Female','Veterinary Technology',54);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Virgie','Aldcorne','valdcorne1i@nationalgeographic.com','Male','Biology',55);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dermatology','Val','Finnie','vfinnie1j@goodreads.com','Male','Marine Biology',56);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Camella','Hawson','chawson1k@imageshack.us','Female','Animal Behavior',57);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Dario','Greenroyd','dgreenroyd1l@php.net','Male','Zoology',58);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Bevan','Nassi','bnassi1m@go.com','Male','Equine Science',59);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Gael','Blackwell','gblackwell1n@linkedin.com','Female','Neurobiology',60);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Ossie','Morfey','omorfey1o@jugem.jp','Male','Doctor of Veterinary Medicine',61);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Nancee','Tomley','ntomley1p@w3.org','Female','Biology',62);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Laughton','Doughtery','ldoughtery1q@nba.com','Male','Zoology',63);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Alfi','Middlemass','amiddlemass1r@jigsy.com','Female','Genetics',64);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Mollee','Bickerdike','mbickerdike1s@elpais.com','Female','Marine Biology',65);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Alexandro','Whitchurch','awhitchurch1t@pbs.org','Male','Neurobiology',66);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Thurstan','Haking','thaking1u@squidoo.com','Agender','Biology',67);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Hilde','Beckson','hbeckson1v@cafepress.com','Female','Doctor of Veterinary Medicine',68);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Mireille','Petow','mpetow1w@issuu.com','Female','Biology',69);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Ellwood','Scarffe','escarffe1x@time.com','Male','Equine Science',70);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Gianna','Scholer','gscholer1y@cafepress.com','Female','Biology',71);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Emergency and Critical Care','Drusie','Lamzed','dlamzed1z@a8.net','Female','Neurobiology',72);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Rahal','Daley','rdaley20@amazon.co.jp','Female','Equine Science',73);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Moises','Jentet','mjentet21@netvibes.com','Male','Zoology',74);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Rouvin','Bullman','rbullman22@prnewswire.com','Male','Neurobiology',75);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Dudley','Faas','dfaas23@washington.edu','Male','Equine Science',76);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Ken','Malkie','kmalkie24@nsw.gov.au','Male','Marine Biology',77);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Rodd','Esom','resom25@archive.org','Male','Marine Biology',78);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Ricoriki','Bockh','rbockh26@state.gov','Male','Genetics',79);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Kenon','Skinley','kskinley27@instagram.com','Male','Biology',80);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Mona','Sowood','msowood28@amazon.co.uk','Female','Marine Biology',81);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Ilario','Leopard','ileopard29@cyberchimps.com','Male','Animal Behavior',82);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Emilio','Ixer','eixer2a@cnbc.com','Male','Animal Behavior',83);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Tarah','Neylan','tneylan2b@google.com.br','Female','Neurobiology',84);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Internal Medicine','Derrek','Ogle','dogle2c@earthlink.net','Male','Biology',85);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Dentistry','Ginger','McGrudder','gmcgrudder2d@yellowbook.com','Male','Zoology',86);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Indira','Schleswig-Holstein','ischleswigholstein2e@google.pl','Female','Doctor of Veterinary Medicine',87);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Rubie','Zanetto','rzanetto2f@umich.edu','Female','Oceanography',88);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Lindon','Grunnell','lgrunnell2g@scientificamerican.com','Male','Marine Biology',89);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Tracy','Kalinowsky','tkalinowsky2h@businesswire.com','Male','Veterinary Technology',90);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Jacques','Cromie','jcromie2i@spiegel.de','Male','Equine Science',91);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Goober','Rodge','grodge2j@wisc.edu','Male','Animal Behavior',92);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Kingsley','Paolinelli','kpaolinelli2k@ycombinator.com','Male','Zoology',93);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Cyrille','Frances','cfrances2l@aol.com','Male','Animal Nutrition',94);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Anesthesia','Henriette','Kindell','hkindell2m@joomla.org','Female','Neurobiology',95);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Toxicology','Stephan','Fashion','sfashion2n@wufoo.com','Male','Animal Behavior',96);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Surgery','Loren','Cappel','lcappel2o@un.org','Male','Veterinary Nursing',97);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Pathology','Corby','Reubens','creubens2p@gnu.org','Male','Neurobiology',98);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Nutrition','Chester','Winslow','cwinslow2q@macromedia.com','Male','Doctor of Veterinary Medicine',99);
INSERT INTO vetClinician(field_concentration,first_name,last_name,work_email,phone_number,degree,vetID) VALUES ('Behavioral Medicine','Jacques','McAnellye','jmcanellye2r@illinois.edu','Male','Genetics',100);


-- Inputting data for table 'dog'

INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,12,'4:52:09', FALSE,TRUE,TRUE,'Florrie',18,FALSE,'French Bulldog',178,TRUE,TRUE,'None','Male',22,29,1);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,1,'4:36:06', FALSE, TRUE, TRUE,'Tildy',10, FALSE,'Bulldog',41,TRUE,FALSE,'None','Male',34,26,2);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,23,'12:30:58',FALSE,TRUE,FALSE,'Walther',4,TRUE,'German Shorthaired Pointer',48,TRUE,TRUE,'None','Female',40,100,3);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,35,'3:49:42',TRUE,FALSE,FALSE,'Nissa',11,FALSE,'Bulldog',207,FALSE,TRUE,'None','Male',48,50,4);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,16,'3:46:09',TRUE,FALSE,TRUE,'Atlante',17,TRUE,'Dachshund',158,FALSE,TRUE,'None','Male',74,14,5);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,17,'9:51:04',TRUE,TRUE,TRUE,'Wenonah',10,FALSE,'Bulldog',149,TRUE,FALSE,'None','Male',51,16,6);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,11,'4:08:36',TRUE,TRUE,FALSE,'Janette',11,TRUE,'German Shepherd',204,FALSE,TRUE,'None','Female',10,83,7);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,20,'2:22:47',TRUE,TRUE,TRUE,'Marlon',3,TRUE,'Beagle',149,FALSE,TRUE,'None','Female',82,90,8);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,5,'10:17:01',TRUE,FALSE,FALSE,'Antonino',2,FALSE,'Poodle',185,TRUE,TRUE,'None','Male',14,92,9);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,32,'2:12:01',FALSE,FALSE,TRUE,'Fan',7,TRUE,'Bulldog',108,TRUE,TRUE,'None','Male',99,30,10);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,12,'1:21:59',TRUE,TRUE,TRUE,'Andee',16,FALSE,'Doberman Pinscher',62,FALSE,TRUE,'None','Male',81,32,11);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,20,'12:24:51',TRUE,FALSE,FALSE,'Donaugh',1,TRUE,'French Bulldog',146,TRUE,FALSE,'None','Male',49,21,12);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,19,'3:43:11',FALSE,FALSE,FALSE,'Karlis',6,FALSE,'Rottweiler',204,TRUE,TRUE,'None','Male',84,86,13);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,29,'1:28:42',TRUE,TRUE,TRUE,'Dianna',10,TRUE,'Boxer',216,TRUE,FALSE,'None','Female',11,54,14);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,2,'4:24:03',TRUE,FALSE,FALSE,'Kate',2,FALSE,'Labrador Retriever',89,TRUE,TRUE,'None','Male',22,4,15);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,18,'4:38:04',TRUE,TRUE,TRUE,'Selle',18,FALSE,'German Shepherd',99,TRUE,TRUE,'None','Male',55,97,16);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,9,'10:24:34',FALSE,TRUE,TRUE,'Tiebold',7,FALSE,'Poodle',88,FALSE,FALSE,'None','Female',48,6,17);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,31,'11:29:51',FALSE,TRUE,FALSE,'Deane',14,FALSE,'Dachshund',17,FALSE,TRUE,'None','Female',35,38,18);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,16,'12:14:39',FALSE,TRUE,TRUE,'Yuma',10,TRUE,'Boxer',210,TRUE,FALSE,'None','Female',41,32,19);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,11,'12:15:23',FALSE,TRUE,FALSE,'Kylila',8,TRUE,'Dachshund',28,FALSE,TRUE,'None','Male',36,80,20);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,7,'3:54:57',TRUE,TRUE,TRUE,'Raimondo',6,FALSE,'German Shepherd',184,TRUE,FALSE,'None','Male',61,11,21);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,18,'12:09:13',FALSE,FALSE,FALSE,'Hewie',8,TRUE,'Yorkshire Terrier',41,FALSE,FALSE,'None','Male',20,19,22);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,24,'11:08:06',FALSE,FALSE,TRUE,'Lennie',3,FALSE,'Rottweiler',68,TRUE,TRUE,'None','Female',97,79,23);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,34,'3:19:04',TRUE,TRUE,FALSE,'Winslow',17,FALSE,'German Shorthaired Pointer',104,FALSE,TRUE,'None','Female',31,41,24);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,7,'10:05:53',FALSE,TRUE,TRUE,'Francisco',6,TRUE,'French Bulldog',36,TRUE,FALSE,'None','Male',99,36,25);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,11,'1:32:31',FALSE,FALSE,FALSE,'Shea',11,FALSE,'Yorkshire Terrier',19,TRUE,FALSE,'None','Female',32,22,26);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,32,'11:11:21',FALSE,TRUE,TRUE,'Trueman',8,FALSE,'Rottweiler',143,FALSE,FALSE,'None','Female',80,39,27);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,31,'12:09:38',FALSE,FALSE,FALSE,'Harriot',18,TRUE,'Labrador Retriever',219,TRUE,FALSE,'None','Female',95,96,28);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,3,'9:01:21',FALSE,FALSE,FALSE,'Bern',13,TRUE,'French Bulldog',225,TRUE,FALSE,'None','Male',98,1,29);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,11,'2:18:15',FALSE,TRUE,FALSE,'Lettie',14,FALSE,'Boxer',71,TRUE,TRUE,'None','Male',13,6,30);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,19,'10:53:37',FALSE,TRUE,TRUE,'Marty',6,FALSE,'Labrador Retriever',75,FALSE,FALSE,'None','Male',28,58,31);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,13,'1:38:39',FALSE,TRUE,FALSE,'Mellicent',16,FALSE,'German Shepherd',98,FALSE,TRUE,'None','Female',96,13,32);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,32,'4:14:10',FALSE,TRUE,TRUE,'Dorelle',12,TRUE,'Yorkshire Terrier',142,FALSE,TRUE,'None','Male',32,45,33);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,11,'12:05:04',TRUE,TRUE,TRUE,'Joelle',7,FALSE,'German Shepherd',205,TRUE,FALSE,'None','Male',92,88,34);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,32,'12:30:05',TRUE,TRUE,TRUE,'Myrah',9,FALSE,'Bulldog',196,TRUE,FALSE,'None','Male',60,69,35);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,12,'11:40:42',TRUE,TRUE,TRUE,'Kariotta',11,FALSE,'Poodle',81,TRUE,TRUE,'None','Female',52,10,36);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,15,'12:04:43',FALSE,FALSE,FALSE,'Griffin',7,FALSE,'Poodle',146,TRUE,TRUE,'None','Female',89,91,37);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,16,'9:19:58',FALSE,FALSE,FALSE,'Solly',5,TRUE,'Yorkshire Terrier',164,FALSE,TRUE,'None','Female',12,51,38);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,4,'4:40:16',FALSE,TRUE,FALSE,'Antonetta',5,FALSE,'Golden Retriver',156,TRUE,TRUE,'None','Female',67,12,39);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,5,'1:48:36',FALSE,TRUE,FALSE,'Claudius',1,FALSE,'Beagle',128,TRUE,TRUE,'None','Female',82,74,40);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,5,'12:21:33',FALSE,FALSE,FALSE,'Hazlett',10,TRUE,'Beagle',145,TRUE,FALSE,'None','Female',64,23,41);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,20,'11:14:22',FALSE,TRUE,FALSE,'Haydon',12,FALSE,'Dachshund',214,TRUE,FALSE,'None','Female',54,43,42);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,23,'10:54:45',TRUE,FALSE,TRUE,'Pascal',16,TRUE,'Yorkshire Terrier',45,TRUE,FALSE,'None','Female',7,50,43);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,32,'2:17:14',TRUE,FALSE,FALSE,'Dick',2,TRUE,'Yorkshire Terrier',44,TRUE,TRUE,'None','Male',43,98,44);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,6,'4:01:05',FALSE,TRUE,FALSE,'Nichole',8,TRUE,'Rottweiler',127,FALSE,FALSE,'None','Female',62,33,45);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,9,'9:05:11',TRUE,FALSE,FALSE,'Dorolisa',6,TRUE,'German Shepherd',80,FALSE,TRUE,'None','Female',42,27,46);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,2,'10:23:36',FALSE,TRUE,TRUE,'Brandice',15,FALSE,'Golden Retriver',109,FALSE,TRUE,'None','Male',63,62,47);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,21,'1:06:37',TRUE,TRUE,TRUE,'Anica',3,FALSE,'German Shorthaired Pointer',126,TRUE,FALSE,'None','Male',55,43,48);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,4,'4:46:52',TRUE,TRUE,TRUE,'Ingaborg',5,FALSE,'Bulldog',216,TRUE,TRUE,'None','Female',41,26,49);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,34,'3:56:14',TRUE,TRUE,TRUE,'Cristen',13,FALSE,'Dachshund',102,TRUE,TRUE,'None','Female',8,75,50);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,17,'12:54:07',TRUE,FALSE,TRUE,'Ilise',5,FALSE,'Labrador Retriever',70,TRUE,TRUE,'None','Male',52,77,51);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,20,'10:26:04',FALSE,TRUE,TRUE,'Fredrick',7,FALSE,'French Bulldog',31,FALSE,FALSE,'None','Female',9,97,52);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,19,'9:57:07',TRUE,FALSE,TRUE,'Ray',15,FALSE,'German Shorthaired Pointer',70,TRUE,TRUE,'None','Female',74,7,53);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,11,'10:24:40',FALSE,TRUE,FALSE,'Zora',16,FALSE,'Rottweiler',143,TRUE,FALSE,'None','Female',76,22,54);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,15,'12:02:14',TRUE,TRUE,TRUE,'Brianna',15,FALSE,'Yorkshire Terrier',89,FALSE,FALSE,'None','Female',29,60,55);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,14,'9:53:18',TRUE,TRUE,TRUE,'Larisa',15,TRUE,'Doberman Pinscher',133,FALSE,TRUE,'None','Female',97,1,56);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,33,'9:15:11',TRUE,FALSE,FALSE,'Corny',6,TRUE,'German Shorthaired Pointer',166,TRUE,TRUE,'None','Male',35,92,57);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,12,'10:18:52',FALSE,TRUE,FALSE,'Pip',13,TRUE,'French Bulldog',106,FALSE,FALSE,'None','Male',3,94,58);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,27,'3:00:10',TRUE,FALSE,FALSE,'Jesus',15,FALSE,'German Shepherd',219,FALSE,FALSE,'None','Male',78,31,59);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,31,'4:09:10',TRUE,TRUE,TRUE,'Esta',8,FALSE,'Dachshund',217,TRUE,FALSE,'None','Male',59,99,60);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,33,'4:47:17',TRUE,TRUE,TRUE,'Kory',8,FALSE,'Labrador Retriever',25,FALSE,FALSE,'None','Female',99,92,61);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,2,'9:41:13',FALSE,TRUE,FALSE,'Saunderson',5,TRUE,'Beagle',31,TRUE,TRUE,'None','Male',33,12,62);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,29,'10:41:49',FALSE,TRUE,TRUE,'Rakel',8,FALSE,'Golden Retriver',150,FALSE,TRUE,'None','Female',58,17,63);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,3,'4:30:26',TRUE,FALSE,TRUE,'Alvinia',17,TRUE,'Beagle',114,TRUE,FALSE,'None','Female',31,19,64);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,26,'4:51:41',FALSE,FALSE,TRUE,'Cly',12,TRUE,'Rottweiler',91,TRUE,TRUE,'None','Female',32,34,65);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,18,'2:35:14',FALSE,FALSE,FALSE,'Libbi',17,FALSE,'Dachshund',23,TRUE,TRUE,'None','Female',88,22,66);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,27,'3:53:15',TRUE,TRUE,FALSE,'Audre',18,FALSE,'Boxer',89,FALSE,FALSE,'None','Female',61,10,67);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,17,'11:55:09',FALSE,TRUE,TRUE,'Jaquelyn',1,TRUE,'German Shorthaired Pointer',197,FALSE,TRUE,'None','Female',5,64,68);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,11,'9:33:06',FALSE,TRUE,TRUE,'Papageno',1,TRUE,'Beagle',159,FALSE,FALSE,'None','Female',36,16,69);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,10,'2:07:00',FALSE,TRUE,TRUE,'Raoul',2,FALSE,'German Shorthaired Pointer',145,FALSE,FALSE,'None','Male',94,68,70);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,18,'4:48:04',FALSE,TRUE,FALSE,'Luise',7,TRUE,'Boxer',52,FALSE,TRUE,'None','Male',82,48,71);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,4,'11:22:18',FALSE,TRUE,TRUE,'Irene',1,FALSE,'Doberman Pinscher',106,TRUE,TRUE,'None','Female',80,97,72);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,18,'9:10:34',FALSE,TRUE,FALSE,'Jsandye',3,TRUE,'Doberman Pinscher',16,FALSE,TRUE,'None','Female',9,98,73);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,6,'9:42:39',TRUE,FALSE,FALSE,'Hope',17,TRUE,'Rottweiler',163,TRUE,TRUE,'None','Female',42,68,74);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,6,'4:39:54',FALSE,FALSE,FALSE,'Salvidor',15,FALSE,'Bulldog',66,TRUE,TRUE,'None','Male',53,10,75);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,23,'12:03:47',TRUE,FALSE,FALSE,'Jamison',13,TRUE,'Rottweiler',44,TRUE,TRUE,'None','Female',9,27,76);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,12,'9:06:14',FALSE,FALSE,FALSE,'Christen',8,FALSE,'Rottweiler',91,TRUE,FALSE,'None','Male',74,91,77);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,11,'10:04:14',FALSE,FALSE,FALSE,'Trescha',6,FALSE,'German Shepherd',146,FALSE,TRUE,'None','Female',37,5,78);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,13,'4:16:17',TRUE,TRUE,FALSE,'Georgena',8,TRUE,'Doberman Pinscher',48,FALSE,FALSE,'None','Female',76,38,79);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,14,'9:16:42',FALSE,FALSE,TRUE,'Janaye',9,TRUE,'Yorkshire Terrier',112,FALSE,FALSE,'None','Male',93,75,80);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,34,'4:40:12',FALSE,TRUE,FALSE,'Mia',2,FALSE,'Poodle',54,TRUE,FALSE,'None','Male',54,66,81);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,29,'10:08:29',TRUE,FALSE,TRUE,'Arabella',17,TRUE,'German Shorthaired Pointer',133,TRUE,TRUE,'None','Male',77,31,82);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,35,'9:26:34',FALSE,FALSE,FALSE,'Sophia',16,TRUE,'Beagle',109,FALSE,TRUE,'None','Male',15,74,83);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,12,'4:22:54',FALSE,FALSE,FALSE,'Evelyn',9,FALSE,'Doberman Pinscher',196,FALSE,TRUE,'None','Female',83,49,84);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,14,'10:59:38',FALSE,TRUE,TRUE,'Quincy',13,FALSE,'Beagle',168,TRUE,FALSE,'None','Male',30,73,85);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,20,'3:03:56',FALSE,TRUE,FALSE,'Reine',16,TRUE,'Yorkshire Terrier',199,FALSE,TRUE,'None','Female',33,5,86);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,15,'4:44:54',TRUE,FALSE,FALSE,'Shantee',12,TRUE,'Doberman Pinscher',134,TRUE,TRUE,'None','Male',16,9,87);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,19,'1:14:53',TRUE,TRUE,TRUE,'Dot',15,TRUE,'Yorkshire Terrier',198,FALSE,TRUE,'None','Male',7,32,88);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,8,'11:46:37',FALSE,FALSE,TRUE,'Rurik',6,FALSE,'Yorkshire Terrier',17,FALSE,FALSE,'None','Male',82,53,89);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,10,'4:43:18',TRUE,TRUE,TRUE,'Helsa',18,TRUE,'Dachshund',84,TRUE,TRUE,'None','Male',55,100,90);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,32,'12:24:33',FALSE,TRUE,FALSE,'Jacintha',13,FALSE,'Golden Retriver',120,FALSE,TRUE,'None','Female',76,4,91);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,11,'1:21:28',FALSE,TRUE,TRUE,'Shelby',5,TRUE,'Dachshund',108,FALSE,FALSE,'None','Female',21,54,92);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,6,'10:31:41',TRUE,FALSE,TRUE,'Mildrid',11,FALSE,'Poodle',87,TRUE,FALSE,'None','Male',66,14,93);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,33,'12:24:23',TRUE,FALSE,FALSE,'Vernen',3,FALSE,'Labrador Retriever',179,FALSE,TRUE,'None','Female',56,92,94);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (4,23,'10:21:44',FALSE,FALSE,TRUE,'Rahal',1,TRUE,'Yorkshire Terrier',94,FALSE,FALSE,'None','Male',41,58,95);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (2,2,'12:01:44',TRUE,FALSE,TRUE,'Petronilla',16,FALSE,'Rottweiler',206,TRUE,FALSE,'None','Female',17,39,96);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (5,13,'10:10:40',FALSE,FALSE,TRUE,'Tonye',17,FALSE,'German Shepherd',118,TRUE,TRUE,'None','Female',71,25,97);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,29,'10:12:43',TRUE,TRUE,TRUE,'Shanie',5,TRUE,'Rottweiler',215,TRUE,FALSE,'None','Male',25,41,98);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (1,18,'12:22:26',FALSE,TRUE,TRUE,'Leroi',10,TRUE,'Beagle',62,TRUE,TRUE,'None','Male',16,38,99);
INSERT INTO dog(location,walk_duration,group_play_time,need_food,need_clean,need_walk,name_dog,age,chip_status,breed,weight,housebroken,temperament,dietary_restriction,sex,caretaker_id,vet_id,dog_id) VALUES (3,30,'12:58:24',FALSE,FALSE,TRUE,'Guido',18,TRUE,'Golden Retriver',31,TRUE,FALSE,'None','Male',10,9,100);


-- Inputting data for table 'cat'

INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Russian Blue',FALSE,'Layney','female',15,FALSE,TRUE,'None',15,68,63,1);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,TRUE,'Ragdoll',TRUE,'Pennie','female',5,FALSE,TRUE,'None',10,82,57,2);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Russian Blue',FALSE,'Suzanna','female',1,TRUE,FALSE,'None',15,74,49,3);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,TRUE,'Siamese',FALSE,'Chev','female',23,FALSE,FALSE,'None',8,34,92,4);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,TRUE,'Maine Coon',TRUE,'Jesselyn','female',23,TRUE,FALSE,'None',9,45,40,5);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Maine Coon',TRUE,'Valenka','male',18,FALSE,TRUE,'None',13,86,7,6);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,FALSE,'Bengal',FALSE,'Alberik','female',10,TRUE,FALSE,'None',15,39,11,7);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Bombay',FALSE,'Corinna','male',4,FALSE,TRUE,'None',8,41,99,8);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,TRUE,'Bombay',TRUE,'Cash','male',19,FALSE,TRUE,'None',9,81,86,9);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,TRUE,'American Shorthair',TRUE,'Alfy','female',17,FALSE,TRUE,'None',11,51,31,10);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Domestic Longhair',FALSE,'Aprilette','female',11,TRUE,TRUE,'None',8,68,79,11);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Bombay',TRUE,'Concettina','male',18,TRUE,TRUE,'None',13,36,16,12);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,FALSE,'Ragdoll',TRUE,'Trey','male',4,TRUE,TRUE,'None',9,43,97,13);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,FALSE,'American Shorthair',TRUE,'Felita','female',24,TRUE,FALSE,'None',9,76,73,14);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Domestic Longhair',TRUE,'Carlynne','male',15,TRUE,FALSE,'None',12,91,49,15);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Siamese',FALSE,'Andrey','female',9,TRUE,FALSE,'None',11,33,59,16);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,TRUE,'Ragdoll',TRUE,'Lynette','female',24,FALSE,FALSE,'None',10,60,6,17);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,FALSE,'Domestic Longhair',FALSE,'Dulcea','female',25,TRUE,TRUE,'None',10,81,13,18);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,FALSE,'American Shorthair',FALSE,'Englebert','male',25,FALSE,TRUE,'None',13,27,48,19);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,TRUE,TRUE,'American Shorthair',TRUE,'Othella','female',24,FALSE,TRUE,'None',10,93,85,20);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Persian',FALSE,'Dione','female',15,FALSE,FALSE,'None',8,78,92,21);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Bombay',FALSE,'Dorise','female',11,TRUE,FALSE,'None',14,39,61,22);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Ragdoll',FALSE,'Corri','female',17,TRUE,FALSE,'None',15,90,28,23);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,FALSE,'Domestic Longhair',FALSE,'Jermain','female',19,TRUE,TRUE,'None',13,96,15,24);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Domestic Longhair',FALSE,'Fidole','female',18,FALSE,FALSE,'None',12,99,86,25);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,TRUE,'American Shorthair',FALSE,'Viviana','male',11,FALSE,TRUE,'None',9,55,47,26);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,TRUE,'Bengal',FALSE,'Khalil','female',22,FALSE,TRUE,'None',9,76,72,27);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Persian',TRUE,'Evania','male',2,TRUE,TRUE,'None',9,19,36,28);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,TRUE,'Siamese',TRUE,'Glenine','male',12,TRUE,TRUE,'None',14,15,68,29);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,TRUE,'Bombay',TRUE,'Morey','female',13,TRUE,TRUE,'None',13,70,56,30);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,FALSE,'Russian Blue',TRUE,'Gerome','male',1,TRUE,TRUE,'None',9,11,52,31);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,FALSE,FALSE,'Domestic Shorthair',FALSE,'Hazlett','male',1,FALSE,TRUE,'None',14,100,78,32);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Domestic Longhair',TRUE,'Moe','male',12,TRUE,FALSE,'None',12,88,30,33);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'American Shorthair',FALSE,'Constancy','female',17,FALSE,FALSE,'None',15,24,85,34);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,FALSE,TRUE,'Persian',FALSE,'Oswell','female',19,TRUE,FALSE,'None',12,46,18,35);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,FALSE,'Bombay',TRUE,'Donall','female',7,TRUE,FALSE,'None',14,55,88,36);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,FALSE,'Maine Coon',FALSE,'Ford','male',20,TRUE,TRUE,'None',10,12,40,37);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,TRUE,'Domestic Shorthair',FALSE,'Mollee','male',4,FALSE,TRUE,'None',14,74,55,38);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,FALSE,'Domestic Shorthair',FALSE,'Gennie','male',19,FALSE,FALSE,'None',12,73,41,39);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,TRUE,'Siamese',TRUE,'Howie','male',15,TRUE,TRUE,'None',9,29,80,40);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Domestic Shorthair',FALSE,'Janot','female',9,FALSE,FALSE,'None',12,36,68,41);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Maine Coon',TRUE,'Stephani','male',24,TRUE,FALSE,'None',10,58,96,42);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,TRUE,'Russian Blue',TRUE,'Cherry','male',24,TRUE,FALSE,'None',15,42,88,43);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,FALSE,'Domestic Longhair',FALSE,'Christine','male',10,TRUE,TRUE,'None',9,38,77,44);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Maine Coon',TRUE,'Cari','female',11,FALSE,FALSE,'None',15,39,11,45);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Russian Blue',FALSE,'Annice','female',12,TRUE,TRUE,'None',15,80,88,46);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Russian Blue',TRUE,'Helli','male',14,TRUE,FALSE,'None',15,4,31,47);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,FALSE,'Ragdoll',FALSE,'Steffane','female',19,TRUE,TRUE,'None',15,17,91,48);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,FALSE,'Bengal',FALSE,'Brook','male',12,TRUE,TRUE,'None',15,98,75,49);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'American Shorthair',TRUE,'Kizzie','female',2,FALSE,FALSE,'None',15,73,6,50);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,FALSE,'Domestic Longhair',TRUE,'Adriano','male',19,FALSE,FALSE,'None',13,12,38,51);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Persian',FALSE,'Cate','female',17,TRUE,TRUE,'None',15,57,5,52);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,FALSE,'Persian',TRUE,'Ingeborg','female',10,TRUE,FALSE,'None',15,50,64,53);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,TRUE,'Domestic Longhair',TRUE,'Mandie','female',6,TRUE,FALSE,'None',13,46,6,54);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Persian',FALSE,'Tisha','female',15,FALSE,FALSE,'None',10,52,91,55);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Persian',TRUE,'Shanon','male',14,FALSE,TRUE,'None',13,82,93,56);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,FALSE,'Bombay',TRUE,'Arman','male',14,FALSE,FALSE,'None',10,100,33,57);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Persian',TRUE,'Maurise','male',15,FALSE,TRUE,'None',9,37,44,58);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'American Shorthair',TRUE,'Cory','female',21,TRUE,FALSE,'None',12,24,36,59);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,TRUE,'Ragdoll',TRUE,'Rolf','female',14,FALSE,FALSE,'None',10,85,21,60);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Bombay',TRUE,'Cristionna','male',11,TRUE,FALSE,'None',14,49,44,61);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Domestic Shorthair',FALSE,'Ashlee','female',11,FALSE,TRUE,'None',9,13,10,62);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,TRUE,'Persian',TRUE,'Silvie','female',17,TRUE,FALSE,'None',9,35,85,63);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Persian',FALSE,'Cara','female',19,TRUE,FALSE,'None',14,14,42,64);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,TRUE,'Russian Blue',TRUE,'Agnella','female',11,FALSE,TRUE,'None',12,84,49,65);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,FALSE,TRUE,'Domestic Longhair',TRUE,'Adolpho','male',6,TRUE,TRUE,'None',9,80,38,66);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,TRUE,'Bombay',TRUE,'Martita','female',23,TRUE,TRUE,'None',9,68,83,67);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Russian Blue',FALSE,'Obadias','male',22,TRUE,FALSE,'None',9,18,57,68);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Bengal',TRUE,'Maryl','male',6,TRUE,FALSE,'None',11,88,15,69);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,FALSE,'Bombay',FALSE,'Lyndel','female',19,FALSE,TRUE,'None',9,52,40,70);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,FALSE,'Bengal',TRUE,'Nora','male',11,FALSE,FALSE,'None',15,64,2,71);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,TRUE,TRUE,'Bombay',TRUE,'Ynez','male',14,TRUE,FALSE,'None',11,24,54,72);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,FALSE,FALSE,'Persian',FALSE,'Cleavland','male',16,TRUE,FALSE,'None',15,19,50,73);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,FALSE,'Siamese',TRUE,'Eolande','male',9,TRUE,FALSE,'None',8,44,57,74);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,FALSE,'Domestic Longhair',FALSE,'Lucas','female',22,TRUE,TRUE,'None',15,93,97,75);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,TRUE,'Persian',FALSE,'Lusa','male',9,TRUE,FALSE,'None',8,22,66,76);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Maine Coon',TRUE,'Dori','female',19,FALSE,TRUE,'None',8,28,47,77);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,FALSE,'Bengal',TRUE,'Duane','male',7,TRUE,TRUE,'None',14,86,50,78);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,FALSE,'Ragdoll',FALSE,'Lorianna','male',8,FALSE,TRUE,'None',14,78,78,79);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Persian',TRUE,'Wyn','female',15,FALSE,TRUE,'None',9,90,98,80);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,FALSE,TRUE,'Russian Blue',TRUE,'Ada','male',22,TRUE,TRUE,'None',10,89,22,81);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,TRUE,TRUE,'Domestic Longhair',FALSE,'Austina','male',21,TRUE,TRUE,'None',15,94,36,82);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Siamese',TRUE,'Adelice','male',9,TRUE,TRUE,'None',8,63,34,83);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,TRUE,'Ragdoll',TRUE,'Jarrid','female',15,FALSE,FALSE,'None',10,4,65,84);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,TRUE,FALSE,'Russian Blue',TRUE,'Les','female',8,FALSE,TRUE,'None',11,74,12,85);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Maine Coon',TRUE,'Jaime','female',23,TRUE,TRUE,'None',15,53,23,86);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Bombay',TRUE,'Kevin','female',6,TRUE,TRUE,'None',15,48,19,87);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,TRUE,TRUE,'Bombay',FALSE,'Loree','female',18,FALSE,FALSE,'None',14,65,81,88);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,TRUE,'Siamese',TRUE,'Gert','male',21,TRUE,FALSE,'None',9,67,56,89);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,FALSE,'Ragdoll',TRUE,'Quintilla','male',21,TRUE,TRUE,'None',11,2,58,90);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,TRUE,'Persian',TRUE,'Terrill','female',8,TRUE,FALSE,'None',13,46,3,91);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,TRUE,TRUE,'Bombay',TRUE,'Emili','male',10,FALSE,FALSE,'None',15,97,63,92);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (2,TRUE,FALSE,'American Shorthair',TRUE,'Joannes','female',1,TRUE,FALSE,'None',12,34,22,93);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Domestic Shorthair',TRUE,'Chuck','female',20,FALSE,TRUE,'None',9,74,32,94);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,FALSE,'Persian',TRUE,'Lurleen','male',20,TRUE,TRUE,'None',8,47,28,95);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,FALSE,FALSE,'Bengal',FALSE,'Perkin','female',23,FALSE,FALSE,'None',8,36,41,96);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (3,FALSE,TRUE,'Russian Blue',FALSE,'Adam','male',3,FALSE,TRUE,'None',15,48,1,97);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (5,TRUE,TRUE,'Ragdoll',FALSE,'Rosie','female',19,TRUE,TRUE,'None',13,65,11,98);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (4,FALSE,FALSE,'Siamese',FALSE,'Maggee','female',10,FALSE,TRUE,'None',11,99,65,99);
INSERT INTO cat(location,need_food,need_litter_cleaning,breed,chip_status,name_cat,sex,age,neutered,temperament,dietary_restrictions,weight,caretaker_id,vet_id,catID) VALUES (1,FALSE,FALSE,'Persian',FALSE,'Imelda','female',5,TRUE,TRUE,'None',9,1,83,100);


-- Inputting data for table 'veterinaryNurse'

INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('782-692-1375','umccandie0@wordpress.org','anesthesia','Ugo','McCandie',82,1);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('709-606-1508','jvanderbeek1@ning.com','x-ray','Janaye','Van der Beek',48,2);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('399-133-7024','emclarty2@wsj.com','medicine administration','Eugine','McLarty',15,3);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('743-112-4267','alomax3@pagesperso-orange.fr','x-ray','Anthia','Lomax',92,4);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('535-944-1818','mfeveryear4@zimbio.com','medicine administration','Morrie','Feveryear',16,5);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('252-308-6377','csebring5@vk.com','x-ray','Clay','Sebring',74,6);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('485-217-9474','fseear6@over-blog.com','anesthesia','Fred','Seear',9,7);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('170-292-2907','akira7@weather.com','anesthesia','Adham','Kira',63,8);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('366-577-6379','splaskitt8@youtu.be','x-ray','Schuyler','Plaskitt',39,9);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('604-937-0998','igravener9@sitemeter.com','medicine administration','Idalia','Gravener',88,10);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('775-421-4845','aklichea@foxnews.com','medicine administration','Adelina','Kliche',85,11);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('608-187-0545','fomullenb@sfgate.com','anesthesia','Fayth','O Mullen',37,12);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('229-784-3139','cmossdalec@mapquest.com','anesthesia','Colin','Mossdale',45,13);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('785-696-5056','fbatchelourd@economist.com','x-ray','Fifi','Batchelour',68,14);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('527-179-2130','lburnse@telegraph.co.uk','medicine administration','Laurie','Burns',34,15);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('670-445-0163','ksecrettf@walmart.com','anesthesia','Karie','Secrett',49,16);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('661-230-2224','bwilcherg@webeden.co.uk','anesthesia','Berna','Wilcher',30,17);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('878-480-8150','msodorh@nifty.com','x-ray','Mayne','Sodor',15,18);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('370-920-3684','kswaingeri@ycombinator.com','anesthesia','Kelcie','Swainger',20,19);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('714-987-1707','foldroydej@vk.com','medicine administration','Francisca','Oldroyde',84,20);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('138-891-1271','bmacranaldk@cbslocal.com','anesthesia','Bealle','MacRanald',28,21);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('647-670-6220','gpelchatl@dropbox.com','x-ray','Gardy','Pelchat',98,22);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('108-764-0484','bclaughtonm@xing.com','medicine administration','Bradney','Claughton',42,23);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('306-418-3928','nletertren@dropbox.com','x-ray','Nedda','Letertre',4,24);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('704-331-1873','ffautlyo@freewebs.com','medicine administration','Fidel','Fautly',72,25);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('492-598-0536','ldaykinp@yahoo.com','anesthesia','Leland','Daykin',36,26);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('594-266-1587','bdevennyq@cmu.edu','medicine administration','Bobby','Devenny',72,27);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('439-347-9631','rferrareser@nbcnews.com','anesthesia','Rex','Ferrarese',91,28);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('698-845-5030','tlangfitts@cbslocal.com','medicine administration','Tiffi','Langfitt',72,29);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('198-574-8644','mwillst@sohu.com','anesthesia','Maure','Wills',58,30);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('748-891-0097','kseamarku@netvibes.com','anesthesia','Karlotta','Seamark',42,31);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('215-266-9985','tderyebarrettv@360.cn','x-ray','Timothee','De Rye Barrett',34,32);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('100-160-2404','meagleshamw@hc360.com','medicine administration','Mattias','Eaglesham',46,33);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('419-825-6872','hfiveyx@bing.com','medicine administration','Hermie','Fivey',29,34);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('106-304-2598','ybarnfathery@facebook.com','medicine administration','Yves','Barnfather',88,35);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('731-438-4067','jsemeniukz@simplemachines.org','medicine administration','Jelene','Semeniuk',67,36);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('372-370-7646','vfortman10@simplemachines.org','anesthesia','Verina','Fortman',62,37);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('175-167-5962','dhartzog11@cafepress.com','x-ray','Doy','Hartzog',40,38);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('928-405-9756','telijah12@issuu.com','medicine administration','Tiffi','Elijah',76,39);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('564-634-2348','cdrust13@columbia.edu','x-ray','Conrade','Drust',72,40);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('314-328-0813','gvlasyuk14@hp.com','x-ray','Glenda','Vlasyuk',38,41);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('940-974-9738','poriordan15@google.nl','medicine administration','Prudi','O''Riordan',44,42);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('762-644-1397','sgraser16@discuz.net','x-ray','Susanetta','Graser',74,43);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('974-716-6347','bbrunke17@si.edu','x-ray','Brandy','Brunke',40,44);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('809-618-5210','gneem18@cocolog-nifty.com','anesthesia','Gaultiero','Neem',80,45);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('785-638-6392','mjoerning19@fema.gov','x-ray','Meier','Joerning',46,46);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('766-412-2907','estathers1a@wsj.com','anesthesia','Evin','Stathers',71,47);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('138-745-1609','lingyon1b@cbsnews.com','x-ray','Lindsy','Ingyon',65,48);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('651-825-8563','spherps1c@upenn.edu','x-ray','Shell','Pherps',61,49);
INSERT INTO veterinaryNurse(phone_number,work_email,qualification,first_name,last_name,vet_id,nurseID) VALUES ('151-149-3137','agodsell1d@constantcontact.com','medicine administration','Ahmed','Godsell',52,50);


-- Inputting data for table 'OperationVolunteer'

INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Burk','Edginton','bedginton0@dailymail.co.uk','517-820-9917',49,1);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Kermy','Normansell','knormansell1@imageshack.us','763-962-5648',5,2);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Jess','Dzenisenka','jdzenisenka2@dion.ne.jp','176-737-8421',25,3);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Jameson','Crudginton','jcrudginton3@goo.ne.jp','962-458-6912',11,4);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Richmound','Woodage','rwoodage4@instagram.com','374-889-5387',24,5);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Colan','Lockie','clockie5@cisco.com','306-257-5254',48,6);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Alejoa','Hold','ahold6@cbc.ca','710-975-3033',17,7);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Harwilll','Gages','hgages7@netlog.com','603-681-1360',29,8);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Blondell','Morville','bmorville8@netlog.com','257-536-2729',39,9);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Gail','Crenshaw','gcrenshaw9@cdbaby.com','856-400-3299',5,10);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Kathryn','Pittendreigh','kpittendreigha@army.mil','179-600-5098',38,11);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Welbie','Cornew','wcornewb@biblegateway.com','659-499-5088',20,12);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Laney','Bedboro','lbedboroc@parallels.com','836-615-8967',43,13);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Damien','McLaine','dmclained@earthlink.net','892-194-8538',18,14);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Manon','Runnacles','mrunnaclese@constantcontact.com','390-337-0608',45,15);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Maurise','Cattrell','mcattrellf@wisc.edu','914-140-0750',43,16);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Daisi','Fearns','dfearnsg@diigo.com','933-685-0564',30,17);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Joseph','Trundell','jtrundellh@amazon.de','253-252-6085',12,18);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Moll','Glencorse','mglencorsei@flickr.com','656-198-4701',17,19);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Gualterio','Hatchman','ghatchmanj@yahoo.co.jp','964-901-0604',6,20);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Minerva','Loins','mloinsk@mashable.com','768-620-5606',8,21);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Betsey','Stephens','bstephensl@moonfruit.com','113-896-3318',19,22);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Maria','Androck','mandrockm@auda.org.au','139-488-5930',40,23);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Josee','Walkley','jwalkleyn@google.com','150-867-6018',17,24);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Cash','Crockley','ccrockleyo@issuu.com','166-121-0512',25,25);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Dory','Rainon','drainonp@ycombinator.com','901-311-9505',39,26);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Babbie','Hanster','bhansterq@qq.com','278-825-5725',5,27);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Patrick','Tench','ptenchr@hp.com','189-318-4041',25,28);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Anallese','Fawcus','afawcuss@weibo.com','164-694-2870',48,29);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Alameda','Coward','acowardt@redcross.org','170-687-5555',30,30);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Rubi','Abelson','rabelsonu@nih.gov','260-634-5677',1,31);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Whitney','Phetteplace','wphetteplacev@latimes.com','229-383-3043',49,32);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Brianna','MacInnes','bmacinnesw@cnet.com','227-636-9354',24,33);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Kare','London','klondonx@bandcamp.com','861-165-2811',36,34);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Caresse','Anniwell','canniwelly@google.nl','524-887-9686',17,35);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Cletus','Pilcher','cpilcherz@ning.com','474-128-8605',30,36);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Norbert','Simenon','nsimenon10@dell.com','204-629-1324',45,37);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Lillis','Cutill','lcutill11@ycombinator.com','290-115-9810',5,38);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Sheff','Farmiloe','sfarmiloe12@adobe.com','271-523-1848',27,39);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('West','Toma','wtoma13@blogtalkradio.com','714-584-7661',43,40);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Joella','Brader','jbrader14@telegraph.co.uk','745-531-0991',15,41);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Valaree','Fulger','vfulger15@chicagotribune.com','243-737-7607',22,42);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Pate','Whettleton','pwhettleton16@samsung.com','753-108-8492',16,43);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Kristofor','Lintall','klintall17@patch.com','422-269-5773',27,44);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Sanford','Gange','sgange18@foxnews.com','554-231-5188',13,45);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Selina','Trembley','strembley19@istockphoto.com','301-941-6151',8,46);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Ulrica','Basilio','ubasilio1a@vinaora.com','137-707-3125',4,47);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Zia','Giraudeau','zgiraudeau1b@ibm.com','175-879-2577',30,48);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Raphael','Loch','rloch1c@example.com','521-861-9797',40,49);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Ulla','Mowat','umowat1d@google.com.au','272-299-7548',8,50);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Thorin','Slyvester','tslyvester1e@xinhuanet.com','934-383-6563',50,51);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Nefen','Crean','ncrean1f@bigcartel.com','591-927-2097',17,52);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Florette','Guiduzzi','fguiduzzi1g@comcast.net','747-617-1818',30,53);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Waly','Eagles','weagles1h@mapy.cz','922-837-6633',46,54);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Bliss','Lasslett','blasslett1i@spiegel.de','332-736-5711',23,55);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Corissa','Rochford','crochford1j@de.vu','449-651-5289',26,56);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Devonna','Tritten','dtritten1k@bbc.co.uk','264-345-4088',50,57);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Sherline','Scammell','sscammell1l@shareasale.com','271-348-6972',36,58);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Margie','Terese','mterese1m@opera.com','905-668-3439',30,59);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Frieda','Taig','ftaig1n@bloglines.com','726-227-5528',44,60);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Ellswerth','Warstall','ewarstall1o@ameblo.jp','127-367-5038',2,61);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Britteny','Peaden','bpeaden1p@patch.com','718-856-7192',38,62);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Brennen','Rouff','brouff1q@mozilla.com','584-431-7519',50,63);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Igor','Geake','igeake1r@wunderground.com','372-352-9548',20,64);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Nissa','Merrigan','nmerrigan1s@bing.com','204-381-6898',6,65);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Shepperd','Celier','scelier1t@webeden.co.uk','767-533-0262',1,66);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Celestia','Bellingham','cbellingham1u@yellowpages.com','649-855-8038',5,67);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Siobhan','Noweak','snoweak1v@infoseek.co.jp','763-156-5307',22,68);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Marilyn','Jonson','mjonson1w@cisco.com','210-762-8053',24,69);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Peg','Castellani','pcastellani1x@bandcamp.com','943-826-3223',8,70);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Jessi','Yatman','jyatman1y@ocn.ne.jp','620-971-5579',4,71);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Cinnamon','Bedow','cbedow1z@cbc.ca','719-719-0746',41,72);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Hilario','Citrine','hcitrine20@ebay.com','772-806-2509',14,73);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Brennan','Weild','bweild21@creativecommons.org','738-806-1735',28,74);
INSERT INTO OperationVolunteer(first_name,last_name,work_email,phone_number,coordinator_id,operation_id) VALUES ('Kevon','Jahnel','kjahnel22@cnbc.com','596-764-6713',42,75);


-- Inputting data for table 'supplier'

INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Zuzana','Rochford','zrochford0@deviantart.com','796-385-3108',29,1);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Michele','Troucher','mtroucher1@house.gov','426-507-3055',63,2);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Currey','McCall','cmccall2@jigsy.com','173-802-9407',49,3);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Vonnie','Capineer','vcapineer3@jigsy.com','142-210-8620',18,4);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Trina','Philliphs','tphilliphs4@fda.gov','414-974-1576',35,5);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Gibb','Shreenan','gshreenan5@time.com','127-331-7883',39,6);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Dulcy','Lumsdaine','dlumsdaine6@oracle.com','389-876-5583',54,7);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Gallagher','Knewstub','gknewstub7@wiley.com','194-692-2521',64,8);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Georas','Guinery','gguinery8@constantcontact.com','261-885-9815',22,9);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Rosene','Fluit','rfluit9@over-blog.com','735-811-3623',71,10);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Barret','Wedderburn','bwedderburna@i2i.jp','341-873-3174',62,11);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Donna','Rebanks','drebanksb@archive.org','878-786-8650',37,12);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Dud','Sutherel','dsutherelc@livejournal.com','860-546-5683',19,13);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Ripley','Buxcy','rbuxcyd@wix.com','374-727-5677',2,14);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Gayla','Govey','ggoveye@fastcompany.com','782-705-7216',46,15);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Troy','Goligly','tgoliglyf@rediff.com','232-856-7193',35,16);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Jonathon','Arnell','jarnellg@51.la','376-674-2370',65,17);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Barnabe','Ayars','bayarsh@techcrunch.com','116-232-8559',50,18);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Claudetta','Formilli','cformillii@state.tx.us','317-626-2858',7,19);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Torie','Soughton','tsoughtonj@bloglovin.com','898-871-7504',31,20);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Sydelle','Selman','sselmank@msn.com','488-478-8990',45,21);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Payton','Kaming','pkamingl@youtube.com','529-447-4686',18,22);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Karlotte','Stoter','kstoterm@amazon.de','874-603-2891',13,23);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Rozina','Shakeshaft','rshakeshaftn@example.com','307-294-0094',66,24);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Idell','Labden','ilabdeno@seattletimes.com','644-855-3038',72,25);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Layton','Leipnik','lleipnikp@t-online.de','744-349-8026',25,26);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Torey','Wedmore','twedmoreq@netlog.com','561-473-7034',45,27);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Lucho','Helliker','lhellikerr@ovh.net','830-594-4752',15,28);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Egon','Pottle','epottles@ehow.com','290-195-3339',46,29);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Philomena','Lebang','plebangt@altervista.org','174-667-3866',56,30);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Bram','Hanton','bhantonu@prnewswire.com','614-128-9149',33,31);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Heddi','Franck','hfranckv@mashable.com','971-574-4503',36,32);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Vivian','Kezar','vkezarw@wikispaces.com','497-236-7170',33,33);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Mufi','Goggins','mgogginsx@buzzfeed.com','175-495-6077',40,34);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Dani','Karpf','dkarpfy@chicagotribune.com','225-765-1566',37,35);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Irwinn','Schirak','ischirakz@census.gov','234-557-6997',22,36);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Ralina','Rappoport','rrappoport10@themeforest.net','826-866-8753',31,37);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Livy','Boumphrey','lboumphrey11@live.com','780-291-2823',28,38);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Priscilla','Potes','ppotes12@usda.gov','754-130-0109',67,39);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Raleigh','Butterfield','rbutterfield13@reddit.com','595-233-3276',56,40);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Bryn','Gherardi','bgherardi14@elegantthemes.com','570-885-4535',3,41);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Ainsley','Von Hindenburg','avonhindenburg15@usda.gov','887-518-1927',35,42);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Emilie','Georgeson','egeorgeson16@e-recht24.de','229-319-6110',65,43);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Madelene','Imeson','mimeson17@cnn.com','435-150-1162',71,44);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Kat','Belderson','kbelderson18@engadget.com','971-646-0537',17,45);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Kristien','Sanger','ksanger19@squidoo.com','154-127-9500',18,46);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Abbie','Linzee','alinzee1a@netscape.com','480-445-2906',54,47);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Ashely','Frankling','afrankling1b@answers.com','147-425-9447',73,48);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Ronnie','Pideon','rpideon1c@live.com','746-402-2311',8,49);
INSERT INTO supplier(first_name,last_name,service_rep_email,service_rep_phone_number,operation_id,supplierID) VALUES ('Ozzy','Weiss','oweiss1d@blogspot.com','226-260-0711',70,50);


-- Inputting data into AnimalInventory

INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',32,'Dog Food','11/8/2022',53,1);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',6,'Litter Box','12/11/2022',19,2);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petco',32,'Poop Bag','4/26/2022',27,3);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',48,'Cat Food','4/25/2022',52,4);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',44,'Poop Bag','3/7/2023',35,5);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',6,'Dog Toy','12/8/2022',44,6);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',24,'Cat Food','9/14/2022',52,7);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petco',11,'Poop Bag','5/7/2022',53,8);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',30,'Cat Food','5/21/2022',6,9);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',35,'Poop Bag','2/10/2023',66,10);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',22,'Cat Toy','9/5/2022',35,11);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',2,'Poop Bag','6/17/2022',12,12);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petco',73,'Cat Treat','7/28/2022',64,13);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',23,'Dog Toy','8/17/2022',51,14);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',36,'Cat Treat','5/7/2022',16,15);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',68,'Cat Food','7/30/2022',46,16);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',73,'Dog Food','12/24/2022',36,17);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',98,'Cat Food','9/8/2022',19,18);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',75,'Dog Toy','3/23/2023',9,19);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',10,'Cat Toy','5/26/2022',23,20);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',38,'Cat Toy','1/7/2023',51,21);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',81,'Leash','8/20/2022',40,22);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',46,'Cat Food','11/29/2022',74,23);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',1,'Cat Toy','7/24/2022',58,24);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',19,'Cat Food','8/12/2022',50,25);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',88,'Poop Bag','1/12/2023',20,26);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petco',27,'Dog Toy','4/23/2022',62,27);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',52,'Cat Treat','3/25/2023',22,28);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',76,'Poop Bag','6/5/2022',44,29);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',41,'Dog Food','5/25/2022',32,30);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petco',39,'Litter Box','6/6/2022',5,31);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',54,'Leash','4/17/2023',69,32);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',7,'Cat Toy','10/20/2022',69,33);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',80,'Dog Food','6/12/2022',10,34);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',8,'Dog Food','6/11/2022',58,35);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',34,'Dog Treat','12/25/2022',30,36);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',1,'Leash','6/1/2022',12,37);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',30,'Cat Food','11/11/2022',36,38);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Happy Pet',19,'Dog Toy','12/29/2022',2,39);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',84,'Litter Box','10/21/2022',51,40);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',89,'Cat Food','10/26/2022',47,41);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('PetSmart',67,'Leash','1/18/2023',26,42);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',94,'Poop Bag','11/19/2022',24,43);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',54,'Cat Food','6/6/2022',70,44);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',74,'Cat Food','7/21/2022',9,45);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Wholesale Pet',59,'Poop Bag','1/3/2023',10,46);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',77,'Cat Treat','1/13/2023',50,47);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petco',90,'Poop Bag','10/4/2022',58,48);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',18,'Litter Box','9/13/2022',6,49);
INSERT INTO AnimalInventory(brand,quantity,item_category,date_received,operation_id,item_id) VALUES ('Petmate',41,'Dog Treat','7/21/2022',71,50);



-- Inputting data for table 'Donor'

INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Cameron','Buxey','497-794-4495',579.06,33,1);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jeane','Lowthian','918-459-9698',398.1,10,2);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Shane','Borrill','455-302-6090',11.6,19,3);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Mikaela','Snugg','471-818-4247',843.93,60,4);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Franky','Ors','287-349-1002',545.83,68,5);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Robb','Sarge','742-195-0749',349.82,28,6);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jenna','Blyden','700-278-9144',737.0,7,7);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Crystal','Delieu','232-703-2721',947.18,10,8);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Germaine','Meriot','541-642-9544',932.83,72,9);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Luella','Balog','897-783-7743',545.48,75,10);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Madelena','Grice','898-592-0391',728.63,75,11);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Bea','Moyler','202-407-1889',253.16,38,12);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Berri','Hodgets','978-130-8620',624.57,74,13);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Claretta','Raulston','495-814-8638',535.63,69,14);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Earl','Ellicott','995-909-6049',270.91,60,15);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Margette','Caldera','480-498-3101',858.89,74,16);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Noemi','Cunnow','697-871-1160',260.77,10,17);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Micheline','Kenningham','126-346-3345',196.74,44,18);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jae','Levicount','286-514-9970',24.06,59,19);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jan','Filpo','911-888-9485',737.13,36,20);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Billy','Fakes','206-873-9305',744.67,48,21);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Devland','Penniell','589-543-7353',774.13,32,22);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Brand','Dener','609-346-9132',58.73,74,23);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Stevie','Vaun','267-313-2753',282.74,73,24);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jeannette','Isacsson','798-292-6216',727.0,56,25);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Martin','Tacey','286-130-5194',235.39,32,26);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Pietro','Cartlidge','615-533-9582',966.06,31,27);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Arlinda','Corrao','196-677-8743',620.71,43,28);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Sydney','Beaman','770-988-2624',912.7,74,29);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Ron','Pechet','476-891-2334',472.62,34,30);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Dulsea','Kunzler','151-765-8239',41.59,23,31);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Gayelord','Moorman','871-562-3121',577.3,3,32);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Hermie','Goodee','441-526-4253',739.19,7,33);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Leonanie','Attryde','941-800-2912',682.06,11,34);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Leola','Haquard','863-165-0926',1.3,60,35);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jaquenette','Headrick','537-765-8752',994.3,26,36);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Sheffie','Elford','552-305-8083',63.12,63,37);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Ase','Braams','935-852-5125',607.57,39,38);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Flint','Taffarello','870-189-1323',286.02,16,39);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Chandler','Brede','876-515-4484',255.15,31,40);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Ebonee','Sockell','340-124-6287',720.06,41,41);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Bartholomew','De Antoni','304-908-1415',681.79,35,42);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Izaak','Missen','492-502-9108',292.87,23,43);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Shell','Bugdale','653-859-3312',263.33,8,44);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Joly','Beardmore','884-479-6583',745.65,62,45);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Inness','London','362-122-2281',230.97,39,46);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Dredi','Oldknowe','381-805-3357',721.87,15,47);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Worthington','Whittock','800-183-0437',199.81,52,48);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Karney','Roddy','738-541-5101',860.59,50,49);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Bradan','Bricket','571-633-5853',89.59,9,50);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Lamont','Sesons','142-734-9977',270.94,41,51);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Port','Lyburn','680-390-3503',516.45,23,52);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Kerstin','Deane','208-771-4819',90.12,44,53);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Tybalt','Southcoat','661-103-2748',219.4,36,54);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Marta','Laffan','891-659-9800',287.21,6,55);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Laurie','McDuffie','215-146-5121',393.13,63,56);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Winston','Alabaster','805-232-9907',343.41,53,57);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Melisenda','Shackleford','988-718-6788',432.75,10,58);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Haley','Josovich','304-549-9365',390.68,61,59);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Scot','Rosenblatt','381-581-3471',380.88,46,60);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Arni','Hammerich','344-425-1663',257.78,31,61);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Micheal','Benninger','666-350-9692',320.68,26,62);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Olga','Kayser','825-904-4223',812.88,17,63);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Arlyn','Gabriely','732-580-6096',694.61,27,64);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Lexy','Peidro','335-215-9386',401.11,58,65);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Pepillo','Kaspar','374-463-8544',766.2,7,66);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Giuditta','Curtain','803-275-5761',875.81,15,67);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Vance','Harlick','361-928-7501',430.65,21,68);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Beryl','Imlaw','123-730-1528',530.76,46,69);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Karin','Reddie','808-996-3303',756.32,14,70);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Byrann','Trythall','155-672-9795',874.68,31,71);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Connie','Sketch','316-487-4325',610.72,48,72);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Taffy','Tailby','912-561-1653',525.15,30,73);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Hermine','Elbourne','283-552-7294',946.43,72,74);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Candie','Kesey','326-485-8712',575.8,1,75);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Irwinn','McArd','758-531-5716',518.3,68,76);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Leslie','Whittam','472-436-2242',879.08,26,77);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Matt','Joanic','578-247-4942',246.42,32,78);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Elsy','Ivanchikov','691-461-3914',45.25,75,79);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Munmro','Warn','491-138-7401',859.05,38,80);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Constantin','Pinhorn','415-348-3151',219.26,58,81);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Glennis','Leadston','148-321-6131',240.68,28,82);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Issiah','Dantesia','611-466-2032',369.32,61,83);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Juline','Lemanu','925-551-5705',230.34,72,84);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Brand','Shiel','937-466-0719',546.94,12,85);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Ardelis','Paten','251-471-6353',71.01,6,86);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Kleon','Rooksby','362-776-3915',813.61,17,87);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Arlan','Biggadike','999-373-1783',750.5,55,88);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Lolly','Goodlud','176-923-0082',687.02,11,89);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Jarid','Safont','823-905-6745',88.36,67,90);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Monica','Itzakovitz','488-105-3105',563.37,31,91);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Paxon','Casewell','852-167-6100',245.24,36,92);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Marcella','Trodden','452-747-0453',943.35,7,93);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Granthem','Urrey','557-207-5952',606.74,72,94);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Marty','Goodchild','780-999-5796',658.71,75,95);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Peder','Stripling','404-389-3700',501.84,9,96);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Petrina','Markus','271-333-2198',591.54,12,97);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Lorinda','Alessandone','773-436-0830',154.12,6,98);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Nonna','Burner','421-809-7288',407.17,5,99);
INSERT INTO Donor(first_name,last_name,phone_number,donation_amount,operation_id,donation_id) VALUES ('Eadie','Nials','130-900-5210',814.55,21,100);
