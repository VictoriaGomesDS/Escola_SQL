------------------------------------------
--DDL statement for table 'HR' database--
--------------------------------------------

-- Drop the tables in case they exist

DROP TABLE EMPLOYEES; 
DROP TABLE JOB_HISTORY;
DROP TABLE JOBS;
DROP TABLE DEPARTMENTS;
DROP TABLE LOCATIONS;

-- Create the tables


CREATE TABLE EMPLOYEES (
                          EMP_ID CHAR(9) NOT NULL,
                          F_NAME VARCHAR(15) NOT NULL,
                          L_NAME VARCHAR(15) NOT NULL,
                          SSN CHAR(9),
                          B_DATE DATE,
                          SEX CHAR,
                          ADDRESS VARCHAR(30),
                          JOB_ID CHAR(9),
                          SALARY DECIMAL(10,2), 
                          MANAGER_ID CHAR(9),
                          DEP_ID CHAR(9) NOT NULL,
                          PRIMARY KEY (EMP_ID),
                          FOREIGN KEY (JOB_ID) REFERENCES JOB_HISTORY(JOB_ID),
                          FOREIGN KEY (JOB_ID) REFERENCES Jobs(JOB_IDENT),
                          FOREIGN KEY (DEP_ID) REFERENCES Departments(DEPT_ID_DEP)
                        );

CREATE TABLE JOB_HISTORY (
                            EMPL_ID CHAR(9) NOT NULL,
                            START_DATE DATE,
                            JOBS_ID CHAR(9) NOT NULL,
                            DEPT_ID CHAR(9),
                            PRIMARY KEY (EMPL_ID,JOBS_ID),
                            FOREIGN KEY (JOBS_ID) REFERENCES JOBS(JOB_IDENT)
                          );

CREATE TABLE JOBS (
                    JOB_IDENT CHAR(9) NOT NULL,
                    JOB_TITLE VARCHAR(30) ,
                    MIN_SALARY DECIMAL(10,2),
                    MAX_SALARY DECIMAL(10,2),
                    PRIMARY KEY (JOB_IDENT)
                  );

CREATE TABLE DEPARTMENTS (
                            DEPT_ID_DEP CHAR(9) NOT NULL,
                            DEP_NAME VARCHAR(15) ,
                            MANAGER_ID CHAR(9),
                            LOC_ID CHAR(9),
                            PRIMARY KEY (DEPT_ID_DEP),
                            FOREIGN KEY (LOC_ID) REFERENCES LOCATIONS(LOCT_ID)
                          );

CREATE TABLE LOCATIONS (
                          LOCT_ID CHAR(9) NOT NULL,
                          DEP_ID_LOC CHAR(9) NOT NULL,
                          STATE_LOC VARCHAR(255) NOT NULL,
                          COUNTRY_LOC CHAR(20) NOT NULL,
                          PRIMARY KEY (LOCT_ID,DEP_ID_LOC)
                        );

-- INSERT the tables

INSERT INTO 'Employees' (EMP_ID,F_NAME,L_NAME,SSN,B_DATE,SEX,ADDRESS,JOB_ID,SALARY,MANAGER_ID,DEP_ID) VALUES 
 ('E1001','John','Thomas','123456','01/09/1976','M','5631 Rice, OakPark,IL','100','100000','30001','2'), 
 ('E1002','Alice','James','123457','07/31/1972','F','980 Berry ln, Elgin,IL','200','80000','30002','5'), 
 ('E1003','Steve','Wells','123458','08/10/1980','M','291 Springs, Gary,IL','300','50000','30002','5'), 
 ('E1004','Santosh','Kumar','123459','07/20/1985','M','511 Aurora Av, Aurora,IL','400','60000','30004','5'), 
 ('E1005','Ahmed','Hussain','123410','01/04/1981','M','216 Oak Tree, Geneva,IL','500','70000','30001','2'), 
 ('E1006','Nancy','Allen','123411','02/06/1978','F','111 Green Pl, Elgin,IL','600','90000','30001','2'), 
 ('E1007','Mary','Thomas','123412','05/05/1975','F','100 Rose Pl, Gary,IL','650','65000','30003','7'), 
 ('E1008','Bharath','Gupta','123413','05/06/1985','M','145 Berry Ln, Naperville,IL','660','65000','30003','7'), 
 ('E1009','Andrea','Jones','123414','07/09/1990','F','120 Fall Creek, Gary,IL','234','70000','30003','7'), 
 ('E1010','Ann','Jacob','123415','03/30/1982','F','111 Britany Springs,Elgin,IL','220','70000','30004','5'),
 ('E1011','Amanda','Gusmao','123456','01/09/1985','F','1157 Paulista, Tutoia, SP','760','150000','30004','8'), 
 ('E1012','Vanessa','Silva','123457','07/31/1982','F','1157 Paulista, Tutoia, SP','720','90000','30004','8'), 
 ('E1013','Khusia','Ibshia','123458','08/10/1980','M','122005 Bandhwari, Gwal Pahari Village, ND','600','100000','30005','9'), 
 ('E1014','Santosh','Zhash','123459','14/20/1988','M','122005 Bandhwari, Gwal Pahari Village, ND','600','100000','30005','9'), 
 ('E1015','Jorge','Paulo','123410','01/04/1981','M','1157 Paulista, Tutoia, SP','500','70000','30001','8'), 
 ('E1016','Clary','Allen','123411','02/08/1978','F','111 Green Pl, Elgin,IL','600','90000','30001','2'), 
 ('E1017','Amanda','Thomas','123412','05/05/1975','F','100 Rose Pl, Gary,IL','650','65000','30003','7'),
 ('E1018','John ','Harry','123413','05/06/1985','M','145 Berry Ln, Naperville,IL','660','65000','30003','7'), 
 ('E1019','Andrea','Maria','123414','19/09/1990','F','120 Rua do Porto Lisboa,PT','780','70000','30003','10'),
 ('E1020','Roberta','Lima','123415','21/30/1982','F','120 Rua do Porto Lisboa,PT','780','70000','30004','10');


-- INSERT INTO 'Employees_2' (EMP_ID,F_NAME,L_NAME,SSN,B_DATE,SEX,ADDRESS,JOB_ID,SALARY,MANAGER_ID,DEP_ID) VALUES 
--  ('E1001','John','Thomas','123456','01/09/1976','M','5631 Rice, OakPark,IL','100','100000','30001','2'), 
--  ('E1002','Alice','James','123457','07/31/1972','F','980 Berry ln, Elgin,IL','200','80000','30002','5'), 
--  ('E1003','Steve','Wells','123458','08/10/1980','M','291 Springs, Gary,IL','300','50000','30002','5'), 
--  ('E1004','Santosh','Kumar','123459','07/20/1985','M','511 Aurora Av, Aurora,IL','400','60000','30004','5'), 
--  ('E1005','Ahmed','Hussain','123410','01/04/1981','M','216 Oak Tree, Geneva,IL','500','70000','30001','2'), 
--  ('E1006','Nancy','Allen','123411','02/06/1978','F','111 Green Pl, Elgin,IL','600','90000','30001','2'), 
--  ('E1007','Mary','Thomas','123412','05/05/1975','F','100 Rose Pl, Gary,IL','650','65000','30003','7'), 
--  ('E1008','Bharath','Gupta','123413','05/06/1985','M','145 Berry Ln, Naperville,IL','660','65000','30003','7'), 
--  ('E1009','Andrea','Jones','123414','07/09/1990','F','120 Fall Creek, Gary,IL','234','70000','30003','7'), 
--  ('E1010','Ann','Jacob','123415','03/30/1982','F','111 Britany Springs,Elgin,IL','220','70000','30004','5'),
--  ('E1011','Amanda','Gusmao','123456','01/09/1985','F','1157 Paulista, Tutoia, SP','760','150000','30004','8'), 
--  ('E1012','Vanessa','Silva','123457','07/31/1982','F','1157 Paulista, Tutoia, SP','720','90000','30004','8'), 
--  ('E1013','Khusia','Ibshia','123458','08/10/1980','M','122005 Bandhwari, Gwal Pahari Village, ND','600','100000','30005','9'), 
--  ('E1014','Santosh','Zhash','123459','14/20/1988','M','122005 Bandhwari, Gwal Pahari Village, ND','600','100000','30005','9'), 
--  ('E1015','Jorge','Paulo','123410','01/04/1981','M','1157 Paulista, Tutoia, SP','500','70000','30001','8'), 
--  ('E1016','Clary','Allen','123411','02/08/1978','F','111 Green Pl, Elgin,IL','600','90000','30001','2'), 
--  ('E1017','Amanda','Thomas','123412','05/05/1975','F','100 Rose Pl, Gary,IL','650','65000','30003','7'),
--  ('E1018','John ','Harry','123413','05/06/1985','M','145 Berry Ln, Naperville,IL','660','65000','30003','7'), 
--  ('E1019','Andrea','Maria','123414','19/09/1990','F','120 Rua do Porto Lisboa,PT','780','70000','30003','10'),
--  ('E1020','Roberta','Lima','123415','21/30/1982','F','120 Rua do Porto Lisboa,PT','780','70000','30004','10'),
--  ('E1021','Mauricio','Helfstein','123414','19/09/1994','M','120 Rua do Brás, SP','300','70000','30003','8'),
--  ('E1022','Lucas','Roberto','123415','21/30/1995','M','120 Rua da Mooca,SP','400','70000','30004','8');



