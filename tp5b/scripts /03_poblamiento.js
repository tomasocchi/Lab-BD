

db = db.getSiblingDB("faibnb");

// Enteros como int32 (por si el validador pide bsonType "int")
const I = n => NumberInt(n);

// -------------------------------------------------------------
// usuario  (8 documentos, pauta 9 con tipoUsuario)
// Persona = usuario   Rol específico = tipoUsuario
// -------------------------------------------------------------
db.usuario.insertMany([
  // Clientes
  { _id: I(1), tipoUsuario: "cliente", nroDni: I(40111222), tipoDni: "DNI",
    nombreCompleto: { nombre: "Martina", apellido: "Gomez" },
    correoElectronico: "martina.gomez@mail.com", direccion: "Belgrano 120",
    fechaNacimiento: new Date("1998-04-12"), fechaAlta: new Date("2024-03-01") },
  { _id: I(2), tipoUsuario: "cliente", nroDni: I(38555666), tipoDni: "DNI",
    nombreCompleto: { nombre: "Mateo", apellido: "Fernandez" },
    correoElectronico: "mateo.f@mail.com", direccion: "Rivadavia 455",
    fechaNacimiento: new Date("1995-09-03"), fechaAlta: new Date("2024-06-15") },
  { _id: I(3), tipoUsuario: "cliente", nroDni: I(44777888), tipoDni: "DNI",
    nombreCompleto: { nombre: "Micaela", apellido: "Torres" },
    correoElectronico: "mica.torres@mail.com", direccion: "Sarmiento 78",
    fechaNacimiento: new Date("2002-01-20"), fechaAlta: new Date("2025-02-10") },
  { _id: I(4), tipoUsuario: "cliente", nroDni: I(35222333), tipoDni: "DNI",
    nombreCompleto: { nombre: "Lucas", apellido: "Perez" },
    correoElectronico: "lucas.perez@mail.com", direccion: "Mitre 900",
    fechaNacimiento: new Date("1990-06-15"), fechaAlta: new Date("2023-11-20") },
  { _id: I(5), tipoUsuario: "cliente", nroDni: I(45999000), tipoDni: "DNI",
    nombreCompleto: { nombre: "Sofia", apellido: "Diaz" },
    correoElectronico: "sofi.diaz@mail.com", direccion: "Alem 33",
    fechaNacimiento: new Date("2003-11-02"), fechaAlta: new Date("2025-08-05") },
  // Propietarios (usuario alojamiento)
  { _id: I(6), tipoUsuario: "alojamiento", nroDni: I(28444555), tipoDni: "DNI",
    cuit: NumberLong("20284445553"),
    nombreCompleto: { nombre: "Marcos", apellido: "Sosa" },
    correoElectronico: "marcos.sosa@mail.com", direccion: "Av. Argentina 1500",
    fechaNacimiento: new Date("1985-03-10") },
  { _id: I(7), tipoUsuario: "alojamiento", nroDni: I(22333444), tipoDni: "DNI",
    cuit: NumberLong("27223334448"),
    nombreCompleto: { nombre: "Laura", apellido: "Benitez" },
    correoElectronico: "laura.b@mail.com", direccion: "Olascoaga 250",
    fechaNacimiento: new Date("1978-07-22") },
  { _id: I(8), tipoUsuario: "alojamiento", nroDni: I(36111000), tipoDni: "DNI",
    cuit: NumberLong("20361110009"),
    nombreCompleto: { nombre: "Diego", apellido: "Romero" },
    correoElectronico: "diego.romero@mail.com", direccion: "Roca 610",
    fechaNacimiento: new Date("1992-12-05") }
]);

