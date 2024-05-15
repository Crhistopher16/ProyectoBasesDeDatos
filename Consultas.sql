use [GESTIONASOCEBU];

-- Consulta para mostrar los tickets en la web
-- EXEC [dbo].[spConsultarTickets];

SELECT t.idTicket, t.FhInicio, d.Descripcion, t.Detalles, e.NombreEmpleado, t.idEstado, tip.Tiempo, tip.Tipo, a.CodigoRadDpto, 
(SELECT eAsig.NombreEmpleado FROM [WEB].[dbo].[Empleados] eAsig
INNER JOIN [WEB].[dbo].[Usuarios] uAsig ON eAsig.IdEmpleado = uAsig.IdEmpleado
WHERE t.IdUsuarioAsignado collate Modern_Spanish_CI_AS = uAsig.LoginUsuario) AS NombreAsignado
FROM Ticket t
LEFT JOIN [GESTIONASOCEBU].[dbo].[Descripcion] d ON t.IdDescripcion = d.IdDescripcion
LEFT JOIN [GESTIONASOCEBU].[dbo].[Tipo] tip ON d.IdTipo = tip.IdTipo
LEFT JOIN [WEB].[dbo].[Usuarios] u ON t.IdUsuarioSolicita collate Modern_Spanish_CI_AS = u.LoginUsuario
LEFT JOIN [WEB].[dbo].[Empleados] e ON u.IdEmpleado = e.IdEmpleado
LEFT JOIN [WEB].[dbo].[RadicacionDptos] a ON tip.idArea = a.IdRadDpto;

-- Consulta para mostrar todos los usuarios activos en la web

SELECT e.CodigoEmpleado, u.EstadoUsuario, e.NombreEmpleado, e.IdentieEmpleado, a.CodigoRadDpto, e.EmailEmpleado, e.CargoEmpleado from [WEB].[dbo].[Usuarios] u 
INNER JOIN [WEB].[dbo].Empleados e ON u.IdEmpleado = e.IdEmpleado
INNER JOIN [WEB].[dbo].[RadicacionDptos] a ON e.IdRadDpto = a.IdRadDpto
WHERE u.EstadoUsuario = 'A'
ORDER BY e.NombreEmpleado ASC;

-- Consulta para mostrar usuarios por login en la web

SELECT e.CodigoEmpleado, u.EstadoUsuario, e.NombreEmpleado, e.IdentieEmpleado, a.CodigoRadDpto, e.EmailEmpleado, e.CargoEmpleado from [WEB].[dbo].[Usuarios] u 
INNER JOIN [WEB].[dbo].Empleados e ON u.IdEmpleado = e.IdEmpleado
INNER JOIN [WEB].[dbo].[RadicacionDptos] a ON e.IdRadDpto = a.IdRadDpto
WHERE e.CodigoEmpleado = 'MMM';


-- Consulta para mostrar el histórico de requerimientos de ASONET en la web

SELECT idconsecutivo, fecha, solicitudusuario, escaladousuario, tipo, proceso, tiempo, referencia, descripcion, fechasolucionado, solucionado, descripcioncerrado, fechacerrado, estado
from [GESTIONASOCEBU].[dbo].Requerimientos
WHERE estado = 'CERRADO'
ORDER BY idconsecutivo DESC;

-- Asignación de tickets en la web

UPDATE [GESTIONASOCEBU].[dbo].ticket
SET
IdUsuarioAsignado = 'WAH',
FhAsignacion = '2024-01-26 11:39:00.720'
WHERE IdTicket = 1;

-- Traer Usuarios por Area en la web

SELECT e.CodigoEmpleado, u.EstadoUsuario, e.NombreEmpleado, e.IdentieEmpleado, a.CodigoRadDpto, e.EmailEmpleado, e.CargoEmpleado
FROM [WEB].[dbo].[Usuarios] u 
INNER JOIN [WEB].[dbo].Empleados e ON u.IdEmpleado = e.IdEmpleado
INNER JOIN [WEB].[dbo].[RadicacionDptos] a ON e.IdRadDpto = a.IdRadDpto
WHERE a.IdRadDpto = 1 AND u.EstadoUsuario = 'A'
ORDER BY e.NombreEmpleado ASC;

-- Traer Tickets asignados al Usuario - Trae área y Nombre del usuario Asignado
-- EXEC [dbo].[spConsultarTicketsUsuAsig] @IdUsuarioAsignado = 'MMM';

