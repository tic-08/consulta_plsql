--crear tablas t1 como usuario curso
CREATE TABLE T1 (A NUMBER);

--Menu VER>DBMS
/*
ejecutar consultas 
select sysdate from dual;

F5 ejecuta todo el script
F9 ejecuta solo el script que esta separado por comas

f10 o f6 para visualizar plan de ejecución

*/

SELECT * FROM t1;

--funcion para ver plan de ejecucion
set autotrace on;
--funcion para timing de ejecucion es decir el tiempo que tarda en ejecutar
set timing on;
--selecciona fecha del sistema
select sysdate from dual;

--show errors;
--show parameters
/*ejecutar archivos .sql START C:\Poryectos\script1.sql*/


/*Cosas que debes validar*/
/*crear un directorio y registrar*/
SELECT * FROM dba_directories WHERE directory_name = 'RIPLEY';

/*¿Tengo permiso? tú usuario debe tener permisos adecuados*/
GRANT READ, WRITE ON DIRECTORY RIPLEY TO tu_usuario;

/*Para el ejercicio creamos una tabla*/
CREATE TABLE odo_agenda (
    description VARCHAR2(100),
    label       VARCHAR2(50),
    location    VARCHAR2(100)
);


--insertar 100 registros de prueba
BEGIN
    FOR i IN 1..100 LOOP
        INSERT INTO odo_agenda (description, label, location)
        VALUES (
            'Descripción ' || i,
            'Etiqueta ' || i,
            'Ubicación ' || i
        );
    END LOOP;
    COMMIT;
END;

--validar mediante un select
select * from odo_agenda;

/*crear el directorio*/
--3. Crear el directorio lógico RIPLEY (solo lo hace un DBA)
CREATE OR REPLACE DIRECTORY RIPLEY AS 'C:\oracle\archivos_csv';
-- Ejemplo típico en Linux: '/u01/app/oracle/files'
GRANT READ, WRITE ON DIRECTORY RIPLEY TO TU_USUARIO;
--crear un directorio
CREATE OR REPLACE DIRECTORY RIPLEY AS 'C:\testCSV';
--tener permisos 
GRANT READ, WRITE ON DIRECTORY RIPLEY TO CURSO;

-- Reemplaza '/ruta/del/servidor/para/archivos' con una ruta válida del servidor donde Oracle puede escribir.

DECLARE
    CURSOR CI IS
        SELECT o.description, o.label, o.location FROM odo_agenda o;

    CI_R CI%ROWTYPE;
    v_file UTL_FILE.FILE_TYPE;
BEGIN
    v_file := UTL_FILE.FOPEN('RIPLEY', 'Esmerco.csv', 'w', 32767);

    -- Cabecera del archivo CSV
    UTL_FILE.PUT_LINE(v_file, 'description,label,location');

    FOR CI_R IN CI LOOP
        UTL_FILE.PUT_LINE(v_file, CI_R.description || ',' || CI_R.label || ',' || CI_R.location);
    END LOOP;

    UTL_FILE.FCLOSE(v_file);
END;

--prueba
DECLARE
    v_file UTL_FILE.FILE_TYPE;
BEGIN
    v_file := UTL_FILE.FOPEN('RIPLEY', 'test.txt', 'w');
    UTL_FILE.PUT_LINE(v_file, 'Prueba de acceso correcta');
    UTL_FILE.FCLOSE(v_file);
END;



drop TABLE t1;


DECLARE
    CURSOR C1 IS 

BEGIN
END
