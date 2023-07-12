create database dbinfox;
use dbinfox;

-- Criando a tabela de Usuários
create table tbusuarios(
	iduser int primary key auto_increment,
    usuario varchar(50) not null,
    fone varchar(15),
    login varchar(15) not null unique,
    senha varchar(15) not null
);

-- Inserindo um usuário na tabela do banco de dados
insert into tbusuarios(usuario, fone, login, senha) values ('Bruno Ozen', '44920465226', 'bruno_ozen', 'tiranossauro12');
select * from tbusuarios;

drop database dbinfox;