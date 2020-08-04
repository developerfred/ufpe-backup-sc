--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  TIPOS  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--Tipo Endereco
create or replace type T_ENDERECO as object (
                                              municipio            varchar(50),
                                              bairro               varchar(50),
                                              cep                  char(9),
                                              rua                  varchar(100),
                                              complemento          varchar(20),
                                              numero               varchar(6)
                                            );
 
--Tipo Telefones
create or replace type T_TELEFONES as VARRAY(3) of char(15);

--Tipo Imovel
create or replace type t_imovel as Object(
                                            proprietario          ref T_proprietario,
                                            cadastrador           varchar(10),
                                            endereco              T_endereco,
                                            dataatualizacao       date,
                                            datacadastro          date,
                                            datahabitese          date,
                                            inscricaoimobiliaria  varchar(14),
                                            sequencialprefeitura  varchar(20),
                                            situacao              varchar(7),
                                            tipoedificacao        varchar(20),
                                            tipopatrimonio        varchar(25),
                                            sequencial            char(7),
                                            areaconstruida        numeric(7,2),
                                            finalidade            varchar(12),
                                            constructor function T_imovel1( cpf_cnpj               in              VARCHAR,
                                                                            fis_ou_juri            in              NUMBER,
                                                                            cadastrador            in              varchar,
                                                                            endereco               in              T_ENDERECO,
                                                                            habitese               in              DATE,
                                                                            inscricaoImobiliaria   in              VARCHAR,
                                                                            sequencialpref         in              VARCHAR,
                                                                            situacao               in              VARCHAR,
                                                                            tipoedificacao         in              VARCHAR,
                                                                            tipopatrimonio         in              VARCHAR,
                                                                            sequencial             in              VARCHAR,
                                                                            areaconstruida         in              NUMERIC,
                                                                            finalidade             in              VARCHAR) RETURN SELF AS RESULT
                                                                          );


--Tipo Usuario
create or replace type T_USUARIO as Object(
                                            nome          varchar2(100),
                                            login         varchar2(20),
                                            matricula     varchar2(10),
                                            tipo          char(5),
                                            email         varchar2(100),
                                            senha         blob,
                                            foto          blob
                                          );

--Tipo Proprietario
create or replace type T_PROPRIETARIO as object(
                                                nome            varchar(20),
                                                email           varchar(20),
                                                telefones       T_TELEFONE,
                                                endereco        T_ENDERECO
                                                )NOT FINAL NOT INSTANTIABLE;

--Tipo Pessoa_Fisica subtipo de Proprietario
create or replace type T_PESSOA_FISICA under T_PROPRIETARIO(
                                                             CPF            varchar(11),
                                                             RG_UF          char(2),
                                                             RG_OrgEmissor  char(3),
                                                             RG             varchar(14),
                                                             sexo           char(1),
                                                             EstadoCivil    varchar(10),
                                                             DataNascimento date
                                                            );

--Tipo Pessoa_Juridica subtipo de Proprietario
create or replace type T_PESSOA_JURIDICA under T_PROPRIETARIO(
                                                               CNPJ           varchar(11),
                                                               Responsavel    varchar(20),
                                                               DataFundacao   date,
                                                               Tipo           varchar(10)
                                                              );

--Tipo Protocolo
create or replace type T_PROTOCOLO  as Object(
                                                numero                 number,
                                                imovel                 ref T_IMOVEL,
                                                dataAtualizacao        date,
                                                tipoRequisicao         varchar(24),
                                                andamento              varchar(18),
                                                docsProtocolo          nested_docs,
                                                dataEntrada            date
                                              );

--Tipo Tributo
create or replace type T_tributo as Object(
                                            imovel            ref T_imovel,
                                            valorImposto      number(6,2),
                                            valorPago         number(6,2)
                                            datavencimento    date,
                                            datapagamento     date,
                                            parcela           integer(2),
                                            ano               interval year(4) to month,
                                            situacao          varchar(9)
                                          );


--Tipo Documento
create or replace type T_documento as Object(
      nomedoc varchar(50)
);
--Tipo Nested Line Docs
create or replace type NESTED_LINE_DOCS as object(
    entregue number(1),
    documento ref T_DOCUMENTO
);

--Tipo(nested table) nested docs
create or replace type NESTED_DOCS as table of NESTED_LINE_DOCS;








--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§ Types Bodies  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
-- Type Body Imovel
create or replace type body T_IMOVEL as
       --Construtor
