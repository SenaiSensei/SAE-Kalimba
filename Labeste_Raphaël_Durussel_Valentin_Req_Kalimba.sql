SPOOL Labeste_Raphaël_Durussel_Valentin_Req_Kalimba


Select NOMPROF|| ' ' ||PNOMPROF as "Professeur", DECODE(STATUT, '1', 'titulaire', '2', 'vacataire', '3', 'stagiaire') as Statut, DATEEMB as "Annee Embauche"
From PROFESSEUR
WHERE ((NOMPROF|| ' ' ||PNOMPROF) LIKE '_E%') AND (DATEEMB BETWEEN '1/1/2000' AND '1/12/2010' OR DATEEMB IS NULL)
ORDER BY 'Professeur';


SELECT UPPER(LIBCOURS) as Cours, AGEMINI as "Age mini", NVL(AGEMAXI,99) as "Age Maxi", NBPLACES as "Nb Places"
FROM COURS
WHERE ((UPPER(LIBCOURS) LIKE '%MUSICAL%' OR UPPER(LIBCOURS) LIKE '%CHORALE%') AND ('Nb Places'>='15')) OR (UPPER(LIBCOURS) LIKE '%ORCHESTRE%') AND ('Age Maxi' IS NOT NULL);


SELECT IDCAT as "Catégorie", LIBTPINST as "Type Instrument"
FROM TYPE_INSTRUMENT ti INNER JOIN COURS c ON (ti.idtpinst = c.idtpinst)
WHERE c.IDTPINST != 0;


SELECT NOMPROF|| ' ' ||PNOMPROF as "Professeur", NVL(LIBTPINST,'Aucun') as "Type Instrument Principal"
FROM  TYPE_INSTRUMENT ti RIGHT JOIN PROFESSEUR p ON (ti.idtpinst = p.idtpinst)
WHERE STATUT = '2'
ORDER BY 1;


SELECT LIBCOURS as "Cours", NOMPROF|| ' ' ||PNOMPROF as "Professeur", NBPLACES as "Nb Places"
FROM COURS c 
    INNER JOIN PROFESSEUR p ON (c.idprof = p.idprof)
    INNER JOIN TYPE_COURS tc ON (c.idtpcours = tc.idtpcours)
    INNER JOIN TYPE_INSTRUMENT ti ON (c.idtpinst = ti.idtpinst)
    INNER JOIN CATEGORIE ca ON (ti.idcat = ca.idcat)
WHERE tc.IDTPCOURS = '1' AND LIBCAT LIKE 'Cordes';


SELECT ti.LIBTPINST as "Type Instrument"
FROM TYPE_INSTRUMENT ti
JOIN TYPE_INSTRUMENT ti1
ON (ti.idtpinst = ti1.idtpinst)
WHERE ti.LIBTPINST = ti1.LIBTPINST AND ti1.IDCAT = '2';


SELECT LIBCOURS as "Cours",  NOMPROF|| ' ' ||PNOMPROF as "Professeur", UPPER(LIBTPINST) as "Type Instrument"
FROM COURS c 
RIGHT JOIN PROFESSEUR p ON (c.idprof = p.idprof)
RIGHT JOIN TYPE_INSTRUMENT ti ON (p.idtpinst = ti.idtpinst)
WHERE UPPER(LIBTPINST) LIKE '%FLUTE%'
ORDER BY  1;


SELECT LIBTPINST as "Type Instrument", UPPER(LIBCAT) as "Catégorie", LIBCOURS as "Cours"
FROM COURS co 
RIGHT JOIN TYPE_INSTRUMENT ti ON (co.idtpinst = ti.idtpinst)
RIGHT JOIN CATEGORIE ca ON (ti.idcat = ca.idcat)
WHERE UPPER(LIBCAT) LIKE 'C%' OR LIBTPINST IS NULL
ORDER BY 2,1;



SELECT  p.NOMPROF|| ' ' ||p.PNOMPROF as "Professeur", ROUND(MONTHS_BETWEEN(SYSDATE,p.DATENAIS)/12) as "Âge" , TO_CHAR(p.DATEEMB, 'Mon YYYY') as "Embauche", NVL(p1.NOMPROF|| ' ' ||p1.PNOMPROF, 'Pas de superviseur') as "Superviseur"
FROM PROFESSEUR p
INNER JOIN PROFESSEUR p1 ON (p1.IDPROF = p.IDSPV)
WHERE p.STATUT != 3 AND p.DATEEMB > '01/01/2011';

SPOOL OFF