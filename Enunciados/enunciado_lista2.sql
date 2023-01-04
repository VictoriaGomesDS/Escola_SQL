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


1. A base possui diversos valores nulos. Preencha nas colunas onde os valores 
são nulls com 'NAN'.

3. Normalize a coluna CAST criando uma nova tabela 'cast_table' de modo que tenhamos separadamente, ou seja, 
uma coluna com o nome do elenco de cada filme. Exemplo:

Linha: n1 joao, maria, roberto

coluna:

id CAST 
n1 joao
n1 maria
n1 roberto

4. Normalize a coluna listed_in criando uma nova tabela 'genre_table' de modo que tenhamos separadamente os gêneros
de cada programação. Exemplo:

Linha: n1 Ação, Aventura, Comédia

coluna:

n1 Ação
n1 Comédia
n1 Aventura

5. Normalize a coluna date_added em uma nova base 'date_table' e construa as seguintes colunas:
- coluna day: DD
- coluna mouth: MM
- coluna year: YY
- coluna iso_date_1: YYYY-MM-DD
- coluna iso_date_2: YYYY/MM/DD
- coluna iso_date_3: YYMMDD
- coluna iso_date_4: YYYYMMDD


6. Normalize a coluna duration e construa uma nova base 'time_table' e faça as seguintes conversões.
- Converta a coluna duration para horas e crie a coluna hours hh. Obs. A média de cada 
season TV SHOW é 10 horas, assim também converta para horas
- Converta todas as horas para minutos e armazena na coluna minutes mm.

7. Normalize a coluna country criando uma nova tabela 'country_table' de modo que tenhamos separadamente 
uma coluna com o nome do país de cada filme.

------------------------------Questoes de negócio -----------------------------------------------------

8. Qual o filme de duração máxima em minutos ?

9.  Qual o filme de duraçã mínima em minutos ?

10. Qual a série de duração máxima em minutos ?

11. Qual a série de duração mínima em minutos ?

12. Qual a média de tempo de duração dos filmes?

13. Qual a média de tempo de duração das series?

14. Qual a lista de filmes o ator Leonardo DiCaprio participa?

15. Quantas vezes o ator Tom Hanks apareceu nas telas do netflix, ou seja, tanto série quanto filmes?

16. Quantas produções séries e filmes brasileiras já foram ao ar no netflix?

17. Quantos filmes americanos já foram para o ar no netflix?

18. Crie uma nova coluna com o nome last_name_director com uma nova formatação para o nome dos diretores, por exemplo.
João Roberto para Roberto, João.

19. Procure a lista de conteúdos que tenha como temática a segunda guerra mundial (WWII)?

20. Conte o número de produções dos países que apresentaram conteúdos no netflix?




