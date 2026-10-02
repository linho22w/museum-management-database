--Protocolo da Fase 2 do Trabalho Experimental 
--Enunciado B

--Criacao da BASE DE DADOS 
USE master
GO
CREATE DATABASE TP2BD
GO

--Criacao das tabelas
USE TP2BD
GO
CREATE TABLE Museus(
Codigo_museu			INT				NOT NULL,
Nome					VARCHAR(50)		NOT NULL,
Localizacao_cidade		VARCHAR(50)		NOT NULL,
Localizacao_pais		VARCHAR(50)		NOT NULL,
PRIMARY KEY (Codigo_museu)
)

CREATE TABLE Obras(
Id_obra			INT				NOT NULL,
Codigo_museu	INT				NOT NULL,
Titulo			VARCHAR(50)		NOT NULL,
Descricao		VARCHAR(100)	NOT NULL,
Colecao			VARCHAR(50),
PRIMARY KEY (Id_obra),
FOREIGN KEY (Codigo_museu) REFERENCES Museus (Codigo_museu)
)

CREATE TABLE Seguradora(
Codigo_seguradora	INT				NOT NULL,
Nome				VARCHAR(50)		NOT NULL,
PRIMARY KEY(Codigo_seguradora)
)

CREATE TABLE Galerias(
Codigo_galeria	INT				NOT NULL,
Nome			VARCHAR(50)		NOT NULL,
Area			FLOAT			NOT NULL,
Tipo			VARCHAR(50)		NOT NULL,
PRIMARY KEY(Codigo_galeria)
)

CREATE TABLE Materiais(
Id_material		INT				NOT NULL,
Nome			VARCHAR(50)		NOT NULL,
PRIMARY KEY (Id_material)
)

CREATE TABLE Pessoas(
Id_pessoa		INT				NOT NULL,
Nif				INT,
Nome			VARCHAR(50)		NOT NULL,
Genero			CHAR(1)			NOT NULL,
PRIMARY KEY (Id_pessoa)
)

CREATE TABLE Artistas(
Id_artista				INT				NOT NULL,
Telefone				INT				NOT NULL,
Pseudonimo				VARCHAR(50),
Nome					VARCHAR(50)		NOT NULL,
Apelido					VARCHAR(50)		NOT NULL,
Endereco_morada			VARCHAR(50)		NOT NULL,
Endereco_codigo_postal	CHAR(8)			NOT NULL,
Endereco_localidade		VARCHAR(50)		NOT NULL,
CHECK(Endereco_codigo_postal LIKE '[1-9][0-9][0-9][0-9]-[0-9][0-9][0-9]'),
PRIMARY KEY (Id_artista)
)

CREATE TABLE Expor(
Codigo_galeria	INT				NOT NULL,
Id_obra			INT				NOT NULL,
Id_expor		INT				NOT NULL,
Data_expor		DATE			NOT NULL,
Data_fim_expor	DATE,
PRIMARY KEY (Codigo_galeria, Id_expor, Id_obra),
FOREIGN KEY (Codigo_galeria) REFERENCES Galerias (Codigo_galeria),
FOREIGN KEY (Id_obra)		 REFERENCES Obras (Id_obra),
CHECK (Data_fim_expor > Data_expor)
)

CREATE TABLE Tema_expor(
Id_tema		INT		NOT NULL,
Id_obra		INT		NOT NULL,
Tema		VARCHAR(25)		NOT NULL,
PRIMARY KEY (Id_obra, Id_tema),
FOREIGN KEY (Id_obra)		REFERENCES Obras (Id_obra)
)

CREATE TABLE Segurar(
Id_expor			INT		NOT NULL,
Codigo_galeria		int		NOT NULL,
Id_obra				int		NOT NULL,
Codigo_seguradora	INT		NOT NULL,
Data_segurar		DATE	NOT NULL,
Prestacao			MONEY	NOT NULL,
Valor_seguro		MONEY	NOT NULL,
Periodicidade		VARCHAR(15) 	NOT NULL,
PRIMARY KEY (Id_expor,Codigo_galeria, Id_obra, Codigo_seguradora, Data_segurar),
FOREIGN KEY (Codigo_galeria, Id_expor, Id_obra) REFERENCES Expor(Codigo_galeria, Id_expor, Id_obra),
FOREIGN KEY (Codigo_seguradora) REFERENCES Seguradora (Codigo_seguradora)
)