// -------------------------------------------------------------
// alojamiento  (6 documentos, unión con tipoAlojamiento)
// Habitaciones embebidas en los hoteles (pauta 1)
// -------------------------------------------------------------
db.alojamiento.insertMany([
  { _id: I(101), tipoAlojamiento: "hotel", nombre: "Hotel del Lago",
    descripcionA: "Hotel frente al lago con desayuno incluido",
    imagenes: ["lago1.jpg", "lago2.jpg"],
    direccion: { calle: "Costanera", numero: I(200) },
    locacion: { ciudad: "Villa La Angostura", pais: "Argentina" },
    cantCamas: I(12), idUsuario: I(6), cantEstrellas: I(4),
    habitaciones: [
      { idHabitacion: I(1), nroHabitacion: I(101), tipoHabitacion: "Doble",  cantAmbientes: I(1), precioPorNoche: I(45000), capacidad: I(2) },
      { idHabitacion: I(2), nroHabitacion: I(102), tipoHabitacion: "Suite",  cantAmbientes: I(2), precioPorNoche: I(90000), capacidad: I(3) },
      { idHabitacion: I(3), nroHabitacion: I(201), tipoHabitacion: "Simple", cantAmbientes: I(1), precioPorNoche: I(30000), capacidad: I(1) }
    ] },
  { _id: I(102), tipoAlojamiento: "hotel", nombre: "Hotel Patagonia",
    descripcionA: "Hotel céntrico cerca de la terminal",
    imagenes: ["patagonia1.jpg"],
    direccion: { calle: "Av. Argentina", numero: I(850) },
    locacion: { ciudad: "Neuquen", pais: "Argentina" },
    cantCamas: I(8), idUsuario: I(7), cantEstrellas: I(3),
    habitaciones: [
      { idHabitacion: I(1), nroHabitacion: I(10), tipoHabitacion: "Twin",   cantAmbientes: I(1), precioPorNoche: I(38000), capacidad: I(2) },
      { idHabitacion: I(2), nroHabitacion: I(11), tipoHabitacion: "Triple", cantAmbientes: I(1), precioPorNoche: I(52000), capacidad: I(3) }
    ] },
  { _id: I(103), tipoAlojamiento: "particular", nombre: "Cabaña Los Pinos",
    descripcionA: "Cabaña en el bosque con parrilla",
    imagenes: ["pinos1.jpg", "pinos2.jpg", "pinos3.jpg"],
    direccion: { calle: "Los Coihues", numero: I(15) },
    locacion: { ciudad: "San Martin de los Andes", pais: "Argentina" },
    cantCamas: I(4), idUsuario: I(6),
    tipoParticular: "cabaña", aptoMascotas: true, cantBanios: I(1), capacidad: I(4), precioPorNoche: I(60000) },
  { _id: I(104), tipoAlojamiento: "particular", nombre: "Depto Centro",
    descripcionA: "Departamento a dos cuadras de la peatonal",
    imagenes: ["depto1.jpg"],
    direccion: { calle: "San Martin", numero: I(320) },
    locacion: { ciudad: "Neuquen", pais: "Argentina" },
    cantCamas: I(2), idUsuario: I(7),
    tipoParticular: "departamento", aptoMascotas: false, cantBanios: I(1), capacidad: I(2), precioPorNoche: I(35000) },
  { _id: I(105), tipoAlojamiento: "particular", nombre: "Casa del Rio",
    descripcionA: "Casa con jardín sobre el río Limay",
    imagenes: ["rio1.jpg", "rio2.jpg"],
    direccion: { calle: "Ribera", numero: I(44) },
    locacion: { ciudad: "Plottier", pais: "Argentina" },
    cantCamas: I(6), idUsuario: I(8),
    tipoParticular: "casa", aptoMascotas: true, cantBanios: I(2), capacidad: I(6), precioPorNoche: I(80000) },
  { _id: I(106), tipoAlojamiento: "hotel", nombre: "Hotel Cordillera",
    descripcionA: "Hotel de montaña con spa",
    imagenes: ["cordillera1.jpg"],
    direccion: { calle: "Ruta 40", numero: I(1200) },
    locacion: { ciudad: "Bariloche", pais: "Argentina" },
    cantCamas: I(20), idUsuario: I(8), cantEstrellas: I(5),
    habitaciones: [
      { idHabitacion: I(1), nroHabitacion: I(1),  tipoHabitacion: "Doble",     cantAmbientes: I(1), precioPorNoche: I(70000),  capacidad: I(2) },
      { idHabitacion: I(2), nroHabitacion: I(2),  tipoHabitacion: "Cuadruple", cantAmbientes: I(2), precioPorNoche: I(120000), capacidad: I(4) }
    ] }
]);

