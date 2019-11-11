/* 
12) Construir uma view denominada JOGADOR_NEW que contenha a seguinte informa��o: ID_JOGADOR;
NOME; IDADE; NOME_CLUBE; DESCRICAO_POSICAO, NOME_LIGA; CIDADE_CLUBE; ANO
DE FUNDACAO
*/
CREATE VIEW JOGADOR_NEW
AS SELECT 
    j.ID_JOGADOR, j.NOME, j.IDADE, c.NOME as NOME_CLUBE, 
    p.DESC_POSICAO as DESCRICAO_POSICAO, l.NOME as NOME_LIGA, 
    c.CIDADE as CIDADE_CLUBE, c.ANO_FUNDACAO  
FROM JOGADOR j, CLUBE c, LIGA l, POSICAO p
WHERE 
    j.ID_CLUBE = c.ID_CLUBE AND 
    c.ID_LIGA = l.ID_LIGA AND 
    j.ID_POSICAO = p.ID_POSICAO;

/* 
13) Listar todos os defesas direitos da Segunda Liga 
*/
SELECT j.ID_JOGADOR, j.NOME
    FROM jogador j, posicao p, clube c, liga l 
    WHERE 
        j.ID_POSICAO = p.ID_POSICAO AND 
        j.ID_CLUBE = c.ID_CLUBE AND 
        c.ID_LIGA = l.ID_LIGA AND 
        p.DESC_POSICAO = 'Defesa Direito' AND 
        l.NOME = 'II Liga'; 

/* 
14) Listar todos os jogadores com menos de 27 anos cuja posi��o � Trinco e que n�o jogam na II Liga 
*/
SELECT j.ID_JOGADOR, j.NOME, j.IDADE, l.NOME
    FROM jogador j, posicao p, clube c, liga l 
    WHERE 
        j.ID_POSICAO = p.ID_POSICAO AND 
        j.ID_CLUBE = c.ID_CLUBE AND 
        c.ID_LIGA = l.ID_LIGA AND 
        p.DESC_POSICAO = 'Trinco' AND 
        NOT l.NOME = 'II Liga' AND 
        j.IDADE < 27; 

/* 
15) Construir uma view denominada TREINADOR_NEW que contenha a seguinte informa��o: ID_TREINADOR;
NOME_TREINADOR; NOME_CLUBE; DESCRICAO_DO_CARGO 
*/
CREATE VIEW TREINADOR_NEW 
AS SELECT 
    t.ID_TREINADOR, t.NOME AS NOME_TREINADOR, 
    c.NOME as NOME_CLUBE, ca.DESC_CARGO as DESCRICAO_CARGO 
    FROM treinador t, clube c, cargo ca 
    WHERE 
        t.ID_CLUBE = c.ID_CLUBE AND 
        t.ID_CARGO = ca.ID_CARGO; 

/* 
16) Listar todos o nome do treinador, nome do clube, cargo do treinador, cidade do clube e ano de funda��o
de todos os clubes fundados ap�s 1945.
*/ 
SELECT t.NOME, c.NOME, ca.DESC_CARGO, c.CIDADE, c.ANO_FUNDACAO 
    FROM treinador t, cargo ca, clube c 
    WHERE 
        t.ID_CARGO = ca.ID_CARGO AND 
        t.ID_CLUBE = c.ID_CLUBE AND 
        c.ANO_FUNDACAO > 1945;

/*
17) Criar uma sequ�ncia denominada JOGID_SQ atrav�s da interface do SQLDeveloper que seja incremental.
Comece em 1000, aumente apenas uma unidade e o limite dever� ser 99999.
*/
CREATE SEQUENCE JOGID_SQ
    START WITH 1000
    INCREMENT BY 1
    MINVALUE 0
    MAXVALUE 99999
    NOCACHE
    NOCYCLE;
    
    /* NOCACHE , pois se o sistema for abaixo abruptamente s�o perdidos os valores em cache (e considero 
    que id's tenham muita import�ncia) e NOCYCLE, porque os valores de ID n�o dever�o ser c�clicos 
    e, consequentemente, repetir-se.*/

/*
18) Criar um trigger denominado JOGID_TRIG que para antes de cada insert na tabela de JOGADORES
crie o JOGADOR_ID de forma autom�tica utilizando a sequ�ncia criada anteriormente.
*/
CREATE OR REPLACE TRIGGER JOGID_TRIG
    BEFORE INSERT ON JOGADOR
    FOR EACH ROW
    BEGIN
        IF :NEW.ID_JOGADOR IS NULL THEN
            :NEW.ID_JOGADOR := JOGID_SQ.nextval;
        END IF;
    END;

/* 
19) Criar o script te introdu��o de 3 Jogadores com nomes, clubes, posi��es e idades aleat�rios, mas cujo o
ID seja criado utilizando o trigger e sequ�ncias criados.
*/
INSERT ALL
   INTO JOGADOR (NOME,IDADE,ID_CIDADE,ID_POSICAO,ID_CLUBE) VALUES ('Joaquim Pereira',21,'Braga',9,5)
   INTO JOGADOR (NOME,IDADE,ID_CIDADE,ID_POSICAO,ID_CLUBE) VALUES ('Jo�o Almeida',19,'Porto',1,36)
   INTO JOGADOR (NOME,IDADE,ID_CIDADE,ID_POSICAO,ID_CLUBE) VALUES ('Jos� Ningu�m',20,'Lisboa',8,51)
SELECT 1 FROM DUAL;