CREATE TABLE Obras_Materiais(
Id_obra			INT		NOT NULL,
Id_material		INT		NOT NULL,
PRIMARY KEY (Id_obra, Id_material),
FOREIGN KEY (Id_obra) REFERENCES Obras (Id_obra),
FOREIGN KEY (Id_material) REFERENCES Materiais (Id_material)
)

CREATE TABLE Visitar(
Codigo_museu	INT		NOT NULL,
Id_pessoa		INT		NOT NULL,
Data_visitar	DATE	NOT NULL,
Hora_entrada	SMALLDATETIME	NOT NULL,		
Preco			MONEY	NOT NULL,
Hora_saida		SMALLDATETIME,
PRIMARY KEY (Codigo_museu, Id_pessoa, Data_visitar, Hora_entrada),
FOREIGN KEY (Codigo_museu) REFERENCES Museus (Codigo_museu),
FOREIGN KEY (Id_pessoa) REFERENCES Pessoas (Id_pessoa),
CHECK( Hora_saida > Hora_entrada)
)

CREATE TABLE Criar(
Id_obra		INT		NOT NULL,
Id_artista	INT		NOT NULL,
Data_criar	DATE	NOT NULL,
PRIMARY KEY (Id_obra, Id_artista),
FOREIGN KEY (Id_obra) REFERENCES Obras (Id_obra),
FOREIGN KEY (Id_artista) REFERENCES Artistas (Id_artista)
)

CREATE TABLE Comprar(
Id_pessoa	INT		NOT NULL,
Id_artista	INT		NOT NULL,
Data_compra	DATE	NOT NULL,
Valor		MONEY	NOT NULL,
PRIMARY KEY (Id_pessoa, Id_artista, Data_compra),
FOREIGN KEY (Id_pessoa) REFERENCES Pessoas (Id_pessoa),
FOREIGN KEY (Id_artista) REFERENCES Artistas (Id_artista)
)


--(1) Inserção de registos nas tabelas

INSERT INTO Museus(Codigo_museu, Nome, Localizacao_cidade, Localizacao_pais)
Values
(10000, 'Museu da Vila Velha', 'Vila Real', 'Portugal'),
(10001, 'Museu do Prado', 'Madrid', 'Espanha'),
(10002, 'Museu Picasso', 'Barcelona', 'Espanha'),
(10003, 'Museu Egipcio', 'Turim', 'Italia'),
(10004, 'Museu de Freixo', 'Bragança', 'Portugal')

INSERT INTO Obras(Id_obra, Codigo_museu, Titulo, Descricao, Colecao)
VALUES
(100, 10000, 'Paisagem em Aquarela', 'Uma bela paisagem natural pintada com técnicas de aquarela', 'Arte Comtemporanea'),
(101, 10002, 'Les Demoiselles d´Avignon', 'Uma pintura do periodo cubista', 'Arte moderna'),
(102, 10001, 'Retrato de uma Dama', 'Um retrato realista de uma dama da alta sociedade', 'Arte Classica'),
(103, 10001, 'As duas Fridas', 'As duas imagens de Frida', 'Autorretrato'),
(104, 10004, 'Bichos da Seda', 'Pintura sobre seda', 'Seda'),
(105, 10000, 'Garota com Balão', 'Jovem garota com balão em forma de coração', 'Pintura de Rua')

INSERT INTO Seguradora(Codigo_seguradora, Nome)
Values
(10, 'Seguradora Nacional'),
(11, 'Seguradora Infante'),
(12, 'Seguradora Guarda')

INSERT INTO Galerias(Codigo_galeria, Nome, Area, Tipo)
Values
(10, 'Galeria de Arte Moderna', 150, 'Contemporânea'),
(11, 'Galeria de Esculturas', 200, 'Clássica'),
(12, 'Galeria de Arte Abstrata', 160, 'Abstrata'),
(13, 'Galeria de Fotografia', 60, 'Documental'),
(14, 'Galeria de Arte Urbana', 75, 'Urbana')

INSERT INTO Materiais(Id_material, Nome)
Values
(100, 'Guache'),
(101, 'Aquarela'),
(102, 'Óleo sobre tela'),
(103, 'Papel'),
(104, 'Spray')

INSERT INTO Pessoas(Id_pessoa, Nif, Nome, Genero)
Values
(10000, 123456723, 'Maria Santos', 'F'),
(10001, 236590157, 'Rui Costa', 'M'),
(10002, 190132044, 'Ana Silva', 'F'),
(10003, 200901276, 'Mário Gomes', 'M'),
(10004, 098765343, 'Óscar Ulisses', 'M')

