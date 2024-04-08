BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE person';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE club';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE competition';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE participant';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/


CREATE TABLE person (
    id NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    prenom VARCHAR2(30),
    sexe VARCHAR2(30),
    email VARCHAR2(100),
    ville VARCHAR2(50),
    club_id NUMBER
);

CREATE TABLE club (
    id NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    email VARCHAR2(100),
    ville VARCHAR2(100)
);

CREATE TABLE competition (
    id NUMBER PRIMARY KEY,
    nom VARCHAR2(100),
    date_compete DATE,
    lieu VARCHAR2(100),
    ville VARCHAR2(100),
    prix NUMBER,
    club_id NUMBER
);

CREATE TABLE participant (
    club_id NUMBER,
    competition_id NUMBER
)