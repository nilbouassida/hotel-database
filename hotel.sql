ALTER TABLE Hotel RENAME COLUMN Column_5 TO Anz_Zimmer;

CREATE TABLE Ort(
	OrtID UUID not null primary key,
	Straße varchar Not Null,
	Hausnummer varchar Not Null,
	PLZ varchar (5) not null CHECK (PLZ ~ '^[0-9]{5}$'),
	Stadt varchar Not Null
);

ALTER TABLE MitarbeiterIn add column Gehalt UINTEGER;
UPDATE MitarbeiterIn
SET Gehalt = CASE 
    WHEN Abteilung = 'Sicherheit' THEN 2000
    WHEN Abteilung = 'Reinigung' THEN 2200
    WHEN Abteilung = 'Rezeption' THEN 2600
    WHEN Abteilung = 'Management' THEN 3200
    ELSE Gehalt 
END;

--ALTER TABLE Hotel ADD CONSTRAINT check_salary CHECK(Typ = 'Apart' AND Anz_Zimmer = 0 AND Anz_Apartments != 0); 
--ALTER TABLE MitarbeiterIn DROP Angestellt_am;
ALTER TABLE MitarbeiterIn ADD COLUMN angestellt DATE;
UPDATE MitarbeiterIn SET angestellt = STRPTIME(Angestellt_am, '%d-%m-%Y');
SELECT Angestellt_am, angestellt FROM MitarbeiterIn;
ALTER TABLE MitarbeiterIn DROP COLUMN Angestellt_am;
ALTER TABLE MitarbeiterIn RENAME COLUMN angestellt TO Angestellt_am;
ALTER TABLE MitarbeiterIn ALTER COLUMN Angestellt_am SET NOT NULL;


CREATE TABLE ManagerIn (
    PersID VARCHAR PRIMARY KEY CHECK (PersID ~ '^em3[0-9]{5}$') NOT NULL,
    Letzte_Fortbildung DATE,
    Nächste_Fortbildung DATE NOT NULL,
    Bonus DECIMAL(8,2) CHECK (Bonus >= 0 AND Bonus <= 1000000) NOT NULL,
    CHECK (Letzte_Fortbildung < Nächste_Fortbildung),
    FOREIGN KEY (PersID) REFERENCES MitarbeiterIn(PersID)
);


DELETE FROM MitarbeiterIn
WHERE Nachname = 'Traice';

INSERT INTO ManagerIn (PersID, Letzte_Fortbildung, Nächste_Fortbildung, Bonus)
VALUES ('em300003', '2023-10-21', '2024-06-12', 936.50),
    ('em300004', '2024-01-13', '2024-09-02', 0.00),
    ('em300011', '2023-11-14', '2024-06-12', 1500.00),
    ('em300013', '2024-01-13', '2024-09-02', 345.78),
    ('em300016', '2023-11-14', '2024-07-27', 0.00),
    ('em300021', '2024-01-13', '2024-07-27', 0.00);
    
INSERT INTO Ort(OrtID, Stadt, PLZ, Straße, Hausnummer)
VALUES
    ('a1b2c3d4-e5f6-4a78-af61-f8f0f5a76b29', 'Berlin', '10117', 'Albrechtstraße', '5'),
    ('b2c3d4e5-f6a7-4dc9-a6fc-9f1350d477d5', 'Berlin', '13353', 'Müllerstraße', '151a'),
    ('c3d4e5f6-a7b8-4d4e-9eeb-51d4aee9c12d', 'Berlin', '10439', 'Bjoernsonstraße', '10'),
    ('d4e5f6a7-b8c9-439e-9a91-8b3ac71a9055', 'München', '81829', 'Willy-Brandt-Platz', '3'),
    ('e5f6a7b8-c9d0-4d1c-aa88-7ac102c8ed29', 'München', '80636', 'Albrechtstraße', '13');
    
    
    
ALTER TABLE Hotel ADD COLUMN  OrtID UUID;

UPDATE Hotel SET OrtID = 'a1b2c3d4-e5f6-4a78-af61-f8f0f5a76b29' WHERE HotelID ='1001';
UPDATE Hotel SET OrtID = 'b2c3d4e5-f6a7-4dc9-a6fc-9f1350d477d5' WHERE HotelID ='1002';
UPDATE Hotel SET OrtID = 'b2c3d4e5-f6a7-4dc9-a6fc-9f1350d477d5' WHERE HotelID='1003';
UPDATE Hotel SET OrtID = 'c3d4e5f6-a7b8-4d4e-9eeb-51d4aee9c12d' WHERE HotelID ='1004';
UPDATE Hotel SET OrtID = 'd4e5f6a7-b8c9-439e-9a91-8b3ac71a9055' WHERE HotelID ='1005';
UPDATE Hotel SET OrtID = 'e5f6a7b8-c9d0-4d1c-aa88-7ac102c8ed29' WHERE HotelID ='1006';

ALTER TABLE Hotel DROP COLUMN Adresse;
