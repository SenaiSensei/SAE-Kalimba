/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de création :  28/11/2023 15:27:05                      */
/*==============================================================*/


alter table Cours
   drop constraint FK_COURS_APPARTENI_TYPE_COU;

alter table Cours
   drop constraint FK_COURS_ANIMER_PROFESSE;

alter table Cours
   drop constraint FK_COURS_DEDIER_A_TYPE_INS;

alter table Instrument
   drop constraint FK_INSTRUME_CORRESPON_TYPE_INS;

alter table Professeur
   drop constraint FK_PROFESSE_SPECIALIS_TYPE_INS;

alter table Type_Instrument
   drop constraint FK_TYPE_INS_FAIRE_PAR_CATEGORI;

alter table pratiquer
   drop constraint FK_PRATIQUE_PRATIQUER_TYPE_INS;

alter table pratiquer
   drop constraint FK_PRATIQUE_PRATIQUER_PROFESSE;

alter table tarifer
   drop constraint FK_TARIFER_TARIFER_TYPE_COU;

alter table tarifer
   drop constraint FK_TARIFER_TARIFER2_TRANCHE;

drop table Categorie cascade constraints;

drop index ANIMER_FK;

drop index APPARTENIR_FK;

drop index DEDIER_A_FK;

drop table Cours cascade constraints;

drop index CORRESPONDRE_FK;

drop table Instrument cascade constraints;

drop index SPECIALISER_FK;

drop table Professeur cascade constraints;

drop table Tranche cascade constraints;

drop table Type_Cours cascade constraints;

drop index FAIRE_PARTIE_FK;

drop table Type_Instrument cascade constraints;

drop index PRATIQUER2_FK;

drop index PRATIQUER_FK;

drop table pratiquer cascade constraints;

drop index TARIFER2_FK;

drop index TARIFER_FK;

drop table tarifer cascade constraints;

/*==============================================================*/
/* Table : Categorie                                            */
/*==============================================================*/
create table Categorie 
(
   idCat                INTEGER              not null,
   libCat               VARCHAR2(30),
   constraint PK_CATEGORIE primary key (idCat)
);

/*==============================================================*/
/* Table : Cours                                                */
/*==============================================================*/
create table Cours 
(
   idCours              INTEGER              not null,
   idProf               INTEGER,
   idTpInst             INTEGER,
   idTpCours            INTEGER              not null,
   libCours             VARCHAR2(30),
   nbPlaces             INTEGER              not null
      constraint CKC_NBPLACES_COURS check (nbPlaces between 5 and 20),
   ageMini              INTEGER,
   ageMaxi              INTEGER,
   constraint PK_COURS primary key (idCours)
);

/*==============================================================*/
/* Index : DEDIER_A_FK                                          */
/*==============================================================*/
create index DEDIER_A_FK on Cours (
   idTpInst ASC
);

/*==============================================================*/
/* Index : APPARTENIR_FK                                        */
/*==============================================================*/
create index APPARTENIR_FK on Cours (
   idTpCours ASC
);

/*==============================================================*/
/* Index : ANIMER_FK                                            */
/*==============================================================*/
create index ANIMER_FK on Cours (
   idProf ASC
);

/*==============================================================*/
/* Table : Instrument                                           */
/*==============================================================*/
create table Instrument 
(
   idInst               INTEGER              not null,
   idTpInst             INTEGER              not null,
   couleur              VARCHAR2(30),
   dateAchat            DATE,
   marque               VARCHAR2(30),
   modele               VARCHAR2(30),
   prixAchat            NUMBER(8,2)         
      constraint CKC_PRIXACHAT_INSTRUME check (prixAchat is null or (prixAchat >= 0)),
   constraint PK_INSTRUMENT primary key (idInst)
);

/*==============================================================*/
/* Index : CORRESPONDRE_FK                                      */
/*==============================================================*/
create index CORRESPONDRE_FK on Instrument (
   idTpInst ASC
);

