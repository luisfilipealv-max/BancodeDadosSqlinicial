CREATE DATABASE Banco_Academia_LLuis; --Criar banco de dados Banco_Academia

USE Banco_Academia_LLuis; --Selecionar banco de dados Banco_Academia

--comando para listar todos os bancos de dados existentes no servidor SQL Server
SELECT name AS NomeDoBanco
FROM sys.databases
ORDER BY name;

--comando para listar o banco de dados atual
SELECT DB_NAME() AS BancoAtual;

--Criando Tabelas Professores
CREATE TABLE Professores (
    IdProfessor INT PRIMARY KEY IDENTITY(1,1), --Identity para auto incrementar o IdProfessor
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE, -- Unique para não permitir emails duplicados
    Especialidade VARCHAR(100) NOT NULL,
);

CREATE TABLE Cursos(
    IdCurso INT PRIMARY KEY IDENTITY(1,1), --Identity para auto incrementar o IdCurso
    NomeCurso VARCHAR(100) NOT NULL UNIQUE, -- Unique para não permitir cursos duplicados
    CargaHoraria INT NOT NULL CHECK (CargaHoraria > 0 AND CargaHoraria <= 200), -- Check para validar a carga horária
    IdProfessor INT NOT NULL,
    Ativo BIT NOT NULL DEFAULT 1, -- Default para definir o valor padrão como 1 (ativo)

    CONSTRAINT FK_Cursos_Professores --CONSTRAINT para criar a chave estrangeira
    FOREIGN KEY (IdProfessor) REFERENCES Professores(IdProfessor)  
);

CREATE TABLE Alunos(
    IdAluno INT PRIMARY KEY IDENTITY(1,1), --Identity para auto incrementar o IdAluno
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE, -- Unique para não permitir emails duplicados
    Turma VARCHAR(50) NOT NULL,
    DataNascimento DATE NOT NULL,
    Ativo BIT NOT NULL CONSTRAINT DF_Alunos_Ativo DEFAULT 1, -- Default para definir o valor padrão como 1 (ativo)
);

CREATE TABLE Matriculas(
    IdMatricula INT IDENTITY(1,1) PRIMARY KEY, --Identity para auto incrementar o IdMatricula
    IdAluno INT NOT NULL,
    IdCurso INT NOT NULL,
    DataMatricula DATE NOT NULL CONSTRAINT DF_Matriculas_Data DEFAULT (CONVERT(DATE, GETDATE())), -- Default para definir a data atual como valor padrão
    NotaFinal DECIMAL(4,2) NULL CHECK (NotaFinal BETWEEN 0 AND 10), -- Check para validar a nota final
    StatusMatricula VARCHAR(20) NOT NULL CONSTRAINT DF_Matriculas_Status DEFAULT 'Ativa', -- Default para definir o valor padrão como 'Ativa'

    CONSTRAINT UQ_Matriculas_AlunoCurso UNIQUE (IdAluno, IdCurso), -- Unique para não permitir que um aluno se matricule no mesmo curso mais de uma vez
    CONSTRAINT FK_Matriculas_Alunos -- CONSTRAINT para criar a chave estrangeira
        FOREIGN KEY (IdAluno) REFERENCES Alunos(IdAluno), -- CONSTRAINT para criar a chave estrangeira
    CONSTRAINT FK_Matriculas_Cursos  -- CONSTRAINT para criar a chave estrangeira
        FOREIGN KEY (IdCurso) REFERENCES Cursos(IdCurso) --Para criar a chave estrangeira, referenciando a tabela Cursos
);

INSERT INTO Professores (Nome, Email, Especialidade)
VALUES
('Ana Martins',     'ana.martins@academia.com',    'Banco de Dados'),
('Carlos Ribeiro',  'carlos.ribeiro@academia.com', 'Programação'),
('Fernanda Lima',   'fernanda.lima@academia.com',  'Desenvolvimento Web'),
('Rafael Souza',    'rafael.souza@academia.com',   'Redes de Computadores');

INSERT INTO Cursos (NomeCurso, CargaHoraria, IdProfessor)
VALUES
('Banco de Dados Inicial', 40, 1),
('SQL Server Essencial',   36, 1),
('Lógica de Programação',  40, 2),
('JavaScript para Jovens', 32, 2),
('HTML e CSS',             30, 3),
('Fundamentos de Redes',   24, 4);