INSERT INTO Artistas(Id_artista, Telefone, Pseudonimo, Nome, Apelido, Endereco_morada, Endereco_codigo_postal, Endereco_localidade)
Values
(1000, 961927712, 'Picasso', 'Pablo', 'Ruiz', 'Rua das Artes, 123', '5702-202', 'Cidade das Artes'),
(1001, 911867921, 'Da Vinci', 'Leonardo', 'di Ser Piero', 'Avenida dos Mestres, 129', '8129-901', 'Cidade das Pinturas'),
(1002, 931920455, 'Frida', 'Magdalena', 'Kahlo', 'Rua das Flores, 720', '9125-910', 'Cidade das Cores'),
(1003, 967765432, 'Banksy', 'Robin', 'Gunningham', 'Rua das Tintas, 420', '9182-736', 'Cidade dos Artistas'),
(1004, 967373614, 'Vhils', 'Alexandre', 'Farto', 'Rua das Paredes, 907', '1000-619', 'Cidade dos Escultores'),
(1005, 912993830, 'Odeith', 'Sérgio', 'Duarte', 'Rua da Ilusão, 217', '5180-177', 'Cidade das Tintas')

INSERT INTO Expor(Codigo_galeria, Id_obra, Id_expor, Data_expor, Data_fim_expor)
Values

(10, 100, 100, '2022/1/20', NULL),
(11, 102, 101, '2022/12/29', '2023/3/4'),
(10, 101, 102, '2020/2/1', '2023/5/23'),
(14, 105, 103, '2023/5/28', NULL),
(11, 103, 104, '2023/4/27', NULL),
(13, 104, 105, '2023/5/11', NULL),
(13,102,106,'2023/5/20', '2023/6/2')


INSERT INTO Tema_expor(Id_tema, Id_obra, Tema)
Values
(100, 101, 'O Cubismo'),
(101, 100, 'Natureza'),
(102, 102, 'Beleza Feminina'),
(103, 105, 'A Rua'),
(104, 103, 'O eu'),
(105, 104, 'Bichos')

INSERT INTO Segurar(Id_expor, Codigo_galeria, Id_obra, Codigo_seguradora, Data_segurar, Prestacao, Valor_seguro, Periodicidade)
Values
(100,10,100,10,'2022/1/18', 100, 1000, 'Mensal'),
(101,11,102,12, '2022/12/21', 80, 960, 'Mensal'),
(102,10,101,11,'2020/1/30', 400, 2000, 'Trimestral')

INSERT INTO Obras_Materiais(Id_obra, Id_material)
Values
(100,101),
(101,100),
(102,102)

INSERT INTO Visitar(Codigo_museu,Id_pessoa, Data_visitar, Hora_entrada, Preco, Hora_saida)
Values
(10003,10000, '2022/12/22','2022/12/22 18:00:00', 7, '2022/12/22 18:53:00'),
(10000,10000, '2022/10/1', '2022/10/1 10:30:00', 6.75, '2022/10/1 11:46:00'),
(10003,10000, '2023/2/3','2023/2/3 15:00:00', 7, '2023/2/3 16:22:00'),
(10001,10002, '2023/5/20', '2023/2/20 14:00:00', 17.5, '2023/2/20 15:12:00'),
(10001,10001, '2023/5/20', '2023/1/12 17:00:00', 17.5, '2023/1/12 18:21:00'),
(10002,10003, '2023/5/20', '2023/5/20 15:00:00', 22.3, '2023/5/20 16:51:00'),
(10004,10004, '2023/5/2', '2023/6/2 9:30:00', 5.5,'2023/6/2 10:27:00' ),
(10002,10001, GETDATE(), GETDATE(), 22.3, NULL),
(10002,10004, GETDATE(), GETDATE(), 22.3, NULL)


INSERT INTO Criar(Id_obra, Id_artista, Data_criar)
Values
(101, 1000, '1907/6/20'),
(103, 1002, '1939/10/21'),
(102, 1001, '1470/7/11'),
(100, 1004, '2003/7/17'),
(104, 1005, '2002/12/29'),
(105, 1003, '2002/5/3')

