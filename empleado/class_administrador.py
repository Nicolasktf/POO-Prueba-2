from empleado.class_empleado import Empleado

class Administrador(Empleado):
    def init(self, idEmpleado, idAdministrador, passwordAdministrador):
        super().init(idEmpleado)
        self.idAdministrador = idAdministrador
        self.passwordAdministrador = passwordAdministrador

    def Crear_empleado(self):
        nombreEmpleado