/*==============================================================*/
/* Table : Professeur                                           */
/*==============================================================*/
create table Professeur 
(
   idProf               INTEGER              not null,
   idTpInst             INTEGER,
   nomprof              VARCHAR2(30),
   pnomprof             VARCHAR2(30),
   emailprof            VARCHAR2(30),
   telprof              CHAR(10),
   statut               INTEGER             
      constraint CKC_STATUT_PROFESSE check (statut is null or (statut between 1 and 3)),
   datenais             DATE,
   dateEmb              DATE,
   dateDpt              DATE,
   constraint PK_PROFESSEUR primary key (idProf)
);

/*==============================================================*/
/* Index : SPECIALISER_FK                                       */
/*==============================================================*/
create index SPECIALISER_FK on Professeur (
   idTpInst ASC
);

/*==============================================================*/
/* Table : Tranche                                              */
/*==============================================================*/
create table Tranche 
(
   idTranche            CHAR(1)              not null,
   quotiebtMin          INTEGER,
   constraint PK_TRANCHE primary key (idTranche)
);

/*==============================================================*/
/* Table : Type_Cours                                           */
/*==============================================================*/
create table Type_Cours 
(
   idTpCours            INTEGER              not null,
   libTpCours           VARCHAR2(30),
   constraint PK_TYPE_COURS primary key (idTpCours)
);

/*==============================================================*/
/* Table : Type_Instrument                                      */
/*==============================================================*/
create table Type_Instrument 
(
   idTpInst             INTEGER              not null,
   idCat                INTEGER              not null,
   libTpInst            VARCHAR2(30),
   constraint PK_TYPE_INSTRUMENT primary key (idTpInst)
);

/*==============================================================*/
/* Index : FAIRE_PARTIE_FK                                      */
/*==============================================================*/
create index FAIRE_PARTIE_FK on Type_Instrument (
   idCat ASC
);

/*==============================================================*/
/* Table : pratiquer                                            */
/*==============================================================*/
create table pratiquer 
(
   idTpInst             INTEGER              not null,
   idProf               INTEGER              not null,
   constraint PK_PRATIQUER primary key (idTpInst, idProf)
);

/*==============================================================*/
/* Index : PRATIQUER_FK                                         */
/*==============================================================*/
create index PRATIQUER_FK on pratiquer (
   idTpInst ASC
);

/*==============================================================*/
/* Index : PRATIQUER2_FK                                        */
/*==============================================================*/
create index PRATIQUER2_FK on pratiquer (
   idProf ASC
);

/*==============================================================*/
/* Table : tarifer                                              */
/*==============================================================*/
create table tarifer 
(
   idTpCours            INTEGER              not null,
   idTranche            CHAR(1)              not null,
   montant              NUMBER(8,2)         
      constraint CKC_MONTANT_TARIFER check (montant is null or (montant >= 0)),
   constraint PK_TARIFER primary key (idTpCours, idTranche)
);

/*==============================================================*/
/* Index : TARIFER_FK                                           */
/*==============================================================*/
create index TARIFER_FK on tarifer (
   idTpCours ASC
);

/*==============================================================*/
/* Index : TARIFER2_FK                                          */
/*==============================================================*/
create index TARIFER2_FK on tarifer (
   idTranche ASC
);

alter table Cours
   add constraint FK_COURS_APPARTENI_TYPE_COU foreign key (idTpCours)
      references Type_Cours (idTpCours);

alter table Cours
   add constraint FK_COURS_ANIMER_PROFESSE foreign key (idProf)
      references Professeur (idProf);

alter table Cours
   add constraint FK_COURS_DEDIER_A_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Instrument
   add constraint FK_INSTRUME_CORRESPON_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Professeur
   add constraint FK_PROFESSE_SPECIALIS_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table Type_Instrument
   add constraint FK_TYPE_INS_FAIRE_PAR_CATEGORI foreign key (idCat)
      references Categorie (idCat);

alter table pratiquer
   add constraint FK_PRATIQUE_PRATIQUER_TYPE_INS foreign key (idTpInst)
      references Type_Instrument (idTpInst);

alter table pratiquer
   add constraint FK_PRATIQUE_PRATIQUER_PROFESSE foreign key (idProf)
      references Professeur (idProf);

alter table tarifer
   add constraint FK_TARIFER_TARIFER_TYPE_COU foreign key (idTpCours)
      references Type_Cours (idTpCours);

alter table tarifer
   add constraint FK_TARIFER_TARIFER2_TRANCHE foreign key (idTranche)
      references Tranche (idTranche);

