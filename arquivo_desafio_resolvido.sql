------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

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
                          cast TEXT,
                          country TEXT,
                          date_added VARCHAR(255),
                          release_year DATE,
                          rating CHAR(10), 
                          duration CHAR(15),
                          listed_in VARCHAR,
                          description TEXT,
                          PRIMARY KEY (show_id)
                        );

CREATE TABLE amazon_prime_titles (
                          show_id CHAR(9) NOT NULL,
                          type VARCHAR(15) NOT NULL,
                          title VARCHAR(255) NOT NULL,
                          director VARCHAR(255),
                          cast TEXT,
                          country TEXT,
                          date_added VARCHAR(255),
                          release_year DATE,
                          rating CHAR(10), 
                          duration CHAR(15),
                          listed_in VARCHAR,
                          description TEXT,
                          PRIMARY KEY (show_id)
                        );

CREATE TABLE disney_plus_titles (
                          show_id CHAR(9) NOT NULL,
                          type VARCHAR(15) NOT NULL,
                          title VARCHAR(255) NOT NULL,
                          director VARCHAR(255),
                          cast TEXT,
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
--entregas que precisam ser realizadas para os ajustes na base assim como as regras de negócio.


1. Unifique as bases de dados do netflix, disney_plus e amazon_prime. Escolha uma das duas opcoes abaixo.

 - 1 Opcao mude o campo show_id das respectivas bases de modo que não tenhamos repeticao nos ids.

-  2 Opcao voce pode construir uma nova coluna que represente o ID do tabelao. 


-- Começo visualizando as tabelas.
SELECT * FROM public.amazon_prime_titles;

SELECT * FROM public.disney_plus_titles;

SELECT * FROM public.netflix_titles;


-- Entao conferindo que as tabelas possuem a mesma estrutura, crio uma nova tabela, chamada 'tabelao',
--	com a unificação dos dados de todas.
CREATE TABLE tabelao AS (
	
	WITH tabelao AS (
		SELECT * 
		FROM public.amazon_prime_titles
		UNION ALL
		SELECT * 
		FROM public.disney_plus_titles
		UNION ALL
		SELECT * 
		FROM public.netflix_titles
	)
	
SELECT * FROM tabelao
)


-- Então crio minha nova base coluna identificadora que represente o novo id do tabelao.
CREATE TABLE tabelao2 AS (
	
	WITH aux_tab AS (
		SELECT
			*,
			ROW_NUMBER () OVER (ORDER BY tabelao.show_id) AS numeracao,
			SUBSTRING(REPLACE(tabelao.show_id,'s','n'),1,1) || ROW_NUMBER () OVER (ORDER BY tabelao.show_id) AS new_id
		FROM public.tabelao
	)

SELECT * FROM aux_tab
)

-- Visualizamos e conferimos que a base foi criada corretamente.
SELECT * FROM public.tabelao2

-- Entao podemos dropar a base antiga.
DROP TABLE public.tabelao




2. Normalize as colunas do tabelao.
- cast, country, listed_in, date_added, duration

-- Para armazenar as tabelas das colunas normatizadas criei um novo Schema 'normat'.
-- Para fazer o exercício, pulei para o exercício 4 para retirar os espaços e substituí-los por 'NAN'.

------------------------------ NORMALIZAÇÃO DA COLUNA CAST ------------------------------

-- Visualizo como os dados da coluna cast estão dispostos.
SELECT 
	tabelao_sn.new_id, 
	tabelao_sn.cast 
FROM public.tabelao_sn LIMIT 10;


-- Entao partimos para a normalização dos dados da coluna cast.
CREATE TABLE normat.cast_table AS (	
  
	WITH cast_table AS (
		SELECT 
			tabelao_sn.new_id,
			UNNEST(STRING_TO_ARRAY(tabelao_sn.cast,',')) as cast
		FROM public.tabelao_sn
    )
  
SELECT * FROM cast_table
)
-- A função UNNEST foi usada para expandir uma array para um conjunto de linhas respeitando o mesmo id.


------------------------------ NORMALIZAÇÃO DA COLUNA COUNTRY ------------------------------

-- Visualizo como os dados da coluna country estão dispostos.
SELECT 
	tabelao_sn.new_id, 
	tabelao_sn.country
FROM public.tabelao_sn LIMIT 10;


-- Entao partimos para a normalização dos dados da coluna country.
CREATE TABLE normat.country_table AS (	
  
	WITH country_table AS (
		SELECT 
			tabelao_sn.new_id,
			UNNEST(STRING_TO_ARRAY(tabelao_sn.country,',')) as country
		FROM public.tabelao_sn
    )
  
SELECT * FROM country_table
)
-- A função UNNEST foi usada para expandir uma array para um conjunto de linhas respeitando o mesmo id.


------------------------------ NORMALIZAÇÃO DA COLUNA LISTED_IN ------------------------------

-- Visualizo como os dados da coluna listed_in estão dispostos.
SELECT 
	tabelao_sn.new_id, 
	tabelao_sn.listed_in 
FROM public.tabelao_sn LIMIT 10;


-- Entao partimos para a normalização dos dados da coluna listed_in.
CREATE TABLE normat.listed_in_table AS (	
  
	WITH listed_in_table AS (
		SELECT 
			tabelao_sn.new_id,
			UNNEST(STRING_TO_ARRAY(tabelao_sn.listed_in,',')) as listed
		FROM public.tabelao_sn
    )
  
SELECT * FROM listed_in_table
)
-- A função UNNEST foi usada para expandir uma array para um conjunto de linhas respeitando o mesmo id.


------------------------------ NORMALIZAÇÃO DA COLUNA DATE_ADDED ------------------------------

-- Visualizo como os dados da coluna date_added estão dispostos.
SELECT 
	tabelao_sn.new_id, 
	tabelao_sn.date_added 
FROM public.tabelao_sn LIMIT 10;


-- Entao partimos para a normalização dos dados da coluna date_added.  
CREATE TABLE normat.date_table AS (	
  
	WITH date_tables AS (
        SELECT 
            tabelao_sn.new_id,
            tabelao_sn.date_added,
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN EXTRACT(DAY FROM tabelao_sn.date_added::DATE)
                ELSE 'NAN'
            END AS day, -- coluna day: DD.
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN EXTRACT(MONTH FROM tabelao_sn.date_added::DATE)
                ELSE 'NAN'
            END AS month_num, -- coluna mouth: MM.
            TRIM(split_part(tabelao_sn.date_added,' ',1))
            AS mes_txt, -- coluna mouth: MM.
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN EXTRACT(YEAR FROM tabelao_sn.date_added::DATE)
                ELSE 'NAN'
            END AS YEAR,
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yyyy-mm-dd')
                ELSE 'NAN'
            END AS iso_date_1, -- coluna iso_date_1: YYYY-MM-DD.
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yyyy/mm/dd')
                ELSE 'NAN'
            END AS iso_date_2, -- coluna iso_date_2: YYYY/MM/DD.
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yymmdd')
                ELSE 'NAN'
            END AS iso_date_3, -- coluna iso_date_3: YYMMDD.
            CASE
                WHEN tabelao_sn.date_added <> 'NAN'
                THEN TO_CHAR(CAST(date_added AS DATE), 'yyyymmdd')
                ELSE 'NAN'
            END AS iso_date_4 -- coluna iso_date_4: YYYYMMDD.
        FROM public.tabelao_sn
	)
  
SELECT * FROM date_tables      
) 


------------------------------ NORMALIZAÇÃO DA COLUNA DIRECTOR ------------------------------

-- Visualizo como os dados da coluna director estão dispostos.
SELECT 
	tabelao_sn.new_id, 
	tabelao_sn.director 
FROM public.tabelao_sn LIMIT 10;



CREATE TABLE normat.directors_table AS (
	
	WITH tab_aux AS (
    SELECT 
        tabelao_sn.new_id AS new_id,
        STRING_TO_ARRAY(TRIM(tabelao_sn.director),',') AS nome_comp,
		ARRAY_LENGTH(STRING_TO_ARRAY(TRIM(tabelao_sn.director),','),1) AS num
    FROM public.tabelao_sn
	)
	
	, directors_table AS (
	SELECT
		tabelao_sn.new_id,
		tab_aux.nome_comp AS nome_completo,
		tab_aux.array_nome[1] AS primeiro_nome,
		tab_aux.array_nome[array_length(tab_aux.array_nome,1)] AS ultimo_nome,
		tab_aux.array_nome[array_length(tab_aux.array_nome,1)] || ', ' || tab_aux.array_nome[1] AS nome_format
	FROM public.tabelao_sn
	LEFT JOIN tab_aux
		ON tabelao_sn.new_id = tab_aux.new_id

	)
	
SELECT * FROM directors_table
)



3. Faca um diagrama de relacionamento (DER) das novas tabelas criadas 











4. Preencha os campos em branco com 'Null'

CREATE TABLE tabelao_sn AS (
  
	WITH tabelao_sn AS (
		SELECT
			tabelao2.new_id,
          	tabelao2.type, 
          	tabelao2.title,
          	CASE 
              	WHEN tabelao2.director = ''
              	THEN 'NAN'
              	ELSE tabelao2.director
          	END AS director,
          	CASE	
              	WHEN tabelao2.cast = ''
              	THEN 'NAN'
              	ELSE tabelao2.cast
          	END AS cast,
          	CASE
              	WHEN tabelao2.country = ''
              	THEN 'NAN'
              	ELSE tabelao2.country
          	END AS country,
          	CASE
              	WHEN tabelao2.date_added = ''
              	THEN 'NAN'
              	ELSE tabelao2.date_added
          	END AS date_added,
          	tabelao2.release_year,
          	CASE 
              	WHEN tabelao2.rating = ''
              	THEN 'NAN'
              	ELSE tabelao2.rating
          	END AS rating,
          	CASE
              	WHEN tabelao2.duration = ''
              	THEN 'NAN'
              	ELSE tabelao2.duration
          	END AS duration,
          	tabelao2.listed_in,
          	tabelao2.description,
			tabelao2.numeracao
      	FROM public.tabelao2
  	)
  
SELECT * FROM tabelao_sn
)


--------------------Negocio---------------------------

5. Informe qual a serie tem tempo de duracao somados de 30 horas ou mais.


-- Crio uma tabela auxiliar para tirarmos a quantidade de horas de cada obra
--	respeitando a regra de negócio.
CREATE TABLE public.tab_time_aux AS (
	
	WITH tab_time_aux AS (

		SELECT
			tabelao_sn.new_id,
		CASE
			WHEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'Seasons' 
			OR (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'Season' 
			THEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[1]::FLOAT * 10 
			WHEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'min'
			THEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[1]::FLOAT / 60 
		END AS hours
		FROM public.tabelao_sn

	)
SELECT * FROM
)

-- Aqui criamos a tabela final.
CREATE TABLE normat.time_table AS (
  
-- Aqui utilizo as tabelas auxiliares e puxo seus dados através do LEFT JOIN.
-- Aproveitando os dados da mesma e também os usando para calcular os minutos.
	WITH tab_time_aux AS (

		SELECT
			tabelao_sn.new_id,
		CASE
			WHEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'Seasons' 
			OR (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'Season' 
			THEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[1]::FLOAT * 10 
			WHEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'min'
			THEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[1]::FLOAT / 60 
		END AS hours
		FROM public.tabelao_sn

	)	
	
    , time_table AS (  
        SELECT 
              tabelao_sn.new_id,
              tabelao_sn.duration,
              tab_time_aux.hours AS time_hours,
              CASE
                  WHEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'Seasons' 
                      OR (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'Season' 
              THEN tab_time_aux.hours::FLOAT * 60
              WHEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[2] = 'min'
              THEN (STRING_TO_ARRAY(tabelao_sn.duration,' '))[1]::FLOAT 
              END AS minuts
          FROM tabelao_sn
          LEFT JOIN tab_time_aux
              ON tabelao_sn.new_id = tab_time_aux.new_id
	)
    
SELECT * FROM time_table
)

-- Podemos ver que a tabela final foi criada corretamente.
SELECT * FROM normat.time_table;



6. A equipe precisa seguimentar o tempo de tela de cada conteudo de filmes, dessa forma, 
crie uma coluna que tenha a informacao particionada pela categoria e descubra o tempo maximo em horas de cada seguemento.
Exemplo

listed_in_split nova_coluna 
Documentaries  30
TV Show        15

7. Crie uma nova coluna de classificao dos conteudos por estrelas pelos seguintes criterios.
Se tiver os 5 criterios ganha 5 estrelas de classficao '*****'
Se tiver os 4 criterios ganha 4 estrelas '****', assim susessivamente ate nenhuma estrela.

- 1. O conteudo precisa ter no minimo 120 minutos - 1 uma estrela.
- 2. A producao ser americana. United Estates - 1 uma estrela.
- 3. A producao ser francesa. France - 1 uma estrela.
- 4. A quantidade do elenco precisa ser igual ou maior que 3 - 1 uma estrela.
- 5. O numero dos diretores precisa ser igual a 1 ou 2 - 1 uma estrela.

classficao aux_classificao
*****.       5
****.        4

CREATE TABLE normat.classificacao AS (
	
	WITH tab_aux AS (
		SELECT 
			tabelao_sn.new_id,
			CASE
				WHEN time_table.minuts >= 120
				THEN 1
				ELSE 0
			END AS ponto_duracao,
			CASE
				WHEN tabelao_sn.country LIKE '%United States%'
				THEN 1
				ELSE 0
			END AS ponto_EUA,
			CASE
				WHEN tabelao_sn.country LIKE '%France%'
				THEN 1
				ELSE 0
			END AS ponto_FR,
			CASE
				WHEN ARRAY_LENGTH(STRING_TO_ARRAY(TRIM(tabelao_sn.cast),','),1) >= 3
				THEN 1
				ELSE 0
			END AS ponto_qtd_a,	
			CASE
				WHEN ARRAY_LENGTH(STRING_TO_ARRAY(TRIM(tabelao_sn.director),','),1) = 1 
					OR ARRAY_LENGTH(STRING_TO_ARRAY(TRIM(tabelao_sn.director),','),1) = 2
				THEN 1
				ELSE 0
			END AS ponto_qtd_d
		FROM public.tabelao_sn
		LEFT JOIN normat.time_table
			ON tabelao_sn.new_id = time_table.new_id
		)

		, pontuacao AS (
		SELECT
			*,
			tab_aux.ponto_duracao + tab_aux.ponto_EUA + tab_aux.ponto_FR + tab_aux.ponto_qtd_a + tab_aux.ponto_qtd_d AS pontos,
			CASE
				WHEN tab_aux.ponto_duracao + tab_aux.ponto_EUA + tab_aux.ponto_FR + tab_aux.ponto_qtd_a + tab_aux.ponto_qtd_d = 1
				THEN '*'
				WHEN tab_aux.ponto_duracao + tab_aux.ponto_EUA + tab_aux.ponto_FR + tab_aux.ponto_qtd_a + tab_aux.ponto_qtd_d = 2
				THEN '**'	
				WHEN tab_aux.ponto_duracao + tab_aux.ponto_EUA + tab_aux.ponto_FR + tab_aux.ponto_qtd_a + tab_aux.ponto_qtd_d = 3
				THEN '***'	
				WHEN tab_aux.ponto_duracao + tab_aux.ponto_EUA + tab_aux.ponto_FR + tab_aux.ponto_qtd_a + tab_aux.ponto_qtd_d = 4
				THEN '****'
				WHEN tab_aux.ponto_duracao + tab_aux.ponto_EUA + tab_aux.ponto_FR + tab_aux.ponto_qtd_a + tab_aux.ponto_qtd_d = 5
				THEN '*****'
			END AS estrelas
		FROM tab_aux
	)
	
SELECT * FROM pontuacao
)

-- Oficializando as tabelas com colunas normalizadas sobre a classificacao e pontuação 
SELECT 
	*
FROM public.tabelao_sn
INNER JOIN normat.classificacao
	ON 	tabelao_sn.new_id = classificacao.new_id



8. Construa uma coluna que possua o rank dos melhores filmes pelos criterios da questao 7.
SELECT * FROM normat.classificacao;
SELECT * FROM public.tabelao_sn;

WITH aux_tab_order_by_d AS (
	SELECT
		classf.new_id,
		tab.title
	FROM normat.classificacao AS classf
	LEFT JOIN public.tabelao_sn AS tab
		ON classf.new_id = tab.new_id
	WHERE tab.type = 'Movie' AND classf.ponto_duracao = 1
	ORDER BY classf.pontos DESC
	
)
	, aux_tab_order_by_eua AS (
	SELECT
		classf.new_id,
		tab.title
	FROM normat.classificacao AS classf
	LEFT JOIN public.tabelao_sn AS tab
		ON classf.new_id = tab.new_id
	WHERE tab.type = 'Movie' AND classf.ponto_eua = 1
	ORDER BY classf.pontos DESC

)
	, aux_tab_order_by_fr AS (
	SELECT
		classf.new_id,
		tab.title
	FROM normat.classificacao AS classf
	LEFT JOIN public.tabelao_sn AS tab
		ON classf.new_id = tab.new_id
	WHERE tab.type = 'Movie' AND classf.ponto_fr = 1
	ORDER BY classf.pontos DESC

)
	, aux_tab_order_by_qtd_a AS (
	SELECT
		classf.new_id,
		tab.title
	FROM normat.classificacao AS classf
	LEFT JOIN public.tabelao_sn AS tab
		ON classf.new_id = tab.new_id
	WHERE tab.type = 'Movie' AND classf.ponto_qtd_a = 1
	ORDER BY classf.pontos DESC

)
	, aux_tab_order_by_qtd_d AS (
	SELECT
		classf.new_id,
		tab.title
	FROM normat.classificacao AS classf
	LEFT JOIN public.tabelao_sn AS tab
		ON classf.new_id = tab.new_id
	WHERE tab.type = 'Movie' AND classf.ponto_qtd_d = 1
	ORDER BY classf.pontos DESC

)

SELECT 
	tabelao_sn.new_id,
	tabelao_sn.title,
	


9. Construa uma coluna que possua o rank das melhores series pelos criterios da questao 7.





10. Desafio. 

O nosso sistema desenvolveu uma campanha de publicidade no qual o cliente digita na busca dos conteudos
a sua data de aniversario (DDMM) e o sistema retorna a sugestao de filmes que foram adicionados no sistema naquela
data. 

- Faca uma funcao ao qual recebe uma inteiro que correspode ao dia e mes e retorna 1 uma sugestao de filme aos quais o dia e mes
de publicacao na plataforma dao match. Gere o campo sugestao_1

- Alem disso, a classificao de conteudo precisa ser maior ou igual a 3 estrelas.

- Caso o cliente nao goste da sugestao ele pode ter como retorno a sugestao anterior a essa. Gere o campo sugestao_2

---funcao simples
CREATE FUNCTION inc(val integer) RETURNS integer AS $$
BEGIN
RETURN val + 1;
END; $$
LANGUAGE PLPGSQL;

SELECT inc(20);

-- funcao conversao

CREATE OR REPLACE FUNCTION convert_data(date_var integer) RETURNS date AS $$
BEGIN
RETURN ( 
        
        select to_date(date_var::text, 'YYYYMMDD')
);
END; $$
LANGUAGE PLPGSQL;

SELECT convert_data(20221114);







