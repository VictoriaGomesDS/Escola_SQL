------------------------------------------
--DDL statement for table 'HR' database--
------------------------------------------

-- Drop the tables in case they exist

DROP TABLE netflix; 
DROP TABLE amazon_prime_titles;
DROP TABLE disney_plus_titles;


-- Create the tables

CREATE TABLE netflix_titles (
                          show_id CHAR(9) NOT NULL,
                          type VARCHAR(15) NOT NULL,
                          title VARCHAR(255) NOT NULL,
                          director VARCHAR(255),
                          actors TEXT,
                          country TEXT,
                          date_added VARCHAR(255),
                          release_year DATE,
                          rating CHAR(10), 
                          duration CHAR(15),
                          listed_in VARCHAR,
                          description TEXT,
                          PRIMARY KEY (show_id)
                        );


-- Somos uma empresa de Streaming que conseguiu um contrato para retransmitir dos nossos parceiros
-- netflix, disney_plus e amazon_prime os seus conteúdos. A equipe de dados solicitou ao time diversas
--entregas que precisam ser realizadas para ajustes na base assim como as regras de negócio.


Opcional-Avançado. Ao invez de normalizar as outras tabelas como solicitado nas questões você pode
realizar as CTE (Common Table Expressions), o WITH, onde você criar uma tabela em memória
com as trasformações e chamar elas para a resolução dos exercícios. Segue exemplo:

CREATE TABLE  tabela_normatizada AS ( -- criando tabelas 

        WITH tabela_1 AS (

                SELECT *
                FROM netflix_titles
        )

select * FROM tabela_1

)

-- OR

WITH cast_table_split AS ( -- tabela em memória

SELECT n1.show_id, unnest(string_to_array(n1.cast, ',')) as "split_cast" -- Transforma uma linha em múltiplas colunas
FROM netflix_titles as n1 )

select * FROM cast_table_split -- regra de negócio



------------------------------------------------------------------------------------------
----------------------------------- EXERCÍCIOS -------------------------------------------
------------------------------------------------------------------------------------------


1. A base possui diversos valores nulos. Preencha nas colunas onde os valores 
são nulls com 'NAN'.


-- RESOLUÇÃO

-- estudando um pouco como os dados estao dispostos.
SELECT * FROM netflix_titles LIMIT 10;

-- Deletando caso exista.
DROP TABLE tabela_sem_null;

-- criando a tabela com os campos vazios.
CREATE TABLE tabela_sem_null AS (
  
  WITH netflix_titles AS (
      SELECT
          show_id,
          netflix_titles.type AS type_, -- acrescentei o _ a alguns nomes de tabelas para evitar conflitos de funções.
          title,
          CASE 
              WHEN director = ''
              THEN 'NAN'
              ELSE director
          END AS director,
          CASE	
              WHEN netflix_titles.cast = ''
              THEN 'NAN'
              ELSE netflix_titles.cast
          END AS cast_,
          CASE
              WHEN country = ''
              THEN 'NAN'
              ELSE country
          END AS country,
          CASE
              WHEN date_added = ''
              THEN 'NAN'
              ELSE date_added
          END AS date_added,
          netflix_titles.release_year,
          CASE 
              WHEN rating = ''
              THEN 'NAN'
              ELSE rating
          END AS rating,
          CASE
              WHEN duration = ''
              THEN 'NAN'
              ELSE duration
          END AS duration,
          listed_in,
          description
      FROM netflix_titles
  	)
  
select * FROM netflix_titles
)



3. Normalize a coluna CAST criando uma nova tabela 'cast_table' de modo que tenhamos separadamente, ou seja, 
uma coluna com o nome do elenco de cada filme. Exemplo:

Linha: n1 joao, maria, roberto
coluna:
id CAST 
n1 joao
n1 maria
n1 roberto


--RESOLUÇÃO

SELECT * FROM tabela_sem_null LIMIT 10;

CREATE TABLE cast_table AS (	
  
	WITH tabela_sem_null AS (
		select 
			tabela_sem_null.show_id,
			UNNEST(STRING_TO_ARRAY(tabela_sem_null.cast_,',')) as cast_name
		from tabela_sem_null
    )
  
SELECT * FROM tabela_sem_null
)
-- A função UNNEST foi usada para expandir uma array para um conjunto de linhas respeitando o mesmo id.

SELECT * FROM cast_table LIMIT 10;
-- Aqui vemos que deu tudo certo e a nova tabela foi gerada.