INSERT INTO Comprar(Id_pessoa, Id_artista, Data_compra, Valor)
Values
(10000, 1000, '2023/1/2', 50000),
(10003, 1001, '2020/12/2', 80200),
(10002, 1002, '2021/10/30', 45000),
(10004, 1003, '2019/3/14', 1000000)

--(2) Resposta às perguntas do protocolo

--(2.1) Qual a 1ª Obra criada ? [Obra(Título), Data, Descrição]
SELECT O.Titulo, C.Data_criar, O.Descricao
FROM Criar C, Obras O
WHERE C.Id_obra = O.Id_obra and
	C.Data_criar = (SELECT MIN(Data_criar)
						FROM Criar) 

--(2.2) Quantos Museus visitou cada Pessoa ? [Pessoa(Nome), N_Museus)
SELECT P.Nome, COUNT(DISTINCT V.Codigo_museu) as 'Museus visitados'
FROM Museus M, Pessoas P, Visitar V
WHERE P.Id_pessoa = V.Id_pessoa and
	  V.Codigo_museu = M.Codigo_museu 
GROUP BY P.Nome

--(2.3) Que artistas tiveram obras compradas por pessoas de género "Feminino" ? [Artistas(Nome), Obra(Valor)]
SELECT CONCAT(A.Nome, ' ',A.Apelido) as Nome, C.Valor
FROM Artistas A, Comprar C, Pessoas P
WHERE A.Id_artista = C.Id_artista and
		C.Id_pessoa = P.Id_pessoa and
		P.Genero = 'F'

--(2.4) Qual o Museu com maiores receitas nos últimos 90 dias ? [Museu(Nome), Total Receitas]
SELECT TOP 1  M.Nome, SUM(V.Preco) as 'Total Receitas'
FROM Museus M, Visitar V
WHERE M.Codigo_museu = V.Codigo_museu AND
		V.Data_visitar >= DATEADD(day,-90,GETDATE())
GROUP BY M.Nome
ORDER BY [Total Receitas] DESC

--(2.5) Que Exposições (Expor) têm neste momento Obras expostas mas não têm nenhum seguro ? [Expor(Tema, Data)]. Apresente-as por ordem cronológica.
SELECT DISTINCT T.Tema, E.Data_expor
FROM Expor E, Tema_expor T, Segurar S, Obras O
WHERE E.Id_obra = O.Id_obra AND 
		O.Id_obra = T.Id_obra AND
		E.Data_fim_expor IS NULL AND
		T.Id_obra NOT IN (SELECT S.Id_obra
							FROM Segurar S)
order by E.Data_expor ASC


--(3) Assumindo que para expor uma obra num museu tem um custo de 2€/dia, crie um procedimento 
-- que para um dado museu e um dado mês calcule o custo de exposição por museu apresentando uma 
-- tabela com os ID, nome dos Museus e o total de despesa desse Museu nesse mês. O procedimento 
-- deve devolver o custo total de todos os museus.
CREATE PROCEDURE calcularCustoExposicao @Codigo_museu INT, @Mes INT, @Ano INT, @CustoTotal MONEY OUTPUT
as
BEGIN 
    DECLARE @DataInicio DATE, @DataFim DATE;

    -- Data de inicio e data de fim com base no mes e no ano fornecidos
    SET @DataInicio = DATEFROMPARTS(@Ano, @Mes, 1);
    SET @DataFim = EOMONTH(@DataInicio) -- OU  DATEADD(MONTH,1,@DataInicio);

    --Variavel para armazenar o custo total da exposicao
    SET @CustoTotal = 0;

    --Tabela para armazenar os custos por museu
    CREATE TABLE CustosMuseu (
        Codigo_museu INT,
        Nome VARCHAR(30),
        Custo MONEY
        );

    --Custo de exposicao por museu para um determinado mes

    INSERT INTO CustosMuseu (Codigo_museu, Nome, Custo)
    SELECT M.Codigo_museu, M.Nome, SUM((CASE WHEN MONTH(E.Data_expor) = MONTH(E.Data_fim_expor) 
										THEN DATEDIFF(day, E.Data_expor, E.Data_fim_expor) + 1 
										WHEN MONTH(E.Data_expor) = MONTH(getdate()) and E.Data_fim_expor is null
										THEN DATEDIFF(day, E.Data_expor, getdate()) + 1 
										ELSE DATEDIFF(day, E.Data_expor, EOMONTH(E.Data_expor)) + 1 END) * 2) as Custo
    FROM Expor E, Museus M, Obras O				--COEALESCE Verifica se a data_fim é null e se for substitui for getdate,,, COALESCE(E.Data_fim_expor, GETDATE()) -> retorna o primeiro valor nao nulo de uma lista de expressoes
    WHERE O.Id_obra = E.Id_obra and				--EOMONTH obtem o ultimo dia do mes da data passada como parametro
            O.Codigo_museu = M.Codigo_museu and
            E.Data_expor >= @DataInicio and E.Data_expor < @DataFim
    GROUP BY M.Codigo_museu, M.Nome;

    --Atualiza o custo total da expo
    Select @CustoTotal = SUM(Custo)
    FROM CustosMuseu

    --Resultado
    SELECT Codigo_museu, Nome, Custo
    from CustosMuseu

	--Limpar tabela temporaria
    DROP TABLE CustosMuseu
