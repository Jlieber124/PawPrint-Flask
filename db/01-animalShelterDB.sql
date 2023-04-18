CREATE DATABASE IF NOT EXISTS animalShelter;

grant all privileges on animalShelter.* to 'webapp'@'%';
flush privileges;

USE animalShelter;

DROP TABLE IF EXISTS CaretakerVolunteer;
DROP TABLE IF EXISTS OperationVolunteer;
DROP TABLE IF EXISTS Donor;
DROP TABLE IF EXISTS Visitor;

CREATE TABLE IF NOT EXISTS volunteerCoordinator(
    coordinator_id INTEGER UNIQUE NOT NULL,
    work_email VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    number_volunteers INTEGER NOT NULL,
    PRIMARY KEY (coordinator_id)
);

CREATE TABLE IF NOT EXISTS receptionist (
    employee_id INTEGER UNIQUE NOT NULL,
    floor INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    language VARCHAR(50) NOT NULL,
    work_email VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    coordinator_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (employee_id),
    CONSTRAINT coordID
       FOREIGN KEY (coordinator_id) REFERENCES volunteerCoordinator(coordinator_id)
);

CREATE TABLE IF NOT EXISTS CaretakerVolunteer
(
    work_email    VARCHAR(50) UNIQUE,
    experience     INTEGER     NOT NULL,
    caretaker_id   INTEGER     UNIQUE NOT NULL,
    first_name    VARCHAR(50) NOT NULL,
    last_name     VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    animal_speciality VARCHAR(50) NOT NULl,
    coordinator_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (caretaker_id),
    CONSTRAINT coordIDC
        FOREIGN KEY (coordinator_id) REFERENCES volunteerCoordinator(coordinator_id)
);

CREATE TABLE IF NOT EXISTS OperationVolunteer
(
    operation_id INTEGER UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    work_email VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    coordinator_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY (operation_id),
    CONSTRAINT opID
        FOREIGN KEY (coordinator_id) REFERENCES volunteerCoordinator(coordinator_id)
);

CREATE TABLE IF NOT EXISTS AnimalInventory (
    item_id INTEGER UNIQUE NOT NULL,
    price FLOAT(2) NOT NULL,
    brand VARCHAR(50) NOT NULL,
    quantity INTEGER NOT NULL,
    item_category VARCHAR(50) NOT NULL,
    date_received DATETIME NOT NULL,
    operation_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(item_id),
    CONSTRAINT opIDAI
        FOREIGN KEY (operation_id) REFERENCES OperationVolunteer(operation_id)
);

CREATE TABLE IF NOT EXISTS Donor (
    donation_id INTEGER UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    donation_amount FLOAT(2) NOT NULL,
    operation_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(donation_id),
    CONSTRAINT opIDD
        FOREIGN KEY (operation_id) REFERENCES OperationVolunteer(operation_id)
);

CREATE TABLE IF NOT EXISTS Visitor (
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VAR(15) NOT NULL,
    visit_time DATETIME NOT NULL,
    animal_interest VARCHAR(50) NOT NULL,
    PRIMARY KEY(visit_time, last_name)
);

CREATE TABLE IF NOT EXISTS Rec_Vis(
    employee_id INTEGER UNIQUE NOT NULL,
    visit_time DATETIME NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (employee_id, visit_time, last_name),
    CONSTRAINT empID
        FOREIGN KEY (employee_id) REFERENCES receptionist (employee_id),
    CONSTRAINT vLlN
        FOREIGN KEY (visit_time) REFERENCES Visitor (visit_time),
    CONSTRAINT vLN
        FOREIGN KEY (last_name)) REFERENCES Visitor (last_name)
);

CREATE TABLE IF NOT EXISTS vetClinician (
    vetID INTEGER UNIQUE NOT NULL,
    field_concentration VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    work_email VARCHAR(50) UNIQUE NOT NULL,
    phone_number VARCHAT(15) UNIQUE NOT NULL,
    degree VARCHAR(50) NOT NULL,
    PRIMARY KEY(vetID)
);


CREATE TABLE IF NOT EXISTS veterinaryNurse (
    nurseID INTEGER UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    work_email VARCHAR(50) UNIQUE NOT NULL,
    qualification VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    vet_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(nurseID),
    CONSTRAINT vID
        FOREIGN KEY (vet_id) REFERENCES vetClinician(vetID)
);

CREATE TABLE IF NOT EXISTS dog (
    dogID INTEGER UNIQUE NOT NULL,
    location INTEGER UNIQUE NOT NULL,
    walk_duration INTEGER NOT NULL,
    group_play_time DATETIME NOT NULL,
    need_food BOOLEAN NOT NULL,
    need_clean BOOLEAN NOT NULL,
    need_walk BOOLEAN NOT NULL,
    temperament BOOLEAN NOT NULL,
    name_dog VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    chip_status BOOLEAN NOT NULL,
    breed VARCHAR(50) NOT NULL,
    weight INTEGER NOT NULL,
    housebroken BOOLEAN NOT NULL,
    temperament BOOLEAN NOT NULL,
    dietary_restriction VARCHAR(50) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    caretaker_id INTEGER UNIQUE NOT NULL,
    vet_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(dogID),
    CONSTRAINT caretakeID
        FOREIGN KEY (caretaker_id) REFERENCES CaretakerVolunteer(caretaker_id),
    CONSTRAINT vetid
        FOREIGN KEY (vet_id)  REFERENCES vetClinician(vetID)
);

CREATE TABLE IF NOT EXISTS cat (
    catID INTEGER UNIQUE NOT NULL,
    location INTEGER NOT NULL,
    need_food BOOLEAN NOT NULL,
    need_liter_cleaning BOOLEAN NOT NULL,
    breed VARCHAR(50) NOT NULL,
    chip_status BOOLEAN NOT NULL,
    name_cat VARCHAR(50) NOT NULL,
    sex VARCHAR(50) NOT NULL,
    age VARCHAR(50) NOT NULL,
    neutered BOOLEAN NOT NULL,
    dietary_restrictions VARCHAR(50) NOT NULL,
    weight INTEGER NOT NULL,
    caretaker_id INTEGER UNIQUE NOT NULL,
    vet_id INTEGER UNIQUE NOT NULL,
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
    opertation_id INTEGER UNIQUE NOT NULL,
    PRIMARY KEY(supplierID),
    CONSTRAINT opIDSuplier
        FOREIGN KEY (opertation_id) REFERENCES OperationVolunteer(operation_id)
);