4. Normalize a coluna listed_in criando uma nova tabela 'genre_table' de modo que tenhamos separadamente os gêneros
de cada programação. Exemplo:

Linha: n1 Ação, Aventura, Comédia
coluna:
n1 Ação
n1 Comédia
n1 Aventura


-- RESOLUÇÃO

SELECT * FROM tabela_sem_null LIMIT 10;

CREATE TABLE genre_table AS (	
  
	WITH tabela_sem_null AS (
		select 
			tabela_sem_null.show_id,
			UNNEST(STRING_TO_ARRAY(tabela_sem_null.listed_in,',')) as genre
		from tabela_sem_null
    )
  
SELECT * FROM tabela_sem_null
)
-- A função UNNEST foi usada para expandir uma array para um conjunto de linhas respeitando o mesmo id.



5. Normalize a coluna date_added em uma nova base 'date_table' e construa as seguintes colunas:

- coluna day: DD
- coluna mouth: MM
- coluna year: YY
- coluna iso_date_1: YYYY-MM-DD
- coluna iso_date_2: YYYY/MM/DD
- coluna iso_date_3: YYMMDD
- coluna iso_date_4: YYYYMMDD


-- RESOLUÇÃO

SELECT date_added FROM tabela_sem_null LIMIT 10;

CREATE TABLE date_table AS (	
  
	WITH tabela_sem_null AS (
      
        select 
            tabela_sem_null.show_id,
            tabela_sem_null.date_added,
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN EXTRACT(DAY FROM tabela_sem_null.date_added::DATE)
                ELSE 'NAN'
            END AS day, -- coluna day: DD.
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN EXTRACT(MONTH FROM tabela_sem_null.date_added::DATE)
                ELSE 'NAN'
            END AS month_num, -- coluna mouth: MM.
            TRIM(split_part(tabela_sem_null.date_added,' ',1))
            as mes_txt, -- coluna mouth: MM.
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN EXTRACT(YEAR FROM tabela_sem_null.date_added::DATE)
                ELSE 'NAN'
            END AS YEAR,
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yyyy-mm-dd')
                ELSE 'NAN'
            END AS iso_date_1, -- coluna iso_date_1: YYYY-MM-DD.
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yyyy/mm/dd')
                ELSE 'NAN'
            END AS iso_date_2, -- coluna iso_date_2: YYYY/MM/DD.
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yymmdd')
                ELSE 'NAN'
            END AS iso_date_3, -- coluna iso_date_3: YYMMDD.
            CASE
                WHEN tabela_sem_null.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yyyymmdd')
                ELSE 'NAN'
            END AS iso_date_4 -- coluna iso_date_4: YYYYMMDD.
        from tabela_sem_null
	)
  
SELECT * FROM tabela_sem_null      
)      

SELECT * FROM date_table;
-- Aqui vemos que deu tudo certo e a nova tabela foi gerada.



6. Normalize a coluna duration e construa uma nova base 'time_table' e faça as seguintes conversões.
- Converta a coluna duration para horas e crie a coluna hours hh. Obs. A média de cada 
season TV SHOW é 10 horas, assim também converta para horas
- Converta todas as horas para minutos e armazena na coluna minutes mm.

-- RESOLUÇÃO

-- Conferindo os dados na tabela geral.
SELECT duration FROM tabela_sem_null LIMIT 10;

-- Conferindo as possíveis formas de texto apresentadas.
SELECT DISTINCT (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] FROM tabela_sem_null;

-- Criando a tabela.
CREATE TABLE time_table_aux AS (
  
    -- Crio uma tabela auxiliar para tirarmos a quantidade de horas de cada obra
    --	respeitando a regra de negócio.
    WITH tabela_sem_null AS (
  
        SELECT
            tabela_sem_null.show_id,
            CASE
                WHEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] = 'Seasons' 
                    OR (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] = 'Season' 
                THEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[1]::FLOAT * 10 
                WHEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] = 'min'
                THEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[1]::FLOAT / 60 
            END AS hours
        FROM tabela_sem_null
    )
  
SELECT * FROM tabela_sem_null
)

-- vemos que a tabela foi criada corretamente.
SELECT * FROM time_table_aux;

-- Aqui criamos a tabela final.
CREATE TABLE time_table AS (
  
-- Aqui utilizo a tabela auxiliar e puxo seus dados através do LEFT JOINtabela_sem_null.
-- Aproveitando os dados da mesma e também os usando para calcular os minutos.
    WITH tabela_sem_null AS (  
        SELECT 
              tabela_sem_null.show_id,
              tabela_sem_null.duration,
              time_table_aux.hours AS time_hours,
              CASE
                  WHEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] = 'Seasons' 
                      OR (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] = 'Season' 
              THEN time_table_aux.hours::FLOAT * 60
              WHEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[2] = 'min'
              THEN (STRING_TO_ARRAY(tabela_sem_null.duration,' '))[1]::FLOAT 
              END AS minuts
          FROM tabela_sem_null
          LEFT JOIN time_table_aux
              ON tabela_sem_null.show_id = time_table_aux.show_id
	)
    
SELECT * FROM tabela_sem_null
)

-- Podemos ver que a tabela final foi criada corretamente.
SELECT * FROM time_table;

-- Com a tabela feita podemos dropar a auxiliar.
DROP TABLE time_table_aux;



7. Normalize a coluna country criando uma nova tabela 'country_table' de modo que tenhamos separadamente 
uma coluna com o nome do país de cada filme.

-- RESOLUÇÃO

SELECT * FROM tabela_sem_null LIMIT 10;
SELECT country FROM tabela_sem_null LIMIT 10;

CREATE TABLE country_table AS (	
  
	WITH tabela_sem_null AS (
		select 
			tabela_sem_null.show_id,
			UNNEST(STRING_TO_ARRAY(tabela_sem_null.country,',')) as country
		from tabela_sem_null
    )
  
SELECT * FROM tabela_sem_null
)
-- A função UNNEST foi usada para expandir uma array para um conjunto de linhas respeitando o mesmo id.

SELECT * FROM country_table LIMIT 15;

------------------------------Questoes de negócio -----------------------------------------------------

8. Qual o filme de duração máxima em minutos ?
-- O filme Black Mirror: Bandersnatch, de código s4254, com aproximadamente 312 minutos.

SELECT * FROM tabela_sem_null;
SELECT DISTINCT type_ FROM tabela_sem_null;
SELECT * FROM time_table;

SELECT
	time_table.show_id,
    tabela_sem_null.title,
	time_table.minuts AS maior_minutagem
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE time_table.minuts = (SELECT MAX(time_table.minuts) 
                           FROM time_table 
                           LEFT JOIN tabela_sem_null
                               ON time_table.show_id = tabela_sem_null.show_id
                           WHERE tabela_sem_null.type_ = 'Movie');



9.  Qual o filme de duraçã mínima em minutos ?
-- O filme Silent, de código s3778, com aproximadamente 3 minutos.

SELECT
	time_table.show_id,
    tabela_sem_null.title,
	time_table.minuts AS menor_minutagem
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE time_table.minuts = (SELECT MIN(time_table.minuts) 
                           FROM time_table 
                           LEFT JOIN tabela_sem_null
                               ON time_table.show_id = tabela_sem_null.show_id
                           WHERE tabela_sem_null.type_ = 'Movie');



10. Qual a série de duração máxima em minutos ?
-- A serie Grey's Anatomy, de código s549, com aproximadamente 10200 minutos, cerca de 17 temporadas.

SELECT * FROM tabela_sem_null;
SELECT DISTINCT type_ FROM tabela_sem_null;
SELECT * FROM time_table;

SELECT
	time_table.show_id,
    tabela_sem_null.title,
	time_table.minuts AS maior_minutagem
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE time_table.minuts = (SELECT MAX(time_table.minuts) 
                           FROM time_table 
                           LEFT JOIN tabela_sem_null
                               ON time_table.show_id = tabela_sem_null.show_id
                           WHERE tabela_sem_null.type_ = 'TV Show');


11. Qual a série de duração mínima em minutos ?
-- Gerou uma lista com 1793 series com 600 minutos, 10 horas, que 
-- 	dentro das regras de negócio corresponde a aproximadamente uma temporada.

SELECT
	time_table.show_id,
    tabela_sem_null.title,
	time_table.minuts AS menor_minutagem
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE time_table.minuts = (SELECT MIN(time_table.minuts) 
                           FROM time_table 
                           LEFT JOIN tabela_sem_null
                               ON time_table.show_id = tabela_sem_null.show_id
                           WHERE tabela_sem_null.type_ = 'TV Show');
                           
/* Somente a contagem da lista de series que satisfazem os filtros

SELECT
	COUNT(time_table.show_id) AS contagem
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE time_table.minuts = (SELECT MIN(time_table.minuts) 
                           FROM time_table 
                           LEFT JOIN tabela_sem_null
                               ON time_table.show_id = tabela_sem_null.show_id
                           WHERE tabela_sem_null.type_ = 'TV Show');
*/


