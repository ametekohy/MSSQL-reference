/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     23-12-2015		                            */
/* DDL SCRIPT MuziekdatabaseUitgebreid							*/
/*==============================================================*/
Create database MuziekdatabaseUitgebreid
go
use MuziekdatabaseUitgebreid
go


/*==============================================================*/
/* Table: Bezettingsregel                                       */
/*==============================================================*/
create table Bezettingsregel (
                                 stuknr               numeric(5)           not null,
                                 instrumentnaam       varchar(14)          not null,
                                 toonhoogte           varchar(7)           not null,
                                 aantal               numeric(2)           not null
)
go

alter table Bezettingsregel
    add constraint PK_BEZETTINGSREGEL primary key (stuknr, instrumentnaam, toonhoogte)
go

/*==============================================================*/
/* Table: Componist                                             */
/*==============================================================*/
create table Componist (
                           componistId          numeric(4)           not null,
                           naam                 varchar(20)          not null,
                           geboortedatum        datetime             null,
                           schoolId             numeric(2)           null
)
go

alter table Componist
    add constraint AK_COMPONIST unique (naam)
go

alter table Componist
    add constraint PK_COMPONIST primary key (componistId)
go

/*==============================================================*/
/* Table: Genre                                                 */
/*==============================================================*/
create table Genre (
    genrenaam            varchar(10)          not null
)
go

alter table Genre
    add constraint PK_GENRE primary key (genrenaam)
go

/*==============================================================*/
/* Table: Instrument                                            */
/*==============================================================*/
create table Instrument (
                            instrumentnaam       varchar(14)          not null,
                            toonhoogte           varchar(7)           not null
)
go

alter table Instrument
    add constraint PK_INSTRUMENT primary key (instrumentnaam, toonhoogte)
go

/*==============================================================*/
/* Table: Muziekschool                                          */
/*==============================================================*/
create table Muziekschool (
                              schoolId             numeric(2)           not null,
                              naam                 varchar(30)          not null,
                              plaatsnaam           varchar(20)          not null
)
go

alter table Muziekschool
    add constraint AK_MUZIEKSCHOOL unique (naam)
go

alter table Muziekschool
    add constraint PK_MUZIEKSCHOOL primary key (schoolId)
go

/*==============================================================*/
/* Table: Niveau                                                */
/*==============================================================*/
create table Niveau (
                        niveaucode           char(1)              not null,
                        omschrijving         varchar(15)          not null
)
go

alter table Niveau
    add constraint AK_NIVEAU unique (omschrijving)
go

alter table Niveau
    add constraint PK_NIVEAU primary key (niveaucode)
go

/*==============================================================*/
/* Table: Student                                               */
/*==============================================================*/
create table Student (
                         studentId            numeric(10)          not null,
                         schoolId             numeric(2)           not null,
                         voornaam             varchar(25)          not null,
                         achternaam           varchar(25)          not null,
                         inschrijfdatum		date				 not null,
                         uitschrijfdatum		date				 null
)
go

alter table Student
    add constraint PK_STUDENT primary key (studentId)
go


/*==============================================================*/
/* Table: StudentInstrument                                     */
/*==============================================================*/
create table StudentInstrument (
                                   instrumentnaam       varchar(14)          not null,
                                   toonhoogte           varchar(7)           not null,
                                   studentId            numeric(10)           not null,
                                   niveaucode           char(1)              not null
)
go

alter table StudentInstrument
    add constraint PK_STUDENTINSTRUMENT primary key (instrumentnaam, toonhoogte, studentId)
go

/*==============================================================*/
/* Table: StudentInstrumentUitvoeringStuk                       */
/*==============================================================*/
create table StudentInstrumentUitvoeringStuk (
                                                 instrumentnaam       varchar(14)          not null,
                                                 toonhoogte           varchar(7)           not null,
                                                 studentId            numeric(10)           not null,
                                                 stuknr               numeric(5)           not null,
                                                 datumtijdUitvoering  datetime             not null
)
go

alter table StudentInstrumentUitvoeringStuk
    add constraint PK_STUD_INSTR_UITV_STUK primary key (instrumentnaam, toonhoogte, studentId, stuknr, datumtijdUitvoering)
go

/*==============================================================*/
/* Table: Stuk                                                  */
/*==============================================================*/
create table Stuk (
                      stuknr               numeric(5)           not null,
                      componistId          numeric(4)           not null,
                      titel                varchar(20)          not null,
                      stuknrOrigineel      numeric(5)           null,
                      genrenaam            varchar(10)          not null,
                      niveaucode           char(1)              null,
                      speelduur            numeric(3,1)         null,
                      jaartal              numeric(4)           not null
)
go

alter table Stuk
    add constraint PK_STUK primary key (stuknr)
go

alter table Stuk
    add constraint AK_STUK unique (componistId, titel)
go

/*==============================================================*/
/* Table: UitvoeringStuk                                        */
/*==============================================================*/
create table UitvoeringStuk (
                                stuknr               numeric(5)           not null,
                                datumtijdUitvoering  datetime             not null
)
go

alter table UitvoeringStuk
    add constraint PK_UITVOERINGSTUK primary key (stuknr, datumtijdUitvoering)
go

alter table Bezettingsregel
    add constraint FK_BZTRGL_REF_INSTR foreign key (instrumentnaam, toonhoogte)
        references Instrument (instrumentnaam, toonhoogte)
go

alter table Bezettingsregel
    add constraint FK_BZTRGL_REF_STUK foreign key (stuknr)
        references Stuk (stuknr)
go

alter table Componist
    add constraint FK_COMP_REF_SCHOOL foreign key (schoolId)
        references Muziekschool (schoolId)
go

alter table Student
    add constraint FK_STUDENT_REF_SCHOOL foreign key (schoolId)
        references Muziekschool (schoolId)
go

alter table StudentInstrument
    add constraint FK_STUDENT_REF_NIVEAU foreign key (niveaucode)
        references Niveau (niveaucode)
go

alter table StudentInstrument
    add constraint FK_STUDINSTR_REF_STUDENT foreign key (studentId)
        references Student (studentId)
go

alter table StudentInstrument
    add constraint FK_STUD_REF_INSTRUMENT foreign key (instrumentnaam, toonhoogte)
        references Instrument (instrumentnaam, toonhoogte)
go

alter table StudentInstrumentUitvoeringStuk
    add constraint FK_STUDINSTR_REF_STUDINSTRUITV foreign key (instrumentnaam, toonhoogte, studentId)
        references StudentInstrument (instrumentnaam, toonhoogte, studentId)
go

alter table StudentInstrumentUitvoeringStuk
    add constraint FK_STUDINSTR_REF_UITVOERING foreign key (stuknr, datumtijdUitvoering)
        references UitvoeringStuk (stuknr, datumtijdUitvoering)
go

alter table Stuk
    add constraint FK_STUK_REF_COMPONIST foreign key (componistId)
        references Componist (componistId)
go

alter table Stuk
    add constraint FK_STUK_REF_GENRE foreign key (genrenaam)
        references Genre (genrenaam)
go

alter table Stuk
    add constraint FK_STUK_REF_NIVEAU foreign key (niveaucode)
        references Niveau (niveaucode)
go

alter table Stuk
    add constraint FK_STUK_REF_STUK foreign key (stuknrOrigineel)
        references Stuk (stuknr)
go

alter table UitvoeringStuk
    add constraint FK_UITVOERING_REF_STUK foreign key (stuknr)
        references Stuk (stuknr)
go

