-- create data

-- use database verein
\c verein;

--
-- Funktionen
--
INSERT INTO funktion (funkid, bezeichner) 
    VALUES ('662554fe-0b60-4b16-aa23-00d20529b330', 'Praesidium');      
INSERT INTO funktion (funkid, bezeichner)
    VALUES ('e5edc6e2-1cb3-4a71-b081-0234596ac97c', 'Vizepraesidium');
INSERT INTO funktion (funkid, bezeichner)
    VALUES ('b1b86514-ce70-4604-bf24-96d0cdb4708d', 'Kasse');
INSERT INTO funktion (funkid, bezeichner)
    VALUES ('6d04ea95-1178-4597-bf5f-f037cfe2cc63', 'Beisitz');
INSERT INTO funktion (funkid, bezeichner)
    VALUES ('17372860-6248-4a93-9f1c-5c041a18ea70', 'PR');

--
-- Sponsoren
--
INSERT INTO sponsor (sponid, name, strasse_nr, plz, ort, spendentotal)
    VALUES ('3c36866d-0e65-42e2-847a-18a64582dd24', 'erhardt consulting GmbH', NULL, '4500', 'Solothurn', 10000);
INSERT INTO sponsor (sponid, name, strasse_nr, plz, ort, spendentotal)
    VALUES ('a08238f5-5334-4cb8-a098-e3cfd8ee6c12', 'Hasler AG', 'Zelgweg 9', '2540', 'Grenchen', 1270);
INSERT INTO sponsor (sponid, name, strasse_nr, plz, ort, spendentotal)
    VALUES ('8c19a37e-982a-427c-99b1-5bf0ee75345a', 'Pauker Druck', 'Solothurnstr. 19', '2544', 'Bettlach', 2750);
INSERT INTO sponsor (sponid, name, strasse_nr, plz, ort, spendentotal)
    VALUES ('3549b994-9993-4ab7-8cc5-a44549c98c8d', 'Meyer Toni', 'Rothstr. 22', '4500', 'Solothurn',750);

--
-- Status
--
INSERT INTO status (statid, bezeichner, beitrag)
    VALUES ('d5664bc8-6e21-4e51-a6ec-5706ca774e12', 'Junior', 0);
INSERT INTO status (statid, bezeichner, beitrag)
    VALUES ('b7eda575-2fa1-4af7-b962-c2f2e23d45e0', 'Aktiv', 50);
INSERT INTO status (statid, bezeichner, beitrag)
    VALUES ('21427c2d-df74-4a04-ab4a-4b79b3a283c2', 'Ehemalig', null);    
INSERT INTO status (statid, bezeichner, beitrag)
    VALUES ('bd457bea-eb1f-4ce9-bc6f-7852cec4a4bd', 'Passiv', 30);
INSERT INTO status (statid, bezeichner, beitrag)
    VALUES ('131e03ef-a07a-4c8e-880e-767a1e8c874e', 'Helfer', null);
INSERT INTO status (statid, bezeichner, beitrag)
    VALUES ('bd41323f-0fa6-4d0f-9a4b-5aa8057de900', 'Extern', null);

