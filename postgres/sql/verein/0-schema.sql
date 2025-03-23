-- create user
CREATE ROLE vereinuser WITH LOGIN PASSWORD 'vereinuser';

-- create database
CREATE DATABASE verein OWNER vereinuser ENCODING 'UTF8';

-- use database verein
\c verein;

-- grant database and schema access
GRANT ALL PRIVILEGES ON DATABASE verein TO vereinuser;
GRANT ALL PRIVILEGES ON SCHEMA public TO vereinuser;
ALTER SCHEMA public OWNER TO vereinuser;

-- create tables
CREATE TABLE Funktion (
    FunkID     UUID NOT NULL,
    Bezeichner VARCHAR(100) NOT NULL,
    CONSTRAINT pk_Funktion_FunkID PRIMARY KEY (FunkID)
);

CREATE TABLE Status (
    StatID     UUID NOT NULL,
    Bezeichner VARCHAR(100) NOT NULL ,
    Beitrag    NUMERIC,
    CONSTRAINT pk_Status_StatID PRIMARY KEY (StatID),
    CONSTRAINT ck_Status_Beitrag CHECK (Beitrag IS NULL OR (Beitrag >= 0))
);

CREATE TABLE Person (
    PersID      UUID NOT NULL,
    Name        VARCHAR(50) NOT NULL,
    Vorname     VARCHAR(50) NOT NULL,
    Strasse_Nr  VARCHAR(50) NOT NULL,
    PLZ         CHAR(4) NOT NULL,
    Ort         VARCHAR(50) NOT NULL,
    bezahlt     CHAR(1) NOT NULL DEFAULT 'N',
    Bemerkungen VARCHAR(100) ,
    Eintritt    DATE,
    Austritt    DATE,
    StatID      UUID NOT NULL,
    MentorID    UUID,
    CONSTRAINT pk_Person_PersID PRIMARY KEY (PersID),
    CONSTRAINT fk_Person_MentorID FOREIGN KEY (MentorID) REFERENCES Person (PersID),
    CONSTRAINT fk_Person_StatID FOREIGN KEY (StatID) REFERENCES Status (StatID),
    CONSTRAINT ck_Person_bezahlt CHECK (bezahlt = 'N' OR bezahlt = 'J'),
    CONSTRAINT ck_Person_Austritt CHECK (Austritt IS NULL OR (Eintritt <= Austritt))
);

CREATE TABLE Funktionsbesetzung (
    Antritt    DATE NOT NULL,
    Ruecktritt DATE,
    FunkID     UUID NOT NULL,
    PersID     UUID NOT NULL,
    CONSTRAINT fk_Funktionsbesetzung_FunkID FOREIGN KEY (FunkID) REFERENCES Funktion (FunkID),
    CONSTRAINT fk_Funktionsbesetzung_PersID FOREIGN KEY (PersID) REFERENCES Person (PersID),
    CONSTRAINT ck_Funktionsbesetzung_Ruecktritt CHECK (Ruecktritt IS NULL OR (Antritt <= Ruecktritt))
);

CREATE TABLE Anlass (
    AnlaID     UUID NOT NULL,
    Bezeichner VARCHAR(100) NOT NULL,
    Ort        VARCHAR(50),
    Datum      DATE NOT NULL,
    Kosten     NUMERIC,
    OrgID      UUID NOT NULL,
    CONSTRAINT pk_Anlass_AnlaID PRIMARY KEY (AnlaID),
    CONSTRAINT ck_Anlass_Kosten CHECK (Kosten IS NULL OR (Kosten >= 0)),
    CONSTRAINT fk_Anlass_OrgID FOREIGN KEY (OrgID) REFERENCES Person (PersID)
);

CREATE TABLE Teilnehmer (
    PersID UUID NOT NULL,
    AnlaID UUID NOT NULL,
    CONSTRAINT fk_Teilnehmer_PersID FOREIGN KEY (PersID) REFERENCES Person (PersID),
    CONSTRAINT fk_Teilnehmer_AnlaID FOREIGN KEY (AnlaID) REFERENCES Anlass (AnlaID)
);

CREATE TABLE Sponsor (
    SponID       UUID NOT NULL,
    Name         VARCHAR(50) NOT NULL,
    Strasse_Nr   VARCHAR(50),
    PLZ          CHAR(4) NOT NULL,
    Ort          VARCHAR(50) NOT NULL,
    Spendentotal NUMERIC NOT NULL,
    CONSTRAINT pk_Sponsor_SponID PRIMARY KEY (SponID)
);

CREATE TABLE Spende (
    SpenID     UUID NOT NULL,
    Bezeichner VARCHAR(100),
    Datum      DATE DEFAULT CURRENT_DATE NOT NULL,
    Betrag     NUMERIC NOT NULL,
    SponID     UUID NOT NULL ,
    AnlaID     UUID,
    CONSTRAINT pk_Spende_SpenID PRIMARY KEY (SpenID),
    CONSTRAINT ck_Spende_Betrag CHECK (Betrag IS NULL OR (Betrag >= 0)),
    CONSTRAINT fk_Spende_SponID FOREIGN KEY (SponID) REFERENCES Sponsor (SponID),
    CONSTRAINT fk_Spende_AnlaID FOREIGN KEY (AnlaID) REFERENCES Anlass (AnlaID)
);

CREATE TABLE Sponsorenkontakt (
    PersID UUID NOT NULL,
    SponID UUID NOT NULL,
    CONSTRAINT fk_Sponsorenkontakt_PersID FOREIGN KEY (PersID) REFERENCES Person (PersID),
    CONSTRAINT fk_Sponsorenkontakt_SponID FOREIGN KEY (SponID) REFERENCES Sponsor (SponID)
);

-- change owner
ALTER TABLE Funktion           OWNER TO vereinuser;
ALTER TABLE Status             OWNER TO vereinuser;
ALTER TABLE Person             OWNER TO vereinuser;
ALTER TABLE Funktionsbesetzung OWNER TO vereinuser;
ALTER TABLE Anlass             OWNER TO vereinuser;
ALTER TABLE Teilnehmer         OWNER TO vereinuser;
ALTER TABLE Sponsor            OWNER TO vereinuser;
ALTER TABLE Spende             OWNER TO vereinuser;
ALTER TABLE Sponsorenkontakt   OWNER TO vereinuser;