12. Qual a média de tempo de duração dos filmes?
-- A média de tempo de duração das series é de aproximadamente 99.58 minutos, 1.68 horas

SELECT
	AVG(time_table.minuts) AS media_duracao_min
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE tabela_sem_null.type_ = 'Movie';



13. Qual a média de tempo de duração das series?
-- A média de tempo de duração das series é de aproximadamente 1059 minutos, 1.8 temporadas

SELECT
	AVG(time_table.minuts) AS media_duracao_min
FROM time_table
LEFT JOIN tabela_sem_null
	ON time_table.show_id = tabela_sem_null.show_id
WHERE tabela_sem_null.type_ = 'TV Show';



14. Qual a lista de filmes o ator Leonardo DiCaprio participa?
-- A query abaixo gera uma lista com 9 filmes.

SELECT 
	*
FROM tabela_sem_null
WHERE tabela_sem_null.cast_ LIKE '%Leonardo DiCaprio%' 
AND tabela_sem_null.type_ = 'Movie';          

/* Apenas a contagem 
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.cast_ LIKE '%Leonardo DiCaprio%' 
AND tabela_sem_null.type_ = 'Movie'
*/


15. Quantas vezes o ator Tom Hanks apareceu nas telas do netflix, ou seja, tanto série quanto filmes?
-- O ator Tom Hanks aparece em 8 obras

SELECT 
	*
FROM tabela_sem_null
WHERE tabela_sem_null.cast_ LIKE '%Tom Hanks%';

-- Apenas a contagem 
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.cast_ LIKE '%Tom Hanks%';



16. Quantas produções séries e filmes brasileiras já foram ao ar no netflix?
-- Há 97 produções com referências brasileiras na netflix
-- Há 77 produções somente brasileiras na netflix

SELECT * FROM tabela_sem_null;

-- Contagem de obras com presença brasileira
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.country LIKE '%Brazil%';

-- Contagem de obras SOMENTE com presença brasileira
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.country = 'Brazil';



17. Quantos filmes americanos já foram para o ar no netflix?
-- Há 3690 produções com referências norte americanas na netflix
-- Há 2818 produções somente norte americana na netflix

-- Contagem de obras com presença norte americana
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.country LIKE '%United States%'

-- Contagem de obras SOMENTE com presença norte americana
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.country = 'United States';



18. Crie uma nova coluna com o nome last_name_director com uma nova formatação para o nome dos diretores, por exemplo.
João Roberto para Roberto, João.

-- É necessário normalizar as tabelas para que consiguemos fazer da forma correta,
--	tendo em vista a proposta do desafio de normalizar elementos da tabela geral bruta netflix_title

SELECT * FROM tabela_sem_null;

WITH tab_aux AS (
    SELECT 
        tabela_sem_null.show_id AS show_id,
        TRIM(UNNEST(STRING_TO_ARRAY(tabela_sem_null.director,','))) AS nome_comp,
		STRING_TO_ARRAY(TRIM(UNNEST(STRING_TO_ARRAY(tabela_sem_null.director,','))),' ') AS array_nome
    FROM tabela_sem_null
)

SELECT
    tabela_sem_null.show_id,
    tab_aux.nome_comp AS nome_completo,
    tab_aux.array_nome[1] AS primeiro_nome,
    tab_aux.array_nome[array_length(tab_aux.array_nome,1)] AS ultimo_nome,
    tab_aux.array_nome[array_length(tab_aux.array_nome,1)] || ', ' || tab_aux.array_nome[1] AS nome_format
FROM tabela_sem_null
LEFT JOIN tab_aux
	ON tabela_sem_null.show_id = tab_aux.show_id
    


19. Procure a lista de conteúdos que tenha como temática a segunda guerra mundial (WWII)?
-- Há 6 obras com a temática segunda guerra mundial.

SELECT 
	*
FROM tabela_sem_null
WHERE tabela_sem_null.description LIKE '%WWII%'

/* Contagem
SELECT 
	COUNT(*) AS contagem
FROM tabela_sem_null
WHERE tabela_sem_null.description LIKE '%WWII%'
*/


20. Conte o número de produções dos países que apresentaram conteúdos no netflix?

SELECT 
	country_table.country,
	COUNT(*) AS numero_producoes
FROM tabela_sem_null
LEFT JOIN country_table
	ON tabela_sem_null.show_id = country_table.show_id
GROUP BY country_table.country
ORDER BY numero_producoes DESC;



