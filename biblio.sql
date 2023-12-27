----------2-----------
---creation des tables
create table auteur(
	code_auteur serial primary key not null,
	nom_auteur varchar(20) not null
);

create table emprunteur(
	code_emp serial primary key not null,
	nom_emp varchar(20),
	prenom_emp varchar(20),
	adresse varchar(20),
	etat_cot bool,
	date_inscription date);

create table livre(
	code_livre serial primary key ,
	code_auteur integer,
	foreign key (code_auteur) references auteur(code_auteur),
	date_editeur date ,
	nom_editeur varchar(30),
	titre varchar(50));

create table exemplaire(
	code_exempl serial primary key,
	code_livre integer,
	foreign key (code_livre) references livre(code_livre),
	valeur integer	);

create table emprunt(
	num_emprunt serial primary key, --c'est le numero qui indique l'emprunt
	code_emp integer,
	foreign key(code_emp) references emprunteur(code_emp),
	code_exempl integer,--code emprunteur comme pk
	foreign key(code_exempl) references exemplaire(code_exempl),
	date_emprunt date , --code emprunt 
	date_retour_emprunt date);


---- Insertion d'abord
insert into auteur values(
	
)