constructor function T_imovel( cpf_cnpj                             in VARCHAR,
                                fis_ou_juri                         in NUMBER,
                                cadastrador                         in varchar,
                                endereco                            in T_ENDERECO,
                                habitese                            in DATE,
                                inscricaoImobiliaria                in VARCHAR,
                                sequencialpref                      in VARCHAR,
                                situacao                            in VARCHAR,
                                tipoedificacao                      in VARCHAR,
                                tipopatrimonio                      in VARCHAR,
                                sequencial                          in VARCHAR,
                                areaconstruida                      in NUMERIC,
                                finalidade                          in VARCHAR ) RETURN SELF AS RESULT AS
  begin
              if fis_ou_juri = 0 then --fisica
                 select ref(p) into self.proprietario from PESSOA_FISICA p where p.cpf = cpf_cnpj;
              else --juridica
                 select ref(p) into self.proprietario from PESSOA_JURIDICA p where p.cnpj = cpf_cnpj;
              end if;
              self.cadastrador := cadastrador;
              self.endereco := endereco;
              self.datahabitese := habitese;
              self.inscricaoImobiliaria := inscricaoImobiliaria;
              self.sequencialprefeitura := sequencialpref;
              self.situacao := situacao;
              self.tipoedificacao := tipoedificacao;
              self.tipopatrimonio := tipopatrimonio;
              self.sequencial := sequencial;
              self.areaconstruida := areaconstruida;
              self.finalidade := finalidade;
              return;
  EXCEPTION
    WHEN others THEN
       ROLLBACK;
       raise_application_error (-20005,'vc realizou uma operacao illegal');
  end;
end;

--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Tabelas  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--Tabela de Imovel
create table IMOVEL of T_imovel(
                                proprietario                   not null,
                                endereco                       not null,
                                constraint End_imovel_nulo check(
                                                                  (endereco.rua is not null) and
                                                                  (endereco.municipio is not null) and
                                                                  (endereco.cep is not null) and
                                                                  (endereco.bairro is not null)
                                                                 ),
                                dataatualizacao                not null,
                                inscricaoimobiliaria           not null,
                                unique(inscricaoimobiliaria),
                                situacao                       not null,
                                constraint situacao_CHECK check(situacao in('ATIVO','INATIVO')),
                                tipoedificacao                 not null,
                                CONSTRAINT tipoedificacao_enum check(tipoedificacao in('APTO','CASA','SALA CONJUNTO','LOJA','MOCAMBO','INST. FINANCEIRA','HOTEL','CINEMA TEATRO','INST. HOSPITALAR','EDUCACAO','EDIF. GARAGEM','EDIF. INDUSTRIAL','GALPAO','TELHEIRO','EDIF. ESPECIAL','CLUBE','TEMPLO','GARAGEM AUTONOMA','OUTROS','POSTO DE GASOLINA','DEPOSITO','MERCEARIA','BAR RESTAURANTE')),
                                tipopatrimonio                 not null,
                                constraint tipopatrimonio_check check(tipopatrimonio in('NAO INFORMADO','PARTICULAR','MUNICIAPAL','ESTADUAL','FEDERAL','RELIGIOSO','PUBLICO','MUNICIPAL TERCEIRIZADO')),
                                areaconstruida                 not null,
                                finalidade                     not null,
                                constraint finalidade_check check(finalidade in ('COMERCIAL','RESIDENCIAL','INDUSTRIAL')),
                                primary key(sequencial)
                              );
                              
--Tabela de Usuario
create table usuario of T_USUARIO(
                                    nome               not null,
                                    senha              not null,
                                    email              not null,
                                    matricula          not null,
                                    tipo               not null,
                                    foto               null,
                                    primary key(login),
                                    constraint matricula_unica unique(matricula),
                                    constraint tipo_usuario_check check(tipo in('DPLAN', 'ROOT'))
                                  );
                                  
--Tabela de Pessoa_Fisica
create table Pessoa_Fisica of T_Pessoa_Fisica(
                                                Nome              not null,
                                                Endereco          not null,
                                                email             not null,
                                                constraint End_nulo check(
                                                                            (endereco.rua is not null) and
                                                                            (endereco.municipio is not null) and
                                                                            (endereco.cep is not null) and
                                                                            (endereco.bairro is not null)
                                                                          ),
                                                DataNascimento     NOT NULL,
                                                RG_UF              not null,
                                                unique(RG),
                                                primary key(CPF),
                                                constraint sexo_enum check(sexo in('M','F')),
                                                RG                 not null,
                                                constraint estCiv_enum check (EstadoCivil in('SOLTEIRO','CASADO','VIUVO','DIVORCIADO'))
                                              );

--Tabela de Pessoa_Juridica
create table PESSOA_JURIDICA of T_PESSOA_JURIDICA(
                                                    primary key(CNPJ),
                                                    nome              not null,
                                                    endereco          not null,
                                                    email             not null,
                                                    constraint End_pj_nulo check(
                                                                                    (endereco.rua is not null) and
                                                                                    (endereco.municipio is not null) and
                                                                                    (endereco.cep is not null) and
                                                                                    (endereco.bairro is not null)
                                                                                  ),
                                                    tipo              not null,
                                                    responsavel       not null,
                                                    constraint tipo_PJ_enum check(tipo in('DIREITO PUBLICO','DIREITO PRIVADO','ENTIDADE RELIGIOSA','SEM FINS LUCARATIVOS')),
                                                    datafundacao      not null
                                                );
                                                
