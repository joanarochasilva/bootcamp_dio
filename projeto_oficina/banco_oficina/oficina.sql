CREATE DATABASE oficina;
USE oficina;

-- cria tabela mecânico

CREATE TABLE mechanic (
	CREA CHAR(5) PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    fName VARCHAR(15) NOT NULL,
    mName VARCHAR(15),
    lName VARCHAR(15) NOT NULL,
    publicPlace ENUM('Alameda', 'Avenida', 'Condomínio', 'Conjunto', 'Distrito', 'Estrada', 'Ladeira', 'Rua', 'Travessa', 'Vila', 'Outro') NOT NULL,
    localAdress VARCHAR(30) NOT NULL,
    houseNumber INT NOT NULL,
    complementAdress VARCHAR(20),
    district VARCHAR(30) NOT NULL,
    city VARCHAR(15) NOT NULL,
    dddNumber TINYINT(2),
    cellPrefixNumber TINYINT(4),
    cellSufixNumber TINYINT(4)
);

-- cria tabela veículo
CREATE TABLE vehicle(
	licensePlate CHAR(7) PRIMARY KEY,
    idClientVehicle INT,
    idMechanicVehicle INT,
    yearLicensePlate YEAR(4),
    RENAVAM VARCHAR(9) NOT NULL UNIQUE,
    model VARCHAR(30) NOT NULL,
    brand VARCHAR(30) NOT NULL,
    CONSTRAINT fk_vehicle_mechanic FOREIGN KEY(idMechanicVehicle) REFERENCES mechanic(CREA),
    CONSTRAINT fk_client_vehicle FOREIGN KEY(idClientVehicle) REFERENCES clients(idClient)
);

-- cria tabela veiculo pesado
CREATE TABLE heavyVehicle(
	idHeavyVehicle INT AUTO_INCREMENT PRIMARY KEY,
	idLicensePlate CHAR(7),
    size FLOAT NOT NULL,
    weight FLOAT NOT NULL,
    numberSteeringAxis INT,
    CONSTRAINT fk_heavyVehicle_vehicle FOREIGN KEY(idLicensePlate) REFERENCES vehicle(licensePlate)
);

-- cria tabela cliente
CREATE TABLE clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
	CNH VARCHAR(11),
    fName VARCHAR(15) NOT NULL,
    mName VARCHAR(10),
    lName VARCHAR(15) NOT NULL,
    dddNumber TINYINT(2),
    cellPrefixNumber TINYINT(4),
    cellSufixNumber TINYINT(4)
);

-- cria tabela mecânico/veículo
CREATE TABLE mechanicVehicle(
	idMVmechanic INT,
    idMVvehicle INT,
    datehHourReview DATETIME NOT NULL,
    partExchange BOOL DEFAULT FALSE,
    report TEXT,
    price FLOAT NOT NULL,
    PRIMARY KEY(idMVmechanic, idMVvehicle),
    CONSTRAINT fk_mechanic_vehicle FOREIGN KEY (idMVmechanic) REFERENCES mechanic(CREA),
    CONSTRAINT fk_vehicle_mechanic FOREIGN KEY (idMVvehicle) REFERENCES vehicle(licensePlate)
);