// -------------------------------------------------------------
// reserva  (12 documentos, colección principal, tipoReserva)
// historialEstados embebido (pauta 6), pago embebido (pauta 2)
// Registro especial = reserva de hotel
// -------------------------------------------------------------
db.reserva.insertMany([
  // Canceladas con 1 año o más de antigüedad (aparecen en C.1)
  { _id: I(1001), codigo: "R0001", tipoReserva: "particular", idCliente: I(1), idAlojamiento: I(103),
    fechaInicio: new Date("2024-07-10"), fechaFin: new Date("2024-07-14"),
    cantPersonas: I(3), precioTotal: I(240000), estado: "Cancelada",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2024-06-01") },
      { estado: "Aceptada",  fechaEstado: new Date("2024-06-01") },
      { estado: "Cancelada", fechaEstado: new Date("2024-06-20") } ] },
  { _id: I(1002), codigo: "R0002", tipoReserva: "hotel", idCliente: I(4), idAlojamiento: I(101),
    habitaciones: [I(1)], configuracionHabitacion: "Una doble",
    fechaInicio: new Date("2025-02-05"), fechaFin: new Date("2025-02-08"),
    cantPersonas: I(2), precioTotal: I(135000), estado: "Cancelada",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2025-01-10") },
      { estado: "Aceptada",  fechaEstado: new Date("2025-01-11") },
      { estado: "Cancelada", fechaEstado: new Date("2025-01-20") } ] },

  // Canceladas recientes (NO aparecen en C.1)
  { _id: I(1003), codigo: "R0003", tipoReserva: "particular", idCliente: I(2), idAlojamiento: I(105),
    fechaInicio: new Date("2026-06-10"), fechaFin: new Date("2026-06-15"),
    cantPersonas: I(5), precioTotal: I(400000), estado: "Cancelada",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2026-05-02") },
      { estado: "Aceptada",  fechaEstado: new Date("2026-05-02") },
      { estado: "Cancelada", fechaEstado: new Date("2026-05-25") } ] },
  { _id: I(1004), codigo: "R0004", tipoReserva: "hotel", idCliente: I(5), idAlojamiento: I(102),
    habitaciones: [I(2)], configuracionHabitacion: "Una triple",
    fechaInicio: new Date("2026-09-01"), fechaFin: new Date("2026-09-03"),
    cantPersonas: I(3), precioTotal: I(104000), estado: "Cancelada",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2026-08-10") },
      { estado: "Aceptada",  fechaEstado: new Date("2026-08-10") },
      { estado: "Cancelada", fechaEstado: new Date("2026-08-15") } ] },

  // Confirmadas con pago
  { _id: I(1005), codigo: "R0005", tipoReserva: "particular", idCliente: I(1), idAlojamiento: I(104),
    fechaInicio: new Date("2025-12-20"), fechaFin: new Date("2025-12-27"),
    cantPersonas: I(2), precioTotal: I(245000), estado: "Confirmada",
    historialEstados: [
      { estado: "Pendiente",  fechaEstado: new Date("2025-11-01") },
      { estado: "Aceptada",   fechaEstado: new Date("2025-11-01") },
      { estado: "Confirmada", fechaEstado: new Date("2025-11-03") } ],
    pago: { senaPagada: I(49000), totalPagado: I(245000) } },
  { _id: I(1006), codigo: "R0006", tipoReserva: "hotel", idCliente: I(2), idAlojamiento: I(101),
    habitaciones: [I(1), I(2)], configuracionHabitacion: "Una doble y una suite",
    fechaInicio: new Date("2026-01-15"), fechaFin: new Date("2026-01-20"),
    cantPersonas: I(5), precioTotal: I(675000), estado: "Confirmada",
    historialEstados: [
      { estado: "Pendiente",  fechaEstado: new Date("2025-12-10") },
      { estado: "Aceptada",   fechaEstado: new Date("2025-12-10") },
      { estado: "Confirmada", fechaEstado: new Date("2025-12-12") } ],
    pago: { senaPagada: I(135000), totalPagado: I(675000) } },
  { _id: I(1012), codigo: "R0012", tipoReserva: "particular", idCliente: I(3), idAlojamiento: I(105),
    fechaInicio: new Date("2026-03-10"), fechaFin: new Date("2026-03-14"),
    cantPersonas: I(4), precioTotal: I(320000), estado: "Confirmada",
    historialEstados: [
      { estado: "Pendiente",  fechaEstado: new Date("2026-02-01") },
      { estado: "Aceptada",   fechaEstado: new Date("2026-02-01") },
      { estado: "Confirmada", fechaEstado: new Date("2026-02-03") } ],
    pago: { senaPagada: I(64000), totalPagado: I(320000) } },

  // Rechazada
  { _id: I(1010), codigo: "R0010", tipoReserva: "particular", idCliente: I(2), idAlojamiento: I(104),
    fechaInicio: new Date("2025-08-01"), fechaFin: new Date("2025-08-05"),
    cantPersonas: I(2), precioTotal: I(140000), estado: "Rechazada",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2025-07-10") },
      { estado: "Rechazada", fechaEstado: new Date("2025-07-11") } ] },

  // Esta semana (16 al 22 de noviembre de 2026)
  // 1008 es el registro especial (hotel) que se borra en C.3
  { _id: I(1008), codigo: "R0008", tipoReserva: "hotel", idCliente: I(4), idAlojamiento: I(106),
    habitaciones: [I(1)], configuracionHabitacion: "Una doble",
    fechaInicio: new Date("2026-11-18"), fechaFin: new Date("2026-11-20"),
    cantPersonas: I(2), precioTotal: I(140000), estado: "Aceptada",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2026-11-10") },
      { estado: "Aceptada",  fechaEstado: new Date("2026-11-10") } ] },
  // 1009 es de esta semana pero particular, NO debe borrarse en C.3
  { _id: I(1009), codigo: "R0009", tipoReserva: "particular", idCliente: I(5), idAlojamiento: I(105),
    fechaInicio: new Date("2026-11-19"), fechaFin: new Date("2026-11-22"),
    cantPersonas: I(4), precioTotal: I(240000), estado: "Confirmada",
    historialEstados: [
      { estado: "Pendiente",  fechaEstado: new Date("2026-11-01") },
      { estado: "Aceptada",   fechaEstado: new Date("2026-11-01") },
      { estado: "Confirmada", fechaEstado: new Date("2026-11-02") } ],
    pago: { senaPagada: I(48000), totalPagado: I(48000) } },

  // Pendientes a futuro
  { _id: I(1007), codigo: "R0007", tipoReserva: "particular", idCliente: I(3), idAlojamiento: I(103),
    fechaInicio: new Date("2026-12-05"), fechaFin: new Date("2026-12-08"),
    cantPersonas: I(2), precioTotal: I(180000), estado: "Pendiente",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2026-11-15") } ] },
  { _id: I(1011), codigo: "R0011", tipoReserva: "hotel", idCliente: I(1), idAlojamiento: I(106),
    habitaciones: [I(2)], configuracionHabitacion: "Una cuadruple",
    fechaInicio: new Date("2026-12-20"), fechaFin: new Date("2026-12-24"),
    cantPersonas: I(4), precioTotal: I(480000), estado: "Pendiente",
    historialEstados: [
      { estado: "Pendiente", fechaEstado: new Date("2026-11-14") } ] }
]);