INSERT INTO Alunos (Nome, Email, Turma, DataNascimento)
VALUES
('Alice Pereira',   'alice.pereira@escola.com',   '2INFO-A', '2008-03-14'),
('Bruno Alves',     'bruno.alves@escola.com',     '2INFO-A', '2008-07-22'),
('Camila Rocha',    'camila.rocha@escola.com',    '2INFO-A', '2008-01-30'),
('Diego Santos',    'diego.santos@escola.com',    '2INFO-B', '2007-11-09'),
('Elisa Nunes',     'elisa.nunes@escola.com',     '2INFO-B', '2008-05-18'),
('Felipe Costa',    'felipe.costa@escola.com',    '2INFO-B', '2008-09-02'),
('Gabriela Melo',   'gabriela.melo@escola.com',   '2INFO-C', '2007-12-12'),
('Henrique Luz',    'henrique.luz@escola.com',    '2INFO-C', '2008-06-28'),
('Isabela Torres',  'isabela.torres@escola.com',  '2INFO-C', '2008-02-06'),
('João Mendes',     'joao.mendes@escola.com',     '2INFO-C', '2007-08-25');

INSERT INTO Matriculas (IdAluno, IdCurso, DataMatricula, NotaFinal, StatusMatricula)
VALUES
    (1, 1, '2026-02-03', 8.50, 'Concluída'),
    (1, 5, '2026-02-03', 9.00, 'Concluída'),
    (2, 1, '2026-02-03', 7.00, 'Concluída'),
    (2, 3, '2026-02-04', 8.00, 'Ativa'),
    (3, 2, '2026-02-04', 9.50, 'Concluída'),
    (3, 4, '2026-02-04', NULL, 'Ativa'),
    (4, 3, '2026-02-05', 6.50, 'Concluída'),
    (5, 5, '2026-02-05', 8.50, 'Concluída'),
    (6, 6, '2026-02-06', NULL, 'Ativa'),
    (7, 1, '2026-02-06', 7.50, 'Concluída'),
    (8, 2, '2026-02-07', 10.00, 'Concluída'),
    (8, 6, '2026-02-07', 8.00, 'Concluída'),
    (9, 4, '2026-02-08', NULL, 'Ativa'),
    (9, 5, '2026-02-08', 9.00, 'Concluída'),
    (10, 3, '2026-02-09', 7.00, 'Concluída'),
    (10, 2, '2026-02-09', NULL, 'Ativa');



SELECT * FROM Professores;
SELECT * FROM Cursos;
SELECT * FROM Alunos;
SELECT * FROM Matriculas;

SELECT nome FROM Professores;

SELECT nome AS nomeDOAluno, Turma As Sala FROM Alunos;

SELECT Nome,Turma
from Alunos ORDER BY Nome ASC;

SELECT TOP 5 Nome, Turma, DataNascimento
FROM Alunos
ORDER BY Nome ASC;

select * from Alunos;

SELECT Nome,Turma 
FROM Alunos
WHERE Turma = '2INFO-A'; 

--diferente de 
SELECT Nome, Turma 
FROM Alunos
WHERE Turma <> '2INFO-A'; -- ou seja, selecione os nomes e turmas dos alunos onde a turma seja deiferente de '2INFO-A'

-- and: as duas condições devem ser verdadeiras para que o registro seja retornado na consulta.
SELECT Nome, Turma, DataNascimento
FROM Alunos
WHERE Turma = '2INFO-A'
AND DataNascimento > '2008-01-01'; --ou seja, selecione os nomes, turmas e datas de nascimento dos alunos onde a turma seja igual a '2INDO-A' e a data de nascimento seja maior que '2008-01-01'

SELECT Nome, Turma 
FROM Alunos
WHERE Turma = '2INFO-A' or DataNascimento > '2008-01-01'; -- ou seja, selecione os nomes e turmas dos alunos onde a turma seja a '2INFO-A' ou a data de nascimento seja maior que '20080-01-01'


SELECT Nome, Turma      
FROM Alunos
WHERE Turma IN ('2INFO-A', '2INFO-B');

SELECT Nome, Email 
FROM Alunos
WHERE Nome LIKE '%es';


