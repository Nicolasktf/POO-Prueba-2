from empleado.class_empleado import Empleado
import pymysql
import bcrypt

class Administrador(Empleado):
    def init(self, idEmpleado, idAdministrador, passwordAdministrador):
        super().init(idEmpleado)
        self.idAdministrador = idAdministrador
        self.passwordAdministrador = passwordAdministrador

    def Crear_empleado(self):
        self.conexion = pymysql.connect(
            host='localhost',
            user='root',
            password='',
            db='prueba'
        )
        self.prueba = self.conexion.cursor()
        print("Conexion bd correcta")


        id_empleado = int(input("Ingrese el ID del empleado: "))
        nombre = input("Ingrese el nombre del emleado: ")
        direccion = input("Ingrese la direccion del empleado: ")
        email = input("Ingrese el email del empleado: ")
        telefono = int(input("Ingrese el telefono del empleado: "))
        fecha_inicio_contrato = int(input("Ingrese la fecha del inicio del contrado del empleado: "))
        salario = float(input("Ingrese el salario del empleado: "))
        password_Empleado = input("Ingrese la contraseña del empleado: ")

        password_encode = password_Empleado.encode()
        salt = bcrypt.gensalt(12)
        password_hash = bcrypt.hashpw(password_encode, salt)


        cursor = "INSERT into empleado (id_empleado, nombre, direccion, email, telefono, fecha_inicio_contrato, salario, password_empleado) values ({}, '{}', '{}', '{}', {}, {}, {}, '{}')".format(id_empleado, nombre, direccion, email, telefono, fecha_inicio_contrato, salario,password_Empleado)
        try:
            self.prueba.execute(cursor)
            self.conexion.commit()
        except Exception as e:
            print("El valor ya existe",e)
            raise
        finally:
            self.conexion.close()

    def Editar_empleado(self):
        id_empleado = int(input("Ingrese el ID del empleado que desea actualizar: "))

        consulta = "SELECT * FROM empleado WHERE id_empleado={}".format(id_empleado)

        try:
            self.prueba.execute(consulta)
            resultado = self.prueba.fetchone()

            if resultado:
                nuevo_nombre = input("Ingrese el nuevo nombre del empleado: ")
                nueva_direccion = input("Ingrese la nueva dirección del empleado: ")
                nuevo_email = input("Ingrese el nuevo email del empleado: ")
                nuevo_telefono = input("Ingrese el nuevo teléfono del empleado: ")
                nueva_fecha_inicio_contrato = input("Ingrese la nueva fecha de inicio de contrato (YYYY-MM-DD): ")
                nuevo_salario = float(input("Ingrese el nuevo salario del empleado: "))
                nuevo_password = input("Ingrese la nueva contraseña del empleado: ")

                # Encriptamos la nueva contraseña
                password_encode = nuevo_password.encode()
                salt = bcrypt.gensalt(12)
                password_hash = bcrypt.hashpw(password_encode, salt)

                actualizar = """UPDATE empleado 
                                SET nombre='{}', direccion='{}', email='{}', telefono='{}', 
                                    fecha_inicio_contrato='{}', salario={}, password_empleado='{}'
                                WHERE id_empleado={}""".format(nuevo_nombre, nueva_direccion, nuevo_email, nuevo_telefono, nueva_fecha_inicio_contrato, nuevo_salario, password_hash.decode(), id_empleado)

                self.prueba.execute(actualizar)
                self.conexion.commit()
                print("Actualización completada")
            else:
                print(f"No existe un empleado con id_empleado={id_empleado}")

        except Exception as e:
            print(f"Error al actualizar: {e}")
            raise
        finally:
            self.conexion.close()


            #provando esta wea del githunaslkdasñldas

            print("hola mundo")

    #def Eliminar_empleado(self):

        #id_empleado = int(input("ingrese el id del empleado a eliminar: "))
        #sql = "DELETE FROM empleados where id_empleado = ".format(id_empleado)

        #try:
            #self.prueba.execute(sql)
            #self.conexion.commit()
        #except Exception as e:
            #raise