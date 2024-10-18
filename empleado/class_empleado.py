import bcrypt
class Empleado:

    def init(self,idEmpleado, nombreEmpleado,dirEmpleado,telefono,email,fechaIniContrato,salarioEmpleado,passwordEmpleado):
        #atributos
        self.idEmpleado = idEmpleado
        self.nombreEmpleado = nombreEmpleado
        self.dirEmpleado = dirEmpleado
        self.telefono = telefono
        self.email = email
        self.fechaIniContrato = fechaIniContrato
        self.salarioEmpleado = salarioEmpleado
        self.passwordEmpleado = passwordEmpleado

    def password(self):
        contraseña = input("Ingresa tu contraseña: ")
        contraseña_encode = contraseña.encode()

        salt = bcrypt.gensalt(12)

        contraseña_hash = bcrypt.hashpw(contraseña_encode, salt)
        print(contraseña_hash)