--
-- Person
--
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('17a3e8a0-f9d1-438a-a894-ebb80642de7c', '21427c2d-df74-4a04-ab4a-4b79b3a283c2', 'Niiranen', 'Ulla', 'Nordstr. 113', '2500', 
        'Biel', 'J', NULL, TO_DATE('11-11-2007','DD-MM-YYYY'),
        TO_DATE('31-03-2011','DD-MM-YYYY'), NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('f60e05c6-c297-426f-b359-aedefeff8eaf', '21427c2d-df74-4a04-ab4a-4b79b3a283c2', 'Wendel', 'Otto', 'Sigriststr. 9', '4500',
        'Solothurn', 'J', NULL, TO_DATE('01-01-2011','DD-MM-YYYY'),
        TO_DATE('30-11-2014','DD-MM-YYYY'), NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0', 'Meyer', 'Dominik', 'Rainstr. 13', '4528',
        'Zuchwil', 'J', NULL, TO_DATE('01-01-2011','DD-MM-YYYY'),
        NULL, NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0', 'Meyer', 'Petra', 'Rainstr. 13', '4528',
        'Zuchwil', 'J', NULL, TO_DATE('15-02-2009','DD-MM-YYYY'),
        NULL, NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('f6acd528-ba99-42f0-8c83-404e2e5fb66d', 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0', 'Tamburino', 'Mario', 'Solothurnstr. 96', '2540',
        'Grenchen', 'N', NULL, TO_DATE('30-09-2014','DD-MM-YYYY'),
        NULL, '5b55db50-bfee-487e-a10e-be4dd019b4b0');
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('9094e018-ee32-4898-8d07-88e2e45acfeb', 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0', 'Bregger', 'Beni', 'Sportstr. 2', '2540',
        'Grenchen', 'J', NULL, TO_DATE('21-05-2012','DD-MM-YYYY'),
        NULL, '5b55db50-bfee-487e-a10e-be4dd019b4b0');
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('47e92117-eaf3-4360-b032-7ad573b1c1c3', '131e03ef-a07a-4c8e-880e-767a1e8c874e', 'Luder', 'Kevin', 'Forstweg 14', '2545',
        'Zuchwil', 'J', 'Klaushock', NULL, NULL, NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('79463e20-8898-4e01-a1e7-7f87b9de9aa3', 'bd41323f-0fa6-4d0f-9a4b-5aa8057de900', 'Frei', 'Barbara', 'Gartenstr.1', '2540',
        'Grenchen', 'J', NULL, NULL, NULL, NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('ff0be24f-7db8-48e3-97e3-7770ceab5b5e', 'bd41323f-0fa6-4d0f-9a4b-5aa8057de900', 'Huber', 'Felix', 'Eichmatt 7', '2545',
        'Selzach', 'J', NULL, NULL, NULL, NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('112f2f95-6607-4e48-9bca-efa6cd898ef4', 'd5664bc8-6e21-4e51-a6ec-5706ca774e12', 'Cadola', 'Leo', 'Sportstr. 2', '4500',
        'Solothurn', 'J', NULL, TO_DATE('01-10-2013','DD-MM-YYYY'),
        NULL, NULL);
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('5b3d101a-96eb-4827-89e9-de01b80acb8d', 'd5664bc8-6e21-4e51-a6ec-5706ca774e12', 'Bart', 'Sabine', 'Bernstr. 15', '2540',
        'Grenchen', 'J', NULL, TO_DATE('12-07-2014','DD-MM-YYYY'),
        NULL, '112f2f95-6607-4e48-9bca-efa6cd898ef4');
INSERT INTO person 
       (persid, statid, name, vorname, strasse_nr, plz, ort,
        bezahlt, bemerkungen, eintritt, austritt, mentorid)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', 'b7eda575-2fa1-4af7-b962-c2f2e23d45e0', 'Gruber', 'Romy', 'Gladbächli 3', '2545',
        'Selzach', 'N', NULL, TO_DATE('29-11-2009','DD-MM-YYYY'),
        NULL, NULL);

--
-- Anlass
--
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('e6a6dd40-649c-428f-852b-bf9f9d452e26', 'GV', 'Solothurn', 
        TO_DATE('31-03-2013','DD-MM-YYYY'), 200, 'f60e05c6-c297-426f-b359-aedefeff8eaf');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('3af5bcb9-e2b7-4690-8358-0a16a243719b', 'Vorstandssitzung', 'Grenchen',
        TO_DATE('17-01-2014','DD-MM-YYYY'), NULL, '872fde0a-1934-4451-8a46-91176241337f');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('2aa76ccf-7834-4b33-a65e-d86e8718ee4a', 'GV', 'Bettlach',
        TO_DATE('30-03-2013','DD-MM-YYYY'), 200, '9094e018-ee32-4898-8d07-88e2e45acfeb');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('bd5ba6e6-2978-400c-b3d8-31b6a543e0eb', 'Klaushock', 'Bettlach',
        TO_DATE('06-12-2014','DD-MM-YYYY'), 150, '47e92117-eaf3-4360-b032-7ad573b1c1c3');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('4c664972-da01-45f6-b015-8daed55078a6', 'Vorstandssitzung', 'Grenchen',
        TO_DATE('21-01-2015','DD-MM-YYYY'), NULL, '872fde0a-1934-4451-8a46-91176241337f');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('0082a407-08e1-4c56-bad8-21d4c64e9b73', 'Turnier', 'Biel',
        TO_DATE('28-02-2014','DD-MM-YYYY'), 1020, '112f2f95-6607-4e48-9bca-efa6cd898ef4');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('c154a80d-a66e-41ee-a628-2246c38e53eb', 'GV', 'Grenchenberg',
        TO_DATE('29-03-2015','DD-MM-YYYY'), 250, '5b55db50-bfee-487e-a10e-be4dd019b4b0');
INSERT INTO anlass 
       (anlaid, bezeichner, ort, datum, kosten, orgid)
VALUES ('943bd7a1-e411-4f6e-aded-0da467aa9217', 'Vorstandssitzung', 'Grenchen',
        TO_DATE('19-01-2015','DD-MM-YYYY'), NULL, '9094e018-ee32-4898-8d07-88e2e45acfeb');

--
-- Spende
--
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('3c36866d-0e65-42e2-847a-18a64582dd24', 'ef82aa92-e43a-47ac-9d36-4e31da4ee0b3', 'e6a6dd40-649c-428f-852b-bf9f9d452e26', 'Unterstützung', 
        TO_DATE('31-03-2013','DD-MM-YYYY'), 10000);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('a08238f5-5334-4cb8-a098-e3cfd8ee6c12', '8f06a68b-4e22-4805-977c-be1cffa9b2d5', '0082a407-08e1-4c56-bad8-21d4c64e9b73', 'Apéro', 
        TO_DATE('02-02-2015','DD-MM-YYYY'), 720);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('a08238f5-5334-4cb8-a098-e3cfd8ee6c12', '13e05d28-fbf0-447b-a27a-534d9587745c', NULL, 'Defizittilgung',
        TO_DATE('13-04-2015','DD-MM-YYYY'), 550);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('8c19a37e-982a-427c-99b1-5bf0ee75345a', '78ec7d82-948c-4b31-8fc1-7c0af06bdb54', 'c154a80d-a66e-41ee-a628-2246c38e53eb', 'Getränke',
        TO_DATE('05-03-2015','DD-MM-YYYY'), 600);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('8c19a37e-982a-427c-99b1-5bf0ee75345a', 'e2464c58-822b-4fdf-984d-59172faad986', '0082a407-08e1-4c56-bad8-21d4c64e9b73', 'Plakate',
        TO_DATE('11-03-2015','DD-MM-YYYY'), 300);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('8c19a37e-982a-427c-99b1-5bf0ee75345a', '2bad55bb-064e-48cf-82ed-cd6eedb9ccfc', NULL, 'Defizittilgung',
        TO_DATE('13-04-2015','DD-MM-YYYY'), 750);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('3549b994-9993-4ab7-8cc5-a44549c98c8d', '5818bb5b-1de9-43a3-bafa-2003393abcbd', 'bd5ba6e6-2978-400c-b3d8-31b6a543e0eb', 'Glühwein',
        TO_DATE('29-11-2014','DD-MM-YYYY'), 200);
INSERT INTO spende
       (sponid, spenid, anlaid, bezeichner, datum, betrag)
VALUES ('3549b994-9993-4ab7-8cc5-a44549c98c8d', '9478224d-5b13-4b55-9f41-1b3c992233c5', 'c154a80d-a66e-41ee-a628-2246c38e53eb', 'Unterhaltungsmusik',
        TO_DATE('23-02-2015','DD-MM-YYYY'), 550);

--
-- Teilnehmer
--

INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', 'e6a6dd40-649c-428f-852b-bf9f9d452e26');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', 'e6a6dd40-649c-428f-852b-bf9f9d452e26');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('9094e018-ee32-4898-8d07-88e2e45acfeb', 'e6a6dd40-649c-428f-852b-bf9f9d452e26');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', 'e6a6dd40-649c-428f-852b-bf9f9d452e26');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('f60e05c6-c297-426f-b359-aedefeff8eaf', '3af5bcb9-e2b7-4690-8358-0a16a243719b');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', '3af5bcb9-e2b7-4690-8358-0a16a243719b');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '3af5bcb9-e2b7-4690-8358-0a16a243719b');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('f60e05c6-c297-426f-b359-aedefeff8eaf', '2aa76ccf-7834-4b33-a65e-d86e8718ee4a');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '2aa76ccf-7834-4b33-a65e-d86e8718ee4a');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('9094e018-ee32-4898-8d07-88e2e45acfeb', '2aa76ccf-7834-4b33-a65e-d86e8718ee4a');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', '2aa76ccf-7834-4b33-a65e-d86e8718ee4a');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', '4c664972-da01-45f6-b015-8daed55078a6');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', '4c664972-da01-45f6-b015-8daed55078a6');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('f60e05c6-c297-426f-b359-aedefeff8eaf', 'c154a80d-a66e-41ee-a628-2246c38e53eb');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', 'c154a80d-a66e-41ee-a628-2246c38e53eb');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('9094e018-ee32-4898-8d07-88e2e45acfeb', 'c154a80d-a66e-41ee-a628-2246c38e53eb');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '943bd7a1-e411-4f6e-aded-0da467aa9217');
INSERT INTO teilnehmer
       (persid, anlaid)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', '943bd7a1-e411-4f6e-aded-0da467aa9217');

