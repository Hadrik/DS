begin transaction;

insert into Produkt(nazev, popis, cena, archivovany)
    values ('Produkt 1', 'Popis produktu 1', 100.0, 0)
insert into Produkt(nazev, popis, cena, archivovany)
    values ('Produkt 2', 'Popis produktu 2', 200.0, 0)

insert into Osoba(jmeno, adresa, email)
    values ('Josef Raketka', N'Mokrá 3', 'lumpik@seznam.cz')
insert into Osoba(jmeno, adresa, email)
    values (N'Luboš Bailador', 'Na kamenu 7', 'lubosbailador@lubosbailador.com')

insert into Zakaznik(osoba_id, heslo, fakturacni_adresa, cislo_karty)
    values (1, 'heslo123', N'Fakturační adresa 1', '1234567890123456')

insert into Zamestnanec(osoba_id, cislo_uctu, pozice)
    values (2, '1234567890123456789012', 'Capek co vyrabi')

commit transaction;