-- Atualizando dados com update
-- Update: Atualiza os dados de uma tabela. A SINTAXE BÁSICA É: UPDATE NOME_DA_TABELA SET NOME_DA_COLUNA = novo_valor WHERE condição;

-- Corrigir a turma de um aluno especifico
UPDATE alunos
SET Turma = '2INFO-B'
WHERE IdAluno =3; --Altera a turma do aluno com IdAluno igual a 3 para '2INFO-B'

SELECT * from Alunos;

-- Registrar uma nota e encerrar a matricula do aluno 2 no curso 3
UPdate Matriculas
SET NotaFinal = 8.75, StatusMatricula = 'Concluida'
WHERE IdAluno = 2 AND IdCurso = 3; -- Altera a nota final e o status da matricula do aluno com IdAluno igual a 2 e IDCurso igual a 3

SELECT * from Alunos;
SELECT * from Matriculas;
-- conferir a alteração da turma do aluno 3
select *
from Matriculas
WHERE Idaluno = 2 AND IdCurso = 3;




select * from Alunos;

-- desativar alunos da turma 2INFO-B
UPDATE Alunos 
set Ativo = 0
WHERE Turma = '2INFO-B'; -- altera o status de ativo para 0 (inativo) para todos os alunos da turma '2INFO-B'

select * from Alunos;

-- reativar os alunos da turma 2INFO-B
UPDATE Alunos 
SET Ativo = 1
WHERE Turma = '2INFO-B'-- Altere o status de ativo para 1 (Ativo) para todos os alunos da turma '2INFO-B'

-- excluindo registros com delete
-- delete: exclui registros de uma tabela. A sintaxe básica é: delete form nome_da_tabela WHERE condiçao;

INSERT INTO Alunos (Nome, Email, Turma, DataNascimento)
VALUES ('Aluno de Teste', 'teste.remover@escola.com', '2INFO-A', '2008-01-01') --Insere um aluno de teste para ser removido posteriormente 

SELECT * FROM Alunos
WHERE Email = 'teste.remover@escola.com'; -- Seleciona o aluno de teste para verificar se ele foi inserido corretamente

SELECT * FROM Alunos 

DELETE FROM Alunos
WHERE Email = 'teste.remover@escola.com'; -- Exclui o aluno de teste que foi inserido anteriormente

SELECT * FROM Alunos
WHERE Email = 'teste.remover@escola.com'; -- Selecionar o aluno de teste para verificar se ele foi inserido corretamente


-- funções de texto e data 


SELECT
    Nome,
    UPPER(Nome) AS NomeMaiusculo, -- Converte o nome para maiúsculo
    LOWER(Nome) AS NomeEmMinusculo, -- Converte o nome para minúsculo
    LEN(Nome) AS QuantidadeDeCaracteres, -- Retorna a quantidade de caracteres do nome
    CONCAT(Nome, ' - ', Turma) AS NomeETurma, -- Concatena o nome e a turma
    FORMAT(DataNascimento, 'dd/MM/yyyy') AS DataNascimento, -- Formata a data de nascimento
    DATEDIFF(YEAR, DataNascimento, GETDATE()) AS IdadeAproximada -- Calcula a idade do aluno
FROM Alunos;

select * FROM
-- FUNÇÕES DE CALCULO E AGRUPAMENTO

-- QUANTIDADE DE ALUNOS CADASTRADOS
SELECT COUNT(*) AS QuantidadeDeAlunos
FROM Alunos;

--Quantidade De Matriculas que ja possuem nota final
SELECT COUNT(NotaFinal) AS QuantidadesDeMatriculasComNota
FROM Matriculas;

-- Média, Maior e menor nota; OBS: Dados Nulos (null) nao sao considerados nos calculos
SELECT 
   AVG(NotaFinal) AS MediaDasNotas, --Media das notas
   MAX(NotaFinal) AS MaiorNota, --Maior nota
   MIN(NotaFinal) AS MenorNota -- menor nota
FROM Matriculas;

-- TROCA NULL POR UM TEXTO PARA EXIBIR O RESULTADO DE FORMA MAIS CLARA
SELECT 
IdMatricula, ISNULL(CONVERT(Varchar(10), NotaFinal), 'sem Nota') AS NotaFinal,
StatusMatricula
from Matriculas;