// -------------------------------------------------------------
// mensajeria  (6 documentos, colección propia, pauta 11)
// La 6 no tiene reserva porque es una consulta previa
// -------------------------------------------------------------
db.mensajeria.insertMany([
  { _id: I(1), idCliente: I(1), idUsuarioAlojamiento: I(7), idReserva: I(1005),
    mensajes: [ { idMensaje: I(1), mensaje: "Hola, a que hora es el check in?" },
                { idMensaje: I(2), mensaje: "A partir de las 14 hs" } ] },
  { _id: I(2), idCliente: I(2), idUsuarioAlojamiento: I(6), idReserva: I(1006),
    mensajes: [ { idMensaje: I(1), mensaje: "Las habitaciones quedan juntas?" },
                { idMensaje: I(2), mensaje: "Si, estan en el mismo piso" } ] },
  { _id: I(3), idCliente: I(3), idUsuarioAlojamiento: I(6), idReserva: I(1007),
    mensajes: [ { idMensaje: I(1), mensaje: "La cabaña tiene calefaccion?" } ] },
  { _id: I(4), idCliente: I(4), idUsuarioAlojamiento: I(8), idReserva: I(1008),
    mensajes: [ { idMensaje: I(1), mensaje: "Incluye desayuno?" },
                { idMensaje: I(2), mensaje: "Si, de 7 a 10 hs" } ] },
  { _id: I(5), idCliente: I(5), idUsuarioAlojamiento: I(8), idReserva: I(1009),
    mensajes: [ { idMensaje: I(1), mensaje: "Puedo llevar a mi perro?" },
                { idMensaje: I(2), mensaje: "Si, la casa es apta mascotas" } ] },
  { _id: I(6), idCliente: I(1), idUsuarioAlojamiento: I(8),
    mensajes: [ { idMensaje: I(1), mensaje: "Hay disponibilidad para enero?" } ] }
]);

