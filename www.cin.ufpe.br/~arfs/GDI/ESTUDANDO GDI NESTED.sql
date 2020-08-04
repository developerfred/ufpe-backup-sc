--nested table
/*sitaxe*/
create type nomeDaNestedTable as table of tipoDoObjeto;

--criando o TIPO EMPREGADO
create type T_EMPREGADO as Object(
       matricula number,
       nome varchar(20)
);

--criando a  NESTED TABLE
create type EMP_NESTED as table of T_EMPREGADO;
--create type EMP_NESTED as table of REF T_EMPREGADO;

--criando o TIPO DEPARTAMENTO
create type T_DEPARTAMENTO(
       codigo number,
       nome varchar2(20),
       empregados EMP_NESTED
);

create table EMPREGADO of T_EMPREGADO(
       matricula primary key,
       nome not null
);
create table DEPARTAMENTO of T_DEPARTAMENTO(
       codigo primary key,
       nome not null,
       nested table empregados store as EMP_T --NAUM EH PRA SER EMP_NESTED? O QUE ISSO AQUI REALMENTE TÁ FAZENDO? É PRECISO,
 );                                                 --JÁ QUE empregados é to tipo EMP_NESTED???

/*inserindo dado na tabela principal e aninhada*/
insert into DEPARTAMENTO values (1, 'depto de compras', EMP_NESTED(T_EMPREGADO(2799006, 'SIMUILDO'), T_EMPREGADO(1212, 'JOAOZINHO')));

/*inserindo dado na tabela aninhada (somente)*/
--insere os valores '3' e 'silva' na nested table de empregados retornada pela operação entre () depos do the
insert into THE (select D.EMPREGADOS from DEPARTAMENTO D where D.NOME = 'depto de compras') values (3, 'Silva');
insert into THE (select D.EMPREGADOS from DEPARTAMENTO D where D.NOME = 'depto de compras') values(T_EMPREGADO(2741111, 'FULANO'));

--LSITA OS EMPREGADOS DO DEPTO DEPTO COMPRAS
select E.* from DEPARTAMENTO D, TABLE (D.EMPREGADOS) E where D.NOME = 'DEPTO COMPRAS';

--LISTA TODOS OS DEPARTAMENTOS
select * from DEPARTAMENTO;

--LISTA TODOS DEPTOS E EMPREGADOS
select * from DEPARTAMENTO D, TABLE (D.EMPREGADOS);