END;
--Exemplo para testar o stored procedure
DECLARE @CustoTotalMuseus MONEY;
EXECUTE calcularCustoExposicao @Codigo_museu = 10001, @Mes = 5, @Ano = 2023, @CustoTotal = @CustoTotalMuseus OUTPUT;
SELECT @CustoTotalMuseus as 'Custo total de todos os museus'


--(4) Um armazém pode ter no máximo 200 visitantes em simultâneo. 
-- Crie um trigger que apenas deixe inserir um novo registo no 
-- relacionamento Visitar se o Museu pretendido ainda não estiver na capacidade máxima.
CREATE TRIGGER verificarCapacidadeMax
ON Visitar
INSTEAD OF INSERT --Quando ocorre uma insercao é acionado
AS
BEGIN
  -- Verifica se o Museu já atingiu a capacidade máxima
  IF EXISTS (
    SELECT V.Codigo_museu
    FROM Visitar V, inserted I
    WHERE I.Codigo_museu = V.Codigo_museu and
	(I.Hora_entrada < V.Hora_saida OR V.Hora_saida IS NULL) AND (I.Hora_saida >= V.Hora_entrada OR I.Hora_saida IS NULL)
	--Isto verifica se os intervalos de tempo do recem inserido e dos que ja estam inseridos (ja existentes), se sobrepoem (CUMPRE COM A QUESTAO DO 'SIMULTANEO' DO ENUNCIADO DA PERGUNTA)
    GROUP BY V.Codigo_museu 
    HAVING COUNT(*) >= 2 --Capacidade máx. = 2, visto que a nossa base de dados nao tem tantos elementos para que possa ser 
	--testada com 200 visitantes, como indica no protocolo, mas se funciona para 2 irá funcionar para 200 também
  )
  BEGIN
    -- Se a capacidade máxima foi atingida, lança um erro
	PRINT 'Capacidade máxima de visitantes atingida para o Museu'
    ROLLBACK TRANSACTION; -- Desfaz a transacao se estiver em andamento e impede a insercao
  END
  ELSE
  BEGIN
    -- Se a capacidade máxima não foi atingida, inserir o novo registro
    INSERT INTO Visitar (Codigo_museu, Id_pessoa, Data_visitar, Hora_entrada, Preco, Hora_saida)
    SELECT Codigo_museu, Id_pessoa, Data_visitar, Hora_entrada, Preco, Hora_saida
    FROM inserted;
  END
END;
--Exemplo para testar o trigger
--Inserindo um registo no relacionamento Visitar para um museu já com a capacidade máx. atingida numa determinada altura
INSERT INTO Visitar (Codigo_museu, Id_pessoa, Data_visitar, Hora_entrada, Preco, Hora_saida)
VALUES(10002, 10003,  getdate(), getdate(), 22.3, NULL)
--Inserindo um registo no relacionamento Visitar para um museu ainda com a capacidade máx. nao atingida numa determinada altura
INSERT INTO Visitar (Codigo_museu, Id_pessoa, Data_visitar, Hora_entrada, Preco, Hora_saida)
VALUES(10002, 10003,  '2023/5/20', '2023/5/20 16:00:00', 22.3, '2023/5/20 16:58:00')




-- Visualizar algumas tabelas 
SELECT * FROM Artistas
SELECT * FROM Segurar
SELECT * FROM Pessoas
SELECT * FROM Visitar
SELECT * FROM Museus
SELECT * FROM Obras
SELECT * FROM Expor
SELECT * FROM Criar

--Remoção da base de dados
USE MASTER
GO
ALTER DATABASE TP2BD SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE TP2BD
GO