// -------------------------------------------------------------
// reseña  (6 documentos, tipoReseña, items embebidos)
// Solo de reservas ya realizadas (1005, 1006 y 1012)
// -------------------------------------------------------------
db.reseña.insertMany([
  { _id: I(1), tipoReseña: "alojamiento", idReserva: I(1005), idCliente: I(1), idUsuarioAlojamiento: I(7),
    calificacionGeneral: I(5),
    items: [ { idItem: I(1), tipoItem: "limpieza",  calificacion: I(5), descripcion: "Impecable" },
             { idItem: I(2), tipoItem: "ubicacion", calificacion: I(5), descripcion: "Muy centrico" } ] },
  { _id: I(2), tipoReseña: "cliente", idReserva: I(1005), idCliente: I(1), idUsuarioAlojamiento: I(7),
    calificacionGeneral: I(5), descripcion: "Huesped muy respetuosa",
    items: [ { idItem: I(1), tipoItem: "cuidado", calificacion: I(5), descripcion: "Dejo todo ordenado" } ] },
  { _id: I(3), tipoReseña: "alojamiento", idReserva: I(1006), idCliente: I(2), idUsuarioAlojamiento: I(6),
    calificacionGeneral: I(4),
    items: [ { idItem: I(1), tipoItem: "atencion", calificacion: I(4), descripcion: "Buena atencion" },
             { idItem: I(2), tipoItem: "limpieza", calificacion: I(3), descripcion: "Podria mejorar" } ] },
  { _id: I(4), tipoReseña: "cliente", idReserva: I(1006), idCliente: I(2), idUsuarioAlojamiento: I(6),
    calificacionGeneral: I(4), descripcion: "Grupo tranquilo",
    items: [ { idItem: I(1), tipoItem: "puntualidad", calificacion: I(4), descripcion: "Llego a horario" } ] },
  { _id: I(5), tipoReseña: "alojamiento", idReserva: I(1012), idCliente: I(3), idUsuarioAlojamiento: I(8),
    calificacionGeneral: I(5),
    items: [ { idItem: I(1), tipoItem: "ubicacion", calificacion: I(5), descripcion: "Vista al rio" } ] },
  { _id: I(6), tipoReseña: "cliente", idReserva: I(1012), idCliente: I(3), idUsuarioAlojamiento: I(8),
    calificacionGeneral: I(3), descripcion: "Dejo la casa algo desordenada",
    items: [ { idItem: I(1), tipoItem: "cuidado", calificacion: I(3), descripcion: "Faltaba ordenar la cocina" } ] }
]);

// -------------------------------------------------------------
// p verificar
// -------------------------------------------------------------
print("usuario:     " + db.usuario.countDocuments());
print("alojamiento: " + db.alojamiento.countDocuments());
print("reserva:     " + db.reserva.countDocuments());
print("mensajeria:  " + db.mensajeria.countDocuments());
print("reseña:      " + db.reseña.countDocuments());

