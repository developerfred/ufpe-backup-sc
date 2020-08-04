/*sintaxe - criando VARRAYS*/
create type nomeDoConjunto as varray(numero) of tipoDosObjetos;

--criando o TIPO DEPENDENTE
create type T_DEPENDENTE as object(
       nome varchar(20),
       data_nasc date
);

--criando o varray
create type L_DEPENDENTE as varray(10) of T_DEPENDENTE;

--criando TIPO EMPREGADO
create type T_EMPREGADO as object(
       matricula number,
       nome varchar(20),
       salario real(7,2),
       listaDependente L_DEPENDENTE
);
--criando a TABELA EMPREGADO
create table EMPREGADO of T_EMPREGADO(
       matricula primary key,
       nome not null
);

insert into EMPREGADO values (27990036, 'ten rodrigo', 1000, L_DEPENDENTES(T_DEPENDENTE('JULIA', to_date('04/07/1980','dd/mm/yyyy'), T_DEPENDENTE('lane', to_date('25/05/1985', 'dd/mm/yyyy') ) ) ));
insert into EMPREGADO values (27000003, 'ten muido', 500, L_DEPENDENTES(T_DEPENDENTE('MARIA', to_date('01/01/1999', 'dd/mm/yyyy')), T_DEPENDENTE('JOAO', to_date('22/06/1952','dd/mm/yyyy')) ));


select D.* from EMPREGADO E, TABLE(E.LISTADEPENDENTE)D ;
select D.* from EMPREGADO E, TABLE(E.LISTADEPENDENTE)D where E.nome = 'ten rodrigo';
select E.listaDependente from EMPREGADO E where E.NOME = 'arfs';


