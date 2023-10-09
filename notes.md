# POSIBLES ENTIDADES
#### ESTUDIANTE 
#### CARRERA 
#### DOCENTE 
#### CURSO 
#### CURSO_HABILITADO 
#### HORARIO 
#### ASIGNACION 
#### NOTA 
#### ACTA 
#### TRANSACCION

## Tomar en cuenta

<!-- TODO: AGREGAR LAS NUEVAS ENTIDADES Y ATRIBUTOS -->
# POSIBLES ATRIBUTOS DE LAS ENTIDADES
#### ESTUDIANTE:
- carnet Bigint (PK)
- nombres Varchar(50)
- apellidos Varchar(50)
- fecha_nacimieno Date
- correo Varchar(50)
- telefono int
- direccion Varchar(100)
- dpi Bigint
- credios int
- registro_creacion Date
- id_carrera int (FK)

#### CARRERA:
- id_carrera int  (PK)
- nombre Varchar(50)

#### DOCENTE:
- id_docente int AUTO (PK)
- nombres Varchar(50)
- apellidos Varchar(50) 
- fecha_nacimieno Date
- correo Varchar(50)
- telefono Varchar(8)
- direccion Varchar(100)
- dpi Varchar(13)
- registro_siif Bigint
- registro_creacion Date

#### CURSO:
- id_curso int AUTO (PK)
- codigo int 
- nombre Varchar(50)
- creditos_necesarios int
- creditos_otorgados int
- obligatorio boolean
- id_carrera int (FK)

#### CURSO_HABILITADO:
- id_curso_habilitado int AUTO (PK)
- cupo_maximo int
- ciclo Varchar(2)
- seccion Char(1)
- id_curso int (FK)
- id_docente int (FK)
  
#### HORARIO:
- id_horario int AUTO (PK)
- dia int 
- horario Varchar(50)
- id_curso_habilitado int (FK)

#### ASIGNACION:
- id_asignacion int AUTO (PK)
- clico Varchar(2)
- seccion Char(1)
- fecha_desasignacion datetime
- id_curso_habilitado int (FK)
- carnet_estudiante Bigint (FK)

#### NOTA:
- id_nota int AUTO (PK)
- nota int
- carnet_estudiante Bigint (FK)

#### ACTA:
- id_acta int AUTO (PK)
- ciclo Varchar(2)
- seccion Char(1)
- fecha_hora datetime
- id_asignacion int (FK)

#### TRANSACCION:
