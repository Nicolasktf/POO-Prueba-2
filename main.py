import pymysql

from empleado.class_empleado import Empleado
from empleado.class_administrador import Administrador

class BaseDatos:
    def __init__(self):
        self.conexion = pymysql.connect(
            host='localhost',
            user='root',
            password='',
            db='prueba'
        )
        self.prueba = self.conexion.cursor()
        print("Conexion bd correcta")

    def seleccionarBD(self, id):
        sql = 'select id, nombre, edad from registro where id={}'.format(id)
        try:
            self.prueba.execute(sql)
            usuario = self.prueba.fetchone()

            print("id: ", usuario[0])
            print("nombre: ", usuario[1])
            print("edad: ", usuario[2])


        except Exception as e:
            raise

    def seleccionarTodo(self):
        sql = 'select id, nombre, edad from registro '
        try:
            self.prueba.execute(sql)
            usuario = self.prueba.fetchall()

            for usu in usuario:
                print("id: ", usuario[0])
                print("nombre: ", usuario[1])
                #print("edad: ", usuario[2])
                print("-----------")


        except Exception as e:
            raise

    def ingresar(self,id,nombre,edad):
        sql = "insert into registro (id,nombre,edad) values ({}, '{}', {})".format(id,nombre,edad)
        try:
            self.prueba.execute(sql)
            self.conexion.commit()
        except Exception as e:
            print("El valor ya existe",e)
            raise

    def actualizar(self,id,nombre):
        sql = "update registro set nombre='{}' where id={}".format(nombre,id)

        try:
            self.prueba.execute(sql)
            self.conexion.commit()
        except Exception as e:
            raise

    def borrar(self,id):
        sql = "delete from registro where id = {}".format(id)
        try:
            self.prueba.execute(sql)
            self.conexion.commit()
        except Exception as e:
            raise

    def cerrar(self):
        self.conexion.close()


basedat = BaseDatos()

adm = Administrador()
adm.Crear_empleado()
adm.Editar_empleado()
#adm.Eliminar_empleado(1)


