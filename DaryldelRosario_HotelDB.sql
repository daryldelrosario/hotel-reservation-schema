DROP DATABASE IF EXISTS HotelReservation;
CREATE DATABASE HotelReservation;
USE HotelReservation;

CREATE TABLE Guest (
	GuestId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(25) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(25) NOT NULL,
    StateAbbr CHAR(2) NOT NULL,
    ZipCode CHAR(5) NOT NULL,
    PhoneNumber CHAR(15)
);

CREATE TABLE Amenity (
	AmenityId INT PRIMARY KEY AUTO_INCREMENT,
    AmenityName VARCHAR(25) NOT NULL,
    Price DECIMAL(5,2) NOT NULL
);

CREATE TABLE RoomType (
	RoomTypeId INT PRIMARY KEY AUTO_INCREMENT,
    RoomTypeName VARCHAR(10) NOT NULL,
    StdOccupancy INT NOT NULL,
    MaxOccupancy INT NOT NULL,
    BasePrice DECIMAL(6,2) NOT NULL,
    ExtraPersonPrice DECIMAL(5,2) NULL
);

CREATE TABLE Room (
	RoomId INT PRIMARY KEY,
    ADAAccessible BOOL NOT NULL,
    -- FOREIGN KEYS 
	RoomTypeId INT NOT NULL,
	CONSTRAINT fk_Room_RoomType
		FOREIGN KEY fk_Room_RoomType(RoomTypeId)
		REFERENCES RoomType(RoomTypeId)
);

CREATE TABLE Reservation (
	ReservationId INT PRIMARY KEY AUTO_INCREMENT,
    Adult INT NOT NULL,
    Children INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalRoomCost DECIMAL(7,2),
    -- FOREIGN KEYS
    RoomId INT NOT NULL,
    GuestId INT NOT NULL,
    CONSTRAINT fk_Reservation_Room
		FOREIGN KEY fk_Reservation_Room(RoomId)
        REFERENCES Room(RoomId),
	CONSTRAINT fk_Reservation_Guest
		FOREIGN KEY fk_Reservation_Guest(GuestId)
        REFERENCES Guest(GuestId)
);

CREATE TABLE RoomAmenity (
	RoomId INT NOT NULL,
    AmenityId INT NOT NULL,
    PRIMARY KEY pk_RoomAmenity(RoomId, AmenityId),
    CONSTRAINT fk_RoomAmenity_Room
		FOREIGN KEY fk_RoomAnemity_Room(RoomId)
        REFERENCES Room(RoomId),
	CONSTRAINT fk_RoomAmenity_Amenity
		FOREIGN KEY fk_RoomAmenity_Amenity(AmenityId)
        REFERENCES Amenity(AmenityId)
);
    