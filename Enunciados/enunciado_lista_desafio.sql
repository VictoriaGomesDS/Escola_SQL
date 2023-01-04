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

2. Normalize as colunas do tabelao.

- cast, country, listed_in, date_added, duration

3. Faca um diagrama de relacionamento (DER) das novas tabelas criadas 

4. Preencha os campos em branco com 'Null'

--------------------Negocio---------------------------

5. Informe qual a serie tem tempo de duracao somados de 30 horas ou mais.

6. A equipe precisa seguimentar o tempo de tela de cada conteudo de filmes, dessa forma, 
crie uma coluna que tenha a informacao particionada pela categoria e descubra o tempo maximo em horas de cada seguemento.
Exemplo

listed_in_split nova_coluna 
Documentaries  30
TV Show        15

7. Crie uma nova coluna de classificao dos conteudos por estrelas pelos seguintes criterios.
Se tiver os 5 criterios ganha 5 estrelas de classficao '*****'
Se tiver os 4 criterios ganha 4 estrelas '****', assim susessivamente ate nenhuma estrela.

- 1. O conteudo precisa ter no minimo 120 minutos - 1 uma estrela 
- 2. A producao ser americana. United Estates - 1 uma estrela 
- 3. A producao ser francesa. France - 1 uma estrela 
- 4. A quantidade do elenco precisa ser igual ou maior que 3 - 1 uma estrela 
- 5. O numero dos diretores precisa ser igual a 1 ou 2 - 1 uma estrela 

classficao aux_classificao
*****.       5
****.        4


8. Construa uma coluna que possua o rank dos melhores filmes pelos criterios da questao 7.

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







