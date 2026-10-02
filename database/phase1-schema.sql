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
FOREIGN KEY (Id_obra)		 REFERENCES Obras (Id_obra)
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
FOREIGN KEY (Id_pessoa) REFERENCES Pessoas (Id_pessoa)
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
(10003, 'Museu Egipcio', 'Turim', 'Italia')

INSERT INTO Obras(Id_obra, Codigo_museu, Titulo, Descricao, Colecao)
VALUES
(100, 10000, 'Paisagem em Aquarela', 'Uma bela paisagem natural pintada com técnicas de aquarela', 'Arte Comtemporanea'),
(101, 10002, 'Les Demoiselles d´Avignon', 'Uma pintura do periodo cubista', 'Arte moderna'),
(102, 10001, 'Retrato de uma Dama', 'Um retrato realista de uma dama da alta sociedade', 'Arte Classica'),
(103, 10001, 'As duas Fridas', 'As duas imagens de Frida', 'Autorretrato')

INSERT INTO Seguradora(Codigo_seguradora, Nome)
Values
(10, 'Seguradora Nacional'),
(11, 'Seguradora Infante'),
(12, 'Seguradora Guarda')

INSERT INTO Galerias(Codigo_galeria, Nome, Area, Tipo)
Values
(10, 'Galeria de Arte Moderna', 150, 'Contemporanea'),
(11, 'Galeria de Esculturas', 200, 'Classica'),
(12, 'Galeria de Arte Abstrata', 160, 'Abstrata'),
(13, 'Galeria de Fotografia', 60, 'Documental')


INSERT INTO Materiais(Id_material, Nome)
Values
(100, 'Guache'),
(101, 'Aquarela'),
(102, 'Oleo sobre tela'),
(103, 'Papel')

INSERT INTO Pessoas(Id_pessoa, Nif, Nome, Genero)
Values
(10000, 123456723, 'Maria Santos', 'F'),
(10001, 236590157, 'Rui Costa', 'M'),
(10002, 190132044, 'Ana Silva', 'F'),
(10003, 200901276, 'Mario Gomes', 'M')

INSERT INTO Artistas(Id_artista, Telefone, Pseudonimo, Nome, Apelido, Endereco_morada, Endereco_codigo_postal, Endereco_localidade)
Values
(1000, 961927712, 'Picasso', 'Pablo', 'Ruiz', 'Rua das Artes, 123', '5702-202', 'Cidade das Artes'),
(1001, 911867921, 'Da Vinci', 'Leonardo', 'di Ser Piero', 'Avenida dos Mestres, 129', '8129-901', 'Cidade das Pinturas'),
(1002, 931920455, 'Frida', 'Magdalena', 'Kahlo', 'Rua das Flores, 720', '9125-910', 'Cidade das Cores')

INSERT INTO Expor(Codigo_galeria, Id_obra, Id_expor, Data_expor, Data_fim_expor)
Values
(10, 100, 100, '2022/1/20', NULL),
(11, 102, 101, '2022/12/29', '2023/3/4'),
(10, 101, 102, '2020/2/1', '2023/5/23') 

INSERT INTO Tema_expor(Id_tema, Id_obra, Tema)
Values
(100, 101, 'O Cubismo'),
(101, 100, 'Natureza'),
(102, 102, 'Beleza Feminina')

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
(10001,10000, '2022/12/22','2022/12/22 18:00:00', 7, '2022/12/22 18:53:00'),
(10000,10000, '2022/10/1', '2022/10/1 10:30:00', 6.75, '2022/10/1 11:46:00'),
(10001,10000, '2023/2/20', '2023/2/20 14:00:00', 9, '2023/2/20 15:12:00'),
(10001,10001, '2023/1/12', '2023/1/12 17:00:00', 17.5, '2023/1/12 18:21:00'),
(10002, 10003, '2023/5/20', '2023/5/20 15:00:00', 22.3, '2023/5/20 16:51:00')

INSERT INTO Criar(Id_obra, Id_artista, Data_criar)
Values
(101, 1000, '1907/6/20'),
(103, 1002, '1939/10/21'),
(102, 1001, '1470/7/11')

INSERT INTO Comprar(Id_pessoa, Id_artista, Data_compra, Valor)
Values
(10000, 1000, '2023/1/2', 50000),
(10003, 1001, '2020/12/2', 80200),
(10002, 1002, '2021/10/30', 45000)

--(2) Resposta às perguntas do protocolo

--(2.1)
SELECT O.Titulo, C.Data_criar, O.Descricao
FROM Criar C, Obras O
WHERE C.Id_obra = O.Id_obra and
	C.Data_criar = (SELECT MIN(Data_criar)
						FROM Criar) 

--(2.2)
SELECT P.Nome, COUNT(DISTINCT V.Codigo_museu) as 'Museus visitados'
FROM Museus M, Pessoas P, Visitar V
WHERE P.Id_pessoa = V.Id_pessoa and
	  V.Codigo_museu = M.Codigo_museu 
GROUP BY P.Nome

--(2.3)
SELECT CONCAT(A.Nome, ' ',A.Apelido) as Nome, C.Valor
FROM Artistas A, Comprar C, Pessoas P
WHERE A.Id_artista = C.Id_artista and
		C.Id_pessoa = P.Id_pessoa and
		P.Genero = 'F'















-- Visualizar algumas tabelas 
SELECT * FROM Artistas
SELECT * FROM Comprar
SELECT * FROM Pessoas
SELECT * FROM Visitar

--Remocao da base de dados
USE MASTER
GO
ALTER DATABASE TP2BD SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
DROP DATABASE TP2BD
GO
