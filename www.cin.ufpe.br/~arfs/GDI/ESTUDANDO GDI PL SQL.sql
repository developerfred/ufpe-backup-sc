--cria um TIPO
create type nomeDoTipo as Object(
--lista de atributos e MÉTODOS
);

--cria uma TABELA
create table nomeDaTablea of nomeDoTipo(
--lista de propriedades dos ATRIBUTOS
);

--DESTRÓI um tipo
drop type nomeDoTipo

--DESTRÓI uma tabela
drop table nomeDaTabela;

--INSERINDO valores
insert into nomeDaTabela(nomeDosAtributos values(valores));--nomeDosAtributos é opcional
--DELETANDO valores
delete from nomeDaTabela where (condição);

/*criando o TIPO EMPREGADO*/
create type T_EMPREGADO as Object(
       matricula number,
       nome varchar(20),
       endereco varchar(50),
       data_admissao date,
       codigo_DEP number--foi inserido aqui pq o rel entre emp e dep é n pra 1
);
/*criando a TABELA EMPREGADO*/
create table EMPREGADO of T_EMPREGADO(
       matricula primary key,
       foreign key (codigo_DEP) references DEPARTAMENTO (codigo),
       nome not null,
       endereco not null
);
/*criando o TIPO DEPARTAMENTO*/
create type T_DEPARTAMENTO as Object(
       codigo number,
       descricao varchar(100)
);
/*criando a TABELA DEPARTAMENTO*/
create type DEPARTAMENTO of T_DEPARTAMENTO(
       primary key codigo,
       descricao not null--isso precisa ou naum?
);
--obs a inserção deve obedecer os parametros do respectivo tipo
insert into EMPREGADO(matricula, nome, endereco, data_admissao, codigo_dep values (123,'arfs', 'rua sem nome', to_date('13/04/1979', 'dd/mm/yyyy'),1));
insert into EMPREGADO(matricula, nome, endereco, data_admissao, codigo_dep values (2799003, 'ten rodrigo', 'Av conde boa vista', to_date('17/09/2006','dd/mm/yyyy'),2));
insert into DEPARTAMANTO(codigo, descricao values (1,'Departamento Mestre'));
insert into DEPARTAMENTO(codigo, descricao values (2,'Diretoria de Planejamento'));

--selecionando dados - sixtaxe geral
select nomeDosAtributosASerSelecionados from NomeDasTabelas where (condição);
--selecionando dados
select E.NOME, D.DESCRICAO from EMPREGADO E, DEPARTAMENTO D where E.codigo_dep = D.codigo;
--semântica: selecione o (nome e a descricao) de (empregado e departamento) onde (o codigo do empregado = codigo do departamento)

/*criando VARRAYS*/
create type nomeDoConjunto as varray(numero) of tipoDosObjetos;
