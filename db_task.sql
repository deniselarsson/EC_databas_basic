------------------------------Procedure---------------------------------------------
CREATE PROCEDURE inaktiveraStudent(@studerandeId INT)
AS
BEGIN
    INSERT INTO InaktivStuderande (Id, KlassId, Fornamn, Efternamn, Adress, PostNr, Ort)
    SELECT Id, KlassId, Fornamn, Efternamn, Adress, PostNr, Ort
    FROM Studerande
    WHERE Id = @studerandeId;

    INSERT INTO InAktivBetyg (KlassKursId, InaktivStuderandeId, KursBetyg, Datum)
    SELECT KlassKursId, StuderandeId, Betyg, Datum
    FROM Betyg
    WHERE StuderandeId = @studerandeId;

    DELETE FROM Betyg WHERE StuderandeId = @studerandeId;
    DELETE FROM Studerande WHERE Id = @studerandeId; 
END

-- EXEC inaktiveraStudent 700;

CREATE PROCEDURE betygsutdrag(@studerandeId INT)
AS
BEGIN
    SELECT
        Kurs.Namn AS Kurs,
        InAktivBetyg.KursBetyg AS Betyg,
        InAktivBetyg.Datum AS BetygsDatum,
        Anstalld.Fornamn AS LarareFornamn,
        Anstalld.Efternamn AS LarareEfternamn
    FROM InAktivBetyg
    INNER JOIN KlassKurs ON KlassKurs.Id = InAktivBetyg.KlassKursId
    INNER JOIN Kurs ON Kurs.Id = KlassKurs.KursId
    INNER JOIN Anstalld ON Anstalld.Id = KlassKurs.LarareId
    WHERE InaktivStuderandeId = @studerandeId
END

-- EXEC betygsutdrag 700;

---------------------------VIEW----------------------------------------------
CREATE VIEW LarareId_KursId_Start_Slut_Betyg_STuderande AS 
SELECT DISTINCT LarareId,KursId, Start, slut, Betyg, Studerande.Fornamn, Studerande.Efternamn 
FROM Anstalld
INNER JOIN KlassKurs ON Anstalld.Id = KlassKurs.LarareId
INNER JOIN Betyg ON KlassKurs.Id = Betyg.KlassKursId
INNER JOIN Studerande ON Betyg.StuderandeId = Studerande.Id
GROUP BY LarareId, KursId, Start, Slut, Betyg, Studerande.Fornamn , Studerande.Efternamn 

SELECT * FROM LarareId_KursId_Start_Slut_Betyg_STuderande

-------------------------------JOIN,GROUP,BY,HAVING m.m:---------------------------------------------------

SELECT DISTINCT Utbildning.Namn AS Utbilning, 
Kurs.Namn AS KursNamn, Betyg.Betyg AS Betyg, COUNT (*) AS AntalStuderande

FROM Utbildning 
INNER JOIN UtbildningKurs ON Utbildning.Id = UtbildningKurs.UtbildningId 
INNER JOIN Kurs ON UtbildningKurs.KursId= Kurs.Id 
INNER JOIN KlassKurs ON Kurs.Id = KlassKurs.KursId
INNER JOIN Betyg ON KlassKurs.Id = Betyg.KlassKursId

--WHERE Utbildning.Namn = 'Javautvecklare' AND Betyg.Betyg = 'G'
GROUP BY Utbildning.Namn, Kurs.Namn, Betyg.Betyg
HAVING COUNT(*) > 0
ORDER BY COUNT(*) DESC

------------------------------Trigger-------------------------------------
CREATE TRIGGER betygs_datum
ON Betyg
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Betyg
    SET Datum = GETDATE()
    FROM INSERTED
    WHERE Betyg.KlassKursId = INSERTED.KlassKursId
    AND Betyg.StuderandeId = INSERTED.StuderandeId;
END;
-------------------------CHECK--------------------------------------------
ALTER TABLE Anstalld 
ADD CONSTRAINT Check_Anstalld_Id
CHECK (Id BETWEEN 1 and 10000)