--
-- Sponsorenkontakt
--
INSERT INTO sponsorenkontakt
       (persid, sponid)
VALUES ('79463e20-8898-4e01-a1e7-7f87b9de9aa3', 'a08238f5-5334-4cb8-a098-e3cfd8ee6c12');
INSERT INTO sponsorenkontakt
       (persid, sponid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '8c19a37e-982a-427c-99b1-5bf0ee75345a');
INSERT INTO sponsorenkontakt
       (persid, sponid)
VALUES ('ff0be24f-7db8-48e3-97e3-7770ceab5b5e', '8c19a37e-982a-427c-99b1-5bf0ee75345a');
INSERT INTO sponsorenkontakt
       (persid, sponid)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', '3549b994-9993-4ab7-8cc5-a44549c98c8d');
INSERT INTO sponsorenkontakt
       (persid, sponid)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '3549b994-9993-4ab7-8cc5-a44549c98c8d');

--
-- Funktionsbesetzung
--
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('17a3e8a0-f9d1-438a-a894-ebb80642de7c', '662554fe-0b60-4b16-aa23-00d20529b330', TO_DATE('11-11-2007','DD-MM-YYYY'),
        TO_DATE('31-03-2010','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', 'e5edc6e2-1cb3-4a71-b081-0234596ac97c', TO_DATE('01-04-2009','DD-MM-YYYY'),
        TO_DATE('31-03-2011','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', '662554fe-0b60-4b16-aa23-00d20529b330', TO_DATE('01-04-2010','DD-MM-YYYY'),
        TO_DATE('31-03-2011','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '662554fe-0b60-4b16-aa23-00d20529b330', TO_DATE('01-04-2011','DD-MM-YYYY'),
        TO_DATE('31-03-2013','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', 'e5edc6e2-1cb3-4a71-b081-0234596ac97c', TO_DATE('01-04-2011','DD-MM-YYYY'),
        TO_DATE('31-03-2012','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('f60e05c6-c297-426f-b359-aedefeff8eaf', 'b1b86514-ce70-4604-bf24-96d0cdb4708d', TO_DATE('01-04-2011','DD-MM-YYYY'),
        TO_DATE('31-03-2013','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', 'e5edc6e2-1cb3-4a71-b081-0234596ac97c', TO_DATE('01-04-2012','DD-MM-YYYY'),
        TO_DATE('31-03-2013','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('872fde0a-1934-4451-8a46-91176241337f', '662554fe-0b60-4b16-aa23-00d20529b330', TO_DATE('01-04-2012','DD-MM-YYYY'), NULL);
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('9094e018-ee32-4898-8d07-88e2e45acfeb', 'b1b86514-ce70-4604-bf24-96d0cdb4708d', TO_DATE('01-04-2013','DD-MM-YYYY'),
        TO_DATE('31-03-2014','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', '6d04ea95-1178-4597-bf5f-f037cfe2cc63', TO_DATE('01-04-2013','DD-MM-YYYY'),
        TO_DATE('31-03-2015','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '17372860-6248-4a93-9f1c-5c041a18ea70', TO_DATE('01-04-2013','DD-MM-YYYY'),
        TO_DATE('31-03-2014','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('9094e018-ee32-4898-8d07-88e2e45acfeb', 'e5edc6e2-1cb3-4a71-b081-0234596ac97c', TO_DATE('01-04-2014','DD-MM-YYYY'),
        TO_DATE('30-04-2029','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('5b55db50-bfee-487e-a10e-be4dd019b4b0', '6d04ea95-1178-4597-bf5f-f037cfe2cc63', TO_DATE('01-04-2014','DD-MM-YYYY'), NULL);
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('f60e05c6-c297-426f-b359-aedefeff8eaf', '17372860-6248-4a93-9f1c-5c041a18ea70', TO_DATE('01-04-2014','DD-MM-YYYY'),
        TO_DATE('30-11-2028','DD-MM-YYYY'));
INSERT INTO funktionsbesetzung 
       (persid, funkid, antritt, ruecktritt)
VALUES ('7fe1e547-12fc-4b7e-921d-6a0749aa18d1', 'b1b86514-ce70-4604-bf24-96d0cdb4708d', TO_DATE('01-08-2014','DD-MM-YYYY'), NULL);