INSERT INTO 'Job_History' (EMPL_ID,START_DATE,JOBS_ID,DEPT_ID) VALUES 
 ('E1001','08/01/2000','100','2'), 
 ('E1002','08/01/2001','200','5'), 
 ('E1003','08/16/2001','300','5'), 
 ('E1004','08/16/2000','400','5'), 
 ('E1005','05/30/2000','500','2'), 
 ('E1006','08/16/2001','600','2'), 
 ('E1007','05/30/2002','650','7'), 
 ('E1008','05/06/2010','660','7'), 
 ('E1009','08/16/2016','234','7'), 
 ('E1010','08/16/2016','220','5'),

 ('E1011','08/01/2000','760','8'), 
 ('E1012','08/01/2001','720','8'), 
 ('E1013','08/16/2001','720','9'), 
 ('E1014','08/16/2000','720','9'), 
 ('E1015','05/30/2000','500','8'), 
 ('E1016','08/16/2001','600','2'), 
 ('E1017','05/30/2002','650','7'), 
 ('E1018','05/06/2010','700','7'), 
 ('E1019','08/16/2016','780','10'), 
 ('E1020','08/16/2016','780','8');


 

INSERT INTO 'Jobs' (JOB_IDENT,JOB_TITLE,MIN_SALARY,MAX_SALARY) VALUES 
 ('100','Sr. Architect','60000','100000'), 
 ('200','Sr.Software Developer','60000','80000'), 
 ('300','Jr.Software Developer','40000','60000'), 
 ('400','Jr.Software Developer','40000','60000'), 
 ('500','Jr. Architect','50000','70000'), 
 ('600','Lead Architect','70000','100000'), 
 ('650','Jr. Designer','60000','70000'), 
 ('660','Jr. Designer','60000','70000'), 
 ('234','Sr. Designer','70000','90000'), 
 ('220','Sr. Designer','70000','90000'),
 ('700','Scrum Master','60000','70000'), 
 ('720','PMO','90000','150000'), 
 ('760','PE','100000','200000'), 
 ('780','UX Designer','70000','90000');



INSERT INTO 'Departments' (DEPT_ID_DEP,DEP_NAME,MANAGER_ID,LOC_ID) VALUES 
 ('2','Architect Group','30001','L0001'), 
 ('5','Software Group','30002','L0002'), 
 ('7','Design Team','30003','L0003'),
 ('8','Software Group','30004','L0004'),
 ('9','Architect Group','30005','L0005'), 
 ('10','Design Team','30006','L0006');


 INSERT INTO 'Locations' (LOCT_ID,DEP_ID_LOC, STATE_LOC, COUNTRY_LOC) VALUES 
 ('L0001','2', 'Illinois', 'UNITED ESTATES'), 
 ('L0002','5', 'Illinois', 'UNITED ESTATES'), 
 ('L0003','7', 'Illinois', 'UNITED ESTATES'),
 ('L0004','8', 'SAO PAULO', 'BRAZIL'), 
 ('L0005','9', 'NEW DELHI', 'INDIA'), 
 ('L0006','10', 'LISBOA', 'PORTUGAL');




CREATE TEMPORARY TABLE 'Tabelao' AS 
SELECT * 
FROM EMPLOYEES as e
INNER JOIN DEPARTMENTS as d ON e.dep_id = d.DEPT_ID_DEP
INNER JOIN LOCATIONS as l ON d.LOC_ID = l.LOCT_ID
INNER JOIN JOB_HISTORY as j ON e.EMP_ID = j.EMPL_ID
INNER JOIN JOBS as f ON j.JOBS_ID = f.JOB_IDENT;