--Tabela Protocolo
create table Protocolo of T_protocolo(
                                        primary key(numero),
                                        imovel                not null,
                                        dataatualizacao       not null,
                                        dataentrada           not null,
                                        tiporequisicao        not null,
                                        constraint requisicao_enum check(tiporequisicao in('ISENCAO','ALTERACAO CADASTRO','RESTITUICAO','EXCLUSAO POR DEMOLICAO','EXCLUSAO POR REMEMBRAMENTO','EXCLUSAO POR DESMEMBRAMENTO','CADASTRAMENTO','LEVANTAMENTO DE DEBITOS','CERTIDAO PAGAMENTO','CERTIDAO DEBITO','CERTIDAO ISENCAO','EMISSAO 2 VIA TPEI')),
                                        andamento             not null,
                                        CONSTRAINT andamento_enum check(andamento in('EM ANDAMENTO','PROVIDENCIADO','ENCAMINHADO A DAJ'))
                                      )nested table docsProtocolo store as N_DOCUMENTOS;

--Tabela Tributo
create table imposto of T_IMPOSTO(
                                    imovel              not null,
                                    datavencimento      not null,
                                    valororiginal       not null,
                                    valorpago           not null,
                                    situacao            not null,
                                    constraint situacaotenum check(situacao in('PAGO','PENDENTE')),
                                    parcela             not null,
                                    ano                 not null
                                  );

--Tabela de Documentos
create table Documentos of T_documento(
       primary key(nome_doc)
);
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§  Procedures  §§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§
--procedure para atualizar um imovel, com excecao do atributo proprietario
create or replace procedure UPDATE_IMOVEL(endereco in Imovel.endereco%type,
                                          habitese in Imovel.datahabitese%type,
                                          inscricaoImobiliaria in Imovel.inscricaoimobiliaria%type,
                                          sequencialpref in Imovel.sequencialprefeitura%type,
                                          situacao in Imovel.situacao%type,
                                          tipoedificacao in Imovel.tipoedificacao%type,
                                          tipopatrimonio in Imovel.tipopatrimonio%type,
                                          sequencial in Imovel.sequencial%type,
                                          areaconstruida in Imovel.areaconstruida%type,
                                          finalidade in Imovel.finalidade%type
                                          ) AS
        ATUAL DATE;
        BEGIN
           SELECT CURRENT_DATE INTO ATUAL FROM DUAL;
           UPDATE IMOVEL I SET I.ENDERECO = ENDERECO,
                                    I.datahabitese = habitese,
                                    I.inscricaoImobiliaria = inscricaoImobiliaria,
                                    I.sequencialprefeitura = sequencialpref,
                                    I.situacao = situacao,
                                    I.tipoedificacao = tipoedificacao,
                                    I.tipopatrimonio = tipopatrimonio,
                                    I.areaconstruida = areaconstruida,
                                    I.finalidade = finalidade,
                                    I.DATAATUALIZACAO = ATUAL WHERE I.SEQUENCIAL = SEQUENCIAL;
        EXCEPTION
          WHEN others THEN
            ROLLBACK;
            raise_application_error (-20005,'vc realizou uma operacao illegal');
END UPDATE_IMOVEL;

--procedure para atualizar o proprietario de um imovel
create or replace procedure UPDATE_PROPRIETARIO_IMOVEL(CPF_CNPJ       IN VARCHAR,
                                                       TIPO           IN NUMBER,
                                                       SEQUENCIAL     IN IMOVEL.SEQUENCIAL%TYPE
                                                        )AS
PROP REF T_PROPRIETARIO;
ATUAL DATE;
BEGIN
    SELECT CURRENT_DATE INTO ATUAL FROM DUAL;
    IF(TIPO = 0) THEN --FISICA
      SELECT REF(P) INTO PROP FROM PESSOA_FISICA P WHERE P.CPF = CPF_CNPJ;
    ELSE
      SELECT REF(P) INTO PROP FROM PESSOA_JURIDICA P WHERE P.CNPJ = CPF_CNPJ;
    END IF;
    UPDATE IMOVEL I SET I.PROPRIETARIO = PROP, I.DATAATUALIZACAO = ATUAL WHERE I.SEQUENCIAL = SEQUENCIAL;
    COMMIT;
EXCEPTION
    WHEN others THEN
      ROLLBACK;
      raise_application_error (-20005,'vc realizou uma operacao illegal');
END UPDATE_PROPRIETARIO_IMOVEL;


--procedure para marcar um documento como entregue
create or replace procedure addDocumentoEntregue(nProtocolo varchar,
                                                 doc number
                                                 )as
ATUAL DATE;
BEGIN
      SELECT CURRENT_DATE INTO ATUAL FROM DUAL;
      UPDATE TABLE(SELECT  P.docsProtocolo FROM PROTOCOLO P WHERE P.NUMERO = nProtocolo) A SET A.ENTREGUE = 1 WHERE DEREF(A.documento).IDDOC = DOC;
      UPDATE PROTOCOLO SET DATAATUALIZACAO = ATUAL WHERE NUMERO = nProtocolo;
      COMMIT;
      EXCEPTION
WHEN others THEN
  ROLLBACK;
  raise_application_error (-20005,'vc realizou uma operacao illegal');
END addDocumentoEntregue;



