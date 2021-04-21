Ort (OrtId, OrtNamn)

Utbildning (UtbildningId, UtbildningsNamn)

Kurs (KursId, KursNamn) 

UtbildningKurs (UtbildningsId, KursId) 

Klass (KlassId, Start, Slut, OrtId, UtbildningId, AnstalldId) 

Anstalld (AnstId, Förnamn, EfterNamn, Adress, PostNummer) 

Studerande (StuderandeId, Förnamn, EfterNamn, Adress, PostNr, Ort, KlassId) 

Betyg (StuderandeId, KlassKursId, Betyg, Betygdatum) 

KlassKurs (KlasskursId, Start, Slut, KursId, KlassId, AnstalldId)

InAktivStuderande ( InAktivStuderandeId, FörNamn, EfterNamn,Address, PostNr, Ort) 

InAktivBetyg (KlasskursId, InAktivStuderandeId, KursBetyg) 
