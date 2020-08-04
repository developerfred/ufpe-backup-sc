--criando o tipo professor
create type T_professor as object(
       nome varchar2(15),
       disciplina varchar2(15)
);
--criando o nestetable de professor
create type NESTED_PROFESSOR as table of T_professor;

--criando o TIPO ALUNO
create type T_aluno as object(
       matricula number,
       /*Professores é uma NESTEDTABLE de professor*/
       professores NESTED_PROFESSOR
);
--criando uma nestedtable de alunos
create type NESTED_ALUNO as table of T_aluno;
--criando o TIPO TURMA
create type T_turma as object(
       codigo varchar2(3),
       sala varchar2(3),
       /*Alunos é uma NESTETABLE de aluno*/
       alunos NESTED_ALUNO
);
--criando a tabela turma
create table turma of T_turma(
       codigo primary key
) nested table alunos store as  T_alunos
 (nested table professores store as T_profs);

--inserção de dados
insert into turma values
('I5A', 'S9', NESTED_ALUNO(
              T_aluno(210141500, NESTED_PROFESSOR(T_professor('Fernando','GDI'),T_professor('Hermano', 'PD'))),
              T_aluno(210141750, NESTED_PROFESSOR (T_professor('Silvio', 'HFC'), T_professor('Hermano', 'PLP'))))
              );

insert into table (
    /*seleciona a nestedtable de professores da tabela de alunos A*/
    select A.professores from table
    /*selec alunos da turma onde cod = '15A' - o retorno eh uma nestedtable de alunos chamada A*/
   (select T.alunos from turma T where codigo = '15A') A
   /*codição = matricula do aluno é 210141750*/
    where A.matricula = 210141750

    values ('Ruy', 'IT');

--atualização
update table(select A.professores from table
            (select T.alunos from turma T where T.codigo = '15A') A
             where A.matricula = 210141500) P
             set value(P) = T_professor('Jacques','PD')
             where P.disciplina = 'PD';

--consulta
select P.nome, P.disciplina from turma T, table (T.alunos) A, table (A.professores) P;

--value retorna a isntancia da object table ou object view
select value (T) from turma T where T.codigo = '15A';

--ref retorna referencia (object id) a uma instancia de object table
select ref (T) from turma T where T.codigo = '15A';

--deref retorna a isntancia do objeto correspondente ao ref
select deref (ref(T)) from turma T where T.codigo = '15A';

/*cria o TIPO EMPREGADO*/
create type T_empregado as object(
       id number,
       nome varchar2(20),
       endereco varchar2(30),
       projetos_TNProj NESTED_PROJETO
);

/*cria uma NESTED DE REF de empregado*/
create type NESTED_EMPREGADO as table of ref T_empregado;

/*cria o TIPO PROJETO*/
create type T_projeto as object(
       cod number,
       titulo varchar2(20),
       grupo_TNEmp NESTED_EMPREGADO
);
/*cria nested de ref de projeto*/
create type NESTED_PROJETO as table of ref T_projeto;

--criando a TABELA PROJETO
create table PROJETO of T_projeto(
       cod primary key
) nested table grupo_NTEmp store as Tab_Empregados;

--criando a TABELA empregado
create table empregado of T_empregado(
       id primary key
)nested table projetos_TNProj store as Tab_Projetos;

--inserindo dados
insert into empregado values (1, 'Julio Marques', 'Rua Amelia', NESTED_PROJETO());
insert into empregado values (2, 'Marcus Nogueira', 'Rua Bruno Veloso', NESTED_PROJETO());
insert into empregado values (3, 'Vanessa Costa', 'Av Caxangá', NESTED_PROJETO());

insert into projeto values (1, 'Distributed XML', NESTED_EMPREGADO());
insert into projeto values (2, 'JDBC 3', NESTED_EMPREGADO());

insert into the
      (select projetos_TNProj from empregado E where E.id = 1)
       select ref (p) from projeto P where P.cod = 1;

insert into the
       (select projetos_TNProj from empregado E where E.id = 2)
       select ref(p) from projeto p where p.cod = 1;
       
insert into the
       (select grupo_TNEmp from projeto p where p.cod = 1)
       select ref(e) from empregado E where E.id = 1;

insert into the
       (select grupo_TNEmp from projeto p where p.cod = 1)
       select ref(e) from empregado E where E.id = 2;

--Selecionar as instâncias dos empregados que estão participando do projeto com código 1
select DEREF(ss.COLUMN_VALUE)
       from the(select grupo_TNEmp from projeto p where p.cod = 1) ss;

--Selecionar as instâncias dos projetos em que está participando o empregado com código 1
select DEREF(ss.COLUMN_VALUE)
       from THE(select projetos_TNProj from empregado E WHERE E.ID = 1) ss;

--Seleciona os projetos que Marcus Nogueira está participando
SELECT DEREF(VALUE(p)).titulo 
       from the (select projetos_TNProj
       FROM empregado E
       WHERE E.nome = 'Marcus Nogueira') p;
