
SELECT name AS banco_de_dados
FROM sys.databases
ORDER BY name;
GO


USE dbLuis;
GO


SELECT name
FROM sys.tables;
GO


SELECT name AS tabela
FROM sys.tables
ORDER BY name;
GO


SELECT *
FROM jogadores;
GO


SELECT *
FROM TelefonesJogadores;
GO


SELECT nome_completo, apelido, turma
FROM jogadores;
GO
