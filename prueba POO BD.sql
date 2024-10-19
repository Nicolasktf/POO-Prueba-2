-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-10-2024 a las 00:10:31
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `prueba`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_administrador` int(11) NOT NULL,
  `idemp` int(11) NOT NULL,
  `password_admin` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `id_departamento` int(11) NOT NULL,
  `password_depto` varchar(10) NOT NULL,
  `id_gerente` int(11) NOT NULL,
  `id_emp` int(11) NOT NULL,
  `id_admin` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `telefono` int(11) NOT NULL,
  `fecha_inicio_contrato` int(11) NOT NULL,
  `salario` float NOT NULL,
  `password_empleado` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gerente`
--

CREATE TABLE `gerente` (
  `id_gerente` int(11) NOT NULL,
  `password_gerente` varchar(10) NOT NULL,
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `informe`
--

CREATE TABLE `informe` (
  `idinforme` int(11) NOT NULL,
  `ideempleado` int(11) NOT NULL,
  `iddepto` int(11) NOT NULL,
  `idregistros` int(11) NOT NULL,
  `id_proyecto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proyecto`
--

CREATE TABLE `proyecto` (
  `id_proyecto` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `fecha_inicio` int(11) NOT NULL,
  `password_proyecto` varchar(10) NOT NULL,
  `idemp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_tiempo`
--

CREATE TABLE `registro_tiempo` (
  `id_registro_tiempo` int(11) NOT NULL,
  `fecha` int(11) NOT NULL,
  `hrs_trabajadas` int(11) NOT NULL,
  `desc_tarea` varchar(100) NOT NULL,
  `idproyecto` int(11) NOT NULL,
  `idemp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_administrador`),
  ADD KEY `idemp_idx` (`idemp`);

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`id_departamento`),
  ADD KEY `idemp_idx` (`id_emp`),
  ADD KEY `idgerente_idx` (`id_gerente`),
  ADD KEY `idadmin_idx` (`id_admin`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`);

--
-- Indices de la tabla `gerente`
--
ALTER TABLE `gerente`
  ADD PRIMARY KEY (`id_gerente`),
  ADD KEY `id_empleado_idx` (`id_empleado`);

--
-- Indices de la tabla `informe`
--
ALTER TABLE `informe`
  ADD PRIMARY KEY (`idinforme`),
  ADD KEY `idempl_idx` (`ideempleado`),
  ADD KEY `idproyect_idx` (`id_proyecto`),
  ADD KEY `iddepto_idx` (`iddepto`),
  ADD KEY `idregistro_idx` (`idregistros`);

--
-- Indices de la tabla `proyecto`
--
ALTER TABLE `proyecto`
  ADD PRIMARY KEY (`id_proyecto`),
  ADD KEY `idempl_idx` (`idemp`);

--
-- Indices de la tabla `registro_tiempo`
--
ALTER TABLE `registro_tiempo`
  ADD PRIMARY KEY (`id_registro_tiempo`),
  ADD KEY `ideemp_idx` (`idemp`),
  ADD KEY `idproyecto_idx` (`idproyecto`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `idempleado` FOREIGN KEY (`idemp`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD CONSTRAINT `idadmin` FOREIGN KEY (`id_admin`) REFERENCES `administrador` (`id_administrador`),
  ADD CONSTRAINT `idemp` FOREIGN KEY (`id_emp`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `idgerente` FOREIGN KEY (`id_gerente`) REFERENCES `gerente` (`id_gerente`);

--
-- Filtros para la tabla `gerente`
--
ALTER TABLE `gerente`
  ADD CONSTRAINT `id_empleado` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `informe`
--
ALTER TABLE `informe`
  ADD CONSTRAINT `iddepto` FOREIGN KEY (`iddepto`) REFERENCES `departamento` (`id_departamento`),
  ADD CONSTRAINT `idemple` FOREIGN KEY (`ideempleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `idproyectoo` FOREIGN KEY (`id_proyecto`) REFERENCES `proyecto` (`id_proyecto`),
  ADD CONSTRAINT `idregistro` FOREIGN KEY (`idregistros`) REFERENCES `registro_tiempo` (`id_registro_tiempo`);

--
-- Filtros para la tabla `proyecto`
--
ALTER TABLE `proyecto`
  ADD CONSTRAINT `idempl` FOREIGN KEY (`idemp`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `registro_tiempo`
--
ALTER TABLE `registro_tiempo`
  ADD CONSTRAINT `ideemp` FOREIGN KEY (`idemp`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `idproyecto` FOREIGN KEY (`idproyecto`) REFERENCES `proyecto` (`id_proyecto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
