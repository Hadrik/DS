create table Osoba (
    osoba_id        integer         not null primary key identity,
    jmeno           varchar(100)    not null,
    adresa          varchar(200)    not null,
    email           varchar(100)    not null
);

create table Zakaznik (
    osoba_id            integer     not null primary key,
    heslo               nvarchar(40) not null,
    fakturacni_adresa   nvarchar(500),
    cislo_karty         varchar(16),
    
    foreign key (osoba_id) references Osoba(osoba_id)
);

create table Zamestnanec (
    osoba_id        integer     not null primary key,
    cislo_uctu      varchar(22),
    pozice          nvarchar(100),
    
    foreign key (osoba_id) references Osoba(osoba_id)
);

create table Objednavka (
    objednavka_id           integer     not null primary key identity,
    zakaznik_osoba_id       integer     foreign key references Zakaznik(osoba_id),
    zamestnanec_osoba_id    integer     foreign key references Zamestnanec(osoba_id), 
    datum_vytvoreni         datetime2,
    status                  nvarchar(50),
    celkova_cena            float,
    poznamka                nvarchar(500)
);

create table Produkt (
    produkt_id      integer         not null primary key identity,
    nazev           nvarchar(200)   not null,
    popis           nvarchar(500),
    cena            float           not null,
    archivovany     bit
);

create table Objednany_Produkt (
    objednavka_id   integer     not null foreign key references Objednavka(objednavka_id),
    produkt_id      integer     not null foreign key references Produkt(produkt_id),
    pocet           integer     not null,
    cena            float       not null,
    poznamka        nvarchar(500),
    
    primary key (objednavka_id, produkt_id)
);