-- Group by e having: Agrupa os Registros por uma ou mais colunas e permite filtrar os grupos com base em uma condição.

--Quantos alunos estão matriculados em cada turma.
SELECT Turma, COUNT(*) AS QuantidadeDeAlunos
FROM Alunos
GROUP BY Turma
ORDER BY QuantidadeDeAlunos DESC;


SELECT IdCurso, COUNT(*) AS QuantidadesDeMatriculasComNota
FROM Matriculas
GROUP BY IdCurso
HAVING COUNT(*) >= 2
ORDER BY QuantidadesDeMatriculasComNota DESC;

-- RELACIONANDO TABELAS COM JOIN: permite combinar registros de duas ou mais tabelas com base em uma condição de correspondência.

SELECT
    a.Nome AS NomeDoAluno,
    c.NomeCurso AS NomeDoCurso,
    m.NotaFinal,
    m.StatusMatricula
FROM Matriculas AS m
INNER JOIN Alunos AS a
    ON m.IdAluno = a.IdAluno -- Relaciona a tabela matriculas com a tabela alunos
INNER JOIN Cursos AS c
    ON m.IdCurso = c.IdCurso -- Relaciona a tabela matriculas com a tabela cursos
ORDER BY a.Nome; -- Ordena o resultado pelo nome do aluno


--JOIN com 4 tabelas: retorna apenas os registros que tem correspodencia de n sei oq

--JOIN com 4 tabelas: retorna apenas os registros que tem correspondencia de n sei oq
SELECT
    a.Nome AS aluno,
    a.Turma,
    c.NomeCurso AS Cursos,
    p.Nome AS professor,
    m.NotaFinal,
    m.StatusMatricula
FROM Matriculas AS m
INNER JOIN Alunos AS a
    ON m.IdAluno = a.IdAluno -- relaciona a tabela matricula com a tabela alunos
INNER JOIN Cursos AS c
    ON m.IdCurso = c.IdCurso -- relaciona a tabela matricula com a tabela curso
INNER JOIN Professores AS p
    ON c.IdProfessor = p.IdProfessor -- relaciona a tabela matricula com a tabela professores
ORDER BY p.Nome, c.NomeCurso, a.Nome; -- Ordena o resultado pelo nome do professor, curso e aluno

-- left  retorna todos os registros dfa tabela a esquerda e os registros correspondentes da tabelas à diretia. se não houver correspondencia, os valores da tabeça à direitan serão nulos.

SELECT 
a.Nome As NomeDoAluno,
c.NomeCurso As NomeDoCurso,
m.NotaFinal,
m.StatusMatricula
FROM Alunos As a 
LEFT JOIN Matriculas As m
ON a.IdAluno = m.IdAluno -- Relaciona a tabela alunos com a tabela matricula
LEFT JOIN cursos As c
ON m.IdCurso = c.IdCurso -- Relaciona a tabela matricula com a tabela cursos ]
WHERE m.IdMatricula IS NULL -- filtra os alunos que não possuem matricula

-- Se a consulta nao retornar linhas, significa que todos os alunos possuem matricula em apenas um curso

-- JOIN com filtro e media por curso: retorna a media das notas finais por curso, considerando apenas os alunos que possuem matricula
SELECT 
c.NomeCurso As curso,
COUNT(m.IdMatricula) As TotalDeMatriculas,
AVG(m.NotaFinal) As mediaDoCurso
from Cursos As c
LEFT JOIN Matriculas As m
ON c.IdCurso = m.IdCurso -- relaciona a tabela cursos com atabela matriculas
WHERE m.NotaFinal IS NOT NULL --filtra apenas as matriculas que possuem nota final 
GROUP BY c.NomeCurso -- Agrupa o resultado pelo nome do curso 
ORDER BY c.NomeCurso; --Ordena o resultado pelo nome do curso

-- ERRO: o email já foi usado por Alice
INSERT INTO alunos (Nome, Email, Turma)
Values ('Outra Alice', 'alice.pereira@escola.com', '2INFOO-A');


-- Erro: não existe aluno de ID 999
INSERT INTO Matriculas (IdAluno, IdCurso, NotaFinal)
Values (999, 1, 00);


-- Erro: a nota não pode ser maior que 10
UPDATE Matriculas
SET NotaFinal = 10
WHERE IdMatricula = 1;