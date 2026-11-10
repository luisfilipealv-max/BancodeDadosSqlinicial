SELECT name as Banco_De_Dados --Selecionando o nome dos bancos de dados
from sys.databases --Selecionando todos os bancos de dados existentes no servidor
Order by name; --Ordenando todos os banco de. dado

Use dbLuis;
GO

Select name From sys.tables;
GO

CREATE TABLE Estudantes(
    IdEstudante INT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Turma VARCHAR(50) NOT NULL,
    Apelido VARCHAR(30)
);

CREATE TABLE Videos(
    IdVideo INT PRIMARY KEY,
    Titulo VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255) NOT NULL,
    data_publicacao DATE NOT NULL,
    Duracao TIME NOT NULL,
    MATRICULA_ESTUDANTE INT NOT NULL,
    FOREIGN KEY (MATRICULA_ESTUDANTE) REFERENCES Estudantes(IdEstudante)
)

INSERT INTO Estudantes (IdEstudante, Nome, Turma, Apelido)
VALUES
(1, 'Jair Bolsonaro', '2A', 'Bolsonaro'),
(2, 'Neymar do Santos Do Nascimento Junior', '2A', 'Neymar Jr'),
(3, 'Luis Inacio da Silva', '2A', 'Lule'),
(4, 'Victor da Silva do Nascimento', '2A', 'Vitão'),
(5, 'Luis Filipe Alves', '2A', 'Luisao'),
(6, 'Lucas oliveira Tofaneli', '2A', 'Luquinhas'),
(7, 'Ruan Henrique Faria', '2A', 'Ruansao'),
(8, 'Marco Tulio', '2A', 'Authentic Games'),
(9, 'Valentina da Silva do Nascimento', '2A', 'Vavá'),
(10, 'Vinicius da Silva do Nascimento', '2A', 'Vini')

select * from Estudantes;


    UPDATE Estudantes 
    SET Apelido = 'Aranha'
    WHERE IdEstudante =1;

    Select * from Estudantes;

    -- BUSCAR DADOS DE UMA TABELA COM INNER JOIN - INNER JOIN É USADO PARA COMBINAR LINHAS DE DUAS OU MAIS TABELAS

SELECT --Select responsavel por selecionar os dados da tabelas videos e estudantes

v.Titulo, -- v.Titulo seleciona o nome do estudande da tabela Estudantes e renomeia a coluna como Autor

e.Nome AS Autor, --e.Nome seleciona o nome do estudante da tabela Estudantes e renomeia a coluna como Autor

e.Apelido AS Heroi, -- e.Apelido seleciona o apelido do estudante da tabela Estudantes e renomeia a coluna como Heroi 

v.Duracao -- v.Duracao seleciona a duracao do video da tabela Videos

FROM Videos AS v -- FROM Videos AS v seleciona a tabela Videos e renomeia como v

INNER JOIN Estudantes AS e -- INNER JOIN Estudandes AS e seleciona AS e selecion    a Estudantes e renomeia como e

ON v.MATRICULA_ESTUDANTE = e.IdEstudante;