SELECT t.idTicket, t.FhInicio, d.Descripcion, t.Detalles, e.NombreEmpleado, t.idEstado, tip.Tiempo, tip.Tipo, a.CodigoRadDpto,
(SELECT eAsig.NombreEmpleado FROM [WEB].[dbo].[Empleados] eAsig
INNER JOIN [WEB].[dbo].[Usuarios] uAsig ON eAsig.IdEmpleado = uAsig.IdEmpleado
WHERE t.IdUsuarioAsignado collate Modern_Spanish_CI_AS = uAsig.LoginUsuario) AS NombreAsignado
FROM Ticket t
LEFT JOIN [GESTIONASOCEBU].[dbo].[Descripcion] d ON t.IdDescripcion = d.IdDescripcion
LEFT JOIN [GESTIONASOCEBU].[dbo].[Tipo] tip ON d.IdTipo = tip.IdTipo
LEFT JOIN [WEB].[dbo].[Usuarios] u ON t.IdUsuarioSolicita collate Modern_Spanish_CI_AS = u.LoginUsuario
LEFT JOIN [WEB].[dbo].[Empleados] e ON u.IdEmpleado = e.IdEmpleado
LEFT JOIN [WEB].[dbo].[RadicacionDptos] a ON tip.idArea = a.IdRadDpto
WHERE t.IdUsuarioAsignado= 'MMM';

-- Traer Tickets sin asignar
-- EXEC [dbo].[spConsultarTicketsSinAsig];

SELECT t.idTicket, t.FhInicio, d.Descripcion, t.Detalles, e.NombreEmpleado, t.idEstado, tip.Tiempo, tip.Tipo, a.CodigoRadDpto,
(SELECT eAsig.NombreEmpleado FROM [WEB].[dbo].[Empleados] eAsig
INNER JOIN [WEB].[dbo].[Usuarios] uAsig ON eAsig.IdEmpleado = uAsig.IdEmpleado
WHERE t.IdUsuarioAsignado collate Modern_Spanish_CI_AS = uAsig.LoginUsuario) AS NombreAsignado
FROM Ticket t
LEFT JOIN [GESTIONASOCEBU].[dbo].[Descripcion] d ON t.IdDescripcion = d.IdDescripcion
LEFT JOIN [GESTIONASOCEBU].[dbo].[Tipo] tip ON d.IdTipo = tip.IdTipo
LEFT JOIN [WEB].[dbo].[Usuarios] u ON t.IdUsuarioSolicita collate Modern_Spanish_CI_AS = u.LoginUsuario
LEFT JOIN [WEB].[dbo].[Empleados] e ON u.IdEmpleado = e.IdEmpleado
LEFT JOIN [WEB].[dbo].[RadicacionDptos] a ON tip.idArea = a.IdRadDpto
WHERE t.IdUsuarioAsignado IS NULL;

-- Traer Tickets por idTicket
-- EXEC spConsultarTicketPorId @idTicket = "2";

SELECT t.idTicket, t.FhInicio, d.Descripcion, t.Detalles, e.NombreEmpleado, t.idEstado, tip.Tiempo, tip.Tipo, a.CodigoRadDpto,
(SELECT eAsig.NombreEmpleado FROM [WEB].[dbo].[Empleados] eAsig
INNER JOIN [WEB].[dbo].[Usuarios] uAsig ON eAsig.IdEmpleado = uAsig.IdEmpleado
WHERE t.IdUsuarioAsignado collate Modern_Spanish_CI_AS = uAsig.LoginUsuario) AS NombreAsignado
FROM Ticket t
LEFT JOIN [GESTIONASOCEBU].[dbo].[Descripcion] d ON t.IdDescripcion = d.IdDescripcion
LEFT JOIN [GESTIONASOCEBU].[dbo].[Tipo] tip ON d.IdTipo = tip.IdTipo
LEFT JOIN [WEB].[dbo].[Usuarios] u ON t.IdUsuarioSolicita collate Modern_Spanish_CI_AS = u.LoginUsuario
LEFT JOIN [WEB].[dbo].[Empleados] e ON u.IdEmpleado = e.IdEmpleado
LEFT JOIN [WEB].[dbo].[RadicacionDptos] a ON tip.idArea = a.IdRadDpto
WHERE t.idticket = '2';

-- Traer correo del area del usuario

SELECT a.correo FROM [WEB].[dbo].[Empleados] e
INNER JOIN [WEB].[dbo].[RadicacionDptos] r ON e.IdRadDpto = r.IdRadDpto
INNER JOIN [GESTIONASOCEBU].[dbo].[Areas] a ON r.CodigoRadDpto collate Modern_Spanish_CI_AS = a.descrip
WHERE e.CodigoEmpleado = 'MMM'

-- Traer login de usuario por nombre del usuario

SELECT CodigoEmpleado FROM [WEB].[dbo].[Empleados] e
WHERE NombreEmpleado = 'MIGUEL MIRANDA MARTINEZ'


SELECT * FROM [GESTIONASOCEBU].[dbo].[CuerpoTicket];
delete from CuerpoTicket where idCuerpo between 1 AND 12;

select * FROM [WEB].[dbo].[Usuarios];
select * from Areas;
SELECT * FROM [WEB].[dbo].[Empleados];
select * from [WEB].[dbo].[RadicacionDptos];
SELECT * FROM Tipo;
update Ticket set IdUsuarioAsignado = NULL where idTicket =3;


EXEC [dbo].[spConsultarTickets];