-- EXE:
Meu nome é Maurício sou P.O (Product Owner) de vocês. Teremos várias questões que representam os problemas de negócios para resolverem.
Para cada resolução seria interessante justificar o seu desenvolvimento, assim busquem explicar o que fizeram, o porque de cada desenvolvimento
para a equipe de assessores compreenderem seu raciocínio. Então, cada entrega terá duas respostas a primeira o código(script) 
e a segunda um pequeno trecho justificando sua resposta. Quando tiverem dúvidas no desenvolvimento podem acionar o P.O 
para compreenderem as regras de negócio.

1. A nossa empresa é global possui diversos colaboradores e grupos de trabalho ao redor do mundo. 
Recebemos uma solicitação da equipe de RH para a campanha "mulheres na tecnologia", na qual precisamos informar 
a quantidade de funcionários do sexo Feminino dos grupos de trabalho Software Group e Architect Group que temos atualmente na empresa.

SELECT sex AS 'Sexo',
	   COUNT(sex) AS 'Qtd_Colaboradoras',
       dep_name AS 'Nome_Departamento'
FROM EMPLOYEES
INNER JOIN DEPARTMENTS ON EMPLOYEES.DEP_ID = DEPARTMENTS.DEPT_ID_DEP
WHERE sex = 'F'
	  AND (dep_name = 'Architect Group'
      OR dep_name = 'Software Group')
GROUP BY sex, dep_name;


2. Anualmente, o RH realiza campanha ligadas a qualidade de vida dos trabalhadores, no mês de novembro é realizado novembro azul ligados
a prevenção do cancêr de prostáta. Dessa forma, precisamos selecionar a lista de funcionários masculinos com idade acima dos 40 anos de idade
para o RH enviar um webmail de convite para a campanha.

Select * 
FROM EMPLOYEES
WHERE CAST(strftime('%Y', current_date) AS INTEGER) - CAST(substr(b_date,7,4) AS INTEGER) >= 40 
and sex = 'M';


3. A empresa está com um novo plano de bonificação de resultado para os funcionários, a nova política PLR(Participação de resultados) nos diz
que quando o funcionário tanto masculino quanto feminino tiver 10 ou mais anos de casa ele receberá com base no salário 
um percentual de 25 % de bonificação (1.25). Assim, construa uma nova coluna com a bonificacao das pessoas selecionadas na regra,
as que estiverem fora mantém o mesmo salário.

SELECT *,
       case
       	  WHEN CAST(strftime('%Y', current_date) AS INTEGER) - CAST(substr(start_date,7,4) AS INTEGER) >= 10
          THEN salary * 1.25
       ELSE salary
       END AS PLR
FROM EMPLOYEES
INNER JOIN JOB_HISTORY ON EMPLOYEES.emp_id = JOB_HISTORY.EMPL_ID;


6. O RH solicitou para a equipe de desenvolvimento que o Tabelao de registro dos funcionários precisava de um acréscimo de duas colunas, a primeira 
coluna com o ano no qual o funcionário ingressou na empresa, a segunda do ano de nascimento do funcionário.

SELECT *,
	   substr(b_date,7,4) AS ANO_NASCIMENTO,
	   substr(start_date,7,4) AS ANO_INICIO_TRABALHO
FROM 'Tabelao';


7. Um desenvolvedor da equipe de FRONT_END da empresa precisa consumir uma coluna que possua o primeiro e o segundo nome dos funcionários da empresa
para o sistema de RH. Assim, construa uma coluna com a concatenação dos nomes e um espaçamento entre eles.

SELECT *,
	   f_name || " " || l_name AS NOME_CONCAT
FROM EMPLOYEES;


8. A Contabilidade da empresa precisa da média dos salários dos funcionários. Dessa forma, construa uma coluna que tenha a média por grupo de trabalho.

SELECT * FROM 'Tabelao';
SELECT * FROM DEPARTMENTS;

SELECT dep_name AS NOME_DEPARTAMENTO,
	   dept_id_dep CODIGO_DEPARTAMENTO,
	   AVG(salary) AS MEDIA_SALARIO_DEP
FROM 'Tabelao'
GROUP BY dept_id_dep;


9. A empresa está realizando um grande mapeamento de funcionários, dessa forma, a gerência quer ter ciência de quantos funcionários por país temos 
atualmente.

SELECT * FROM 'Tabelao';

SELECT country_loc AS NOME_PAIS,
	   COUNT(*) AS NUMERO_COLABORADORES
FROM 'Tabelao'
GROUP BY country_loc;




       





