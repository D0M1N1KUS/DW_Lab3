USE vod;

CREATE TABLE Daty(
	ID_Daty int identity(1,1) PRIMARY KEY not null,
	Rok int,
	Miesiac int,
	Dzien int,
	DzienPrzedSwietem varchar(4),
	CONSTRAINT CHK_Dzien CHECK (Dzien >= 1 AND Dzien <= 31),
	CONSTRAINT CHK_Miesiac CHECK (Miesiac >= 1 AND Miesiac <= 12),
	CONSTRAINT CHK_Rok CHECK (Rok >= 0 AND Rok <= 9999)
);

CREATE TABLE Lokalizacja(
	ID_Lokalizacji int identity(1,1) PRIMARY KEY not null,
	Panstwo varchar(143),
	Wojewodztwo varchar(143),
	Miasto varchar(143)
);

CREATE TABLE Serwer(
	ID_Serwera int identity(1,1) PRIMARY KEY not null,
	Nazwa varchar(1024)
);

CREATE TABLE Media(
	ID_Medium int identity(1,1) PRIMARY KEY not null,
	Tytul varchar(1000),
	Gatunek varchar(1000),
	RokProdukcji int
);

CREATE TABLE Czas(
	ID_Czasu int identity(1,1) PRIMARY KEY not null,
	PoraDnia varchar(21),
	Godzina time,
	CONSTRAINT CHK_Godzina CHECK (
		datepart(minute, Godzina) = datepart(minute, '00:00:00') AND
		datepart(second, Godzina) = datepart(second, '00:00:00')	
	),
	CONSTRAINT CHK_PoraDnia CHECK (
		PoraDnia = 'Rano' OR
		PoraDnia = 'Przed poludniem' OR
		PoraDnia = 'Po poludniu' OR
		PoraDnia = 'Wieczor' OR
		PoraDnia = 'Noc'
	)
);

CREATE TABLE ObejrzenieFilmuOdcinka(
	ID_Medium int,
	ID_Serwera int,
	ID_LokalizacjiKlienta int,
	ID_Daty int,
	ID_Czasu int,
	Login varchar(1000),
	Jakosc int,
	CONSTRAINT CHK_Jakosc CHECK (Jakosc >= -1 AND Jakosc <= 1),
	FOREIGN KEY (ID_Medium) REFERENCES Media(ID_Medium),
	FOREIGN KEY (ID_Serwera) REFERENCES Serwer(ID_Serwera),
	FOREIGN KEY (ID_LokalizacjiKlienta) REFERENCES Lokalizacja(ID_Lokalizacji),
	FOREIGN KEY (ID_Daty) REFERENCES Daty(ID_Daty),
	FOREIGN KEY (ID_Czasu) REFERENCES Czas(ID_Czasu),
	PRIMARY KEY (ID_Medium, ID_Serwera, ID_LokalizacjiKlienta, ID_Daty, ID_Czasu)
);
