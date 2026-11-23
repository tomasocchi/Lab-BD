db = db.getSiblingDB("faibnb");

// -------------------------------------------------------------
// reserva  (colección principal)
// -------------------------------------------------------------
db.createCollection("reserva", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["codigo", "tipoReserva", "idCliente", "idAlojamiento",
               "fechaInicio", "fechaFin", "estado", "historialEstados"],
    properties: {
      codigo:        { bsonType: "string" },
      tipoReserva:   { enum: ["hotel", "particular"] },
      idCliente:     { bsonType: "int" },
      idAlojamiento: { bsonType: "int" },
      habitaciones:  { bsonType: "array", items: { bsonType: "int" } },
      configuracionHabitacion: { bsonType: "string" },
      fechaInicio:   { bsonType: "date" },
      fechaFin:      { bsonType: "date" },
      cantPersonas:  { bsonType: "int", minimum: 1 },
      precioTotal:   { bsonType: "int", minimum: 0 },
      estado:        { enum: ["Pendiente", "Aceptada", "Confirmada", "Rechazada", "Cancelada"] },
      historialEstados: {
        bsonType: "array",
        items: {
          bsonType: "object",
          required: ["estado", "fechaEstado"],
          properties: {
            estado:      { enum: ["Pendiente", "Aceptada", "Confirmada", "Rechazada", "Cancelada"] },
            fechaEstado: { bsonType: "date" }
          }
        }
      },
      pago: {
        bsonType: "object",
        required: ["senaPagada"],
        properties: {
          senaPagada:  { bsonType: "int", minimum: 0 },
          totalPagado: { bsonType: "int", minimum: 0 }
        }
      }
    }
  } },
  validationAction: "error"
});

// Índice único sobre la clave natural de la colección principal
db.reserva.createIndex({ codigo: 1 }, { unique: true });

// -------------------------------------------------------------
// usuario
// -------------------------------------------------------------
db.createCollection("usuario", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["tipoUsuario", "nroDni", "nombreCompleto", "fechaNacimiento"],
    properties: {
      tipoUsuario: { enum: ["cliente", "alojamiento"] },
      nroDni:      { bsonType: "int" },
      tipoDni:     { enum: ["DNI", "PAS", "CI", "LC"] },
      cuit:        { bsonType: "long" },
      nombreCompleto: {
        bsonType: "object",
        required: ["nombre", "apellido"],
        properties: {
          nombre:   { bsonType: "string" },
          apellido: { bsonType: "string" }
        }
      },
      correoElectronico: { bsonType: "string" },
      direccion:         { bsonType: "string" },
      fechaNacimiento:   { bsonType: "date" },
      fechaAlta:         { bsonType: "date" }
    }
  } },
  validationAction: "error"
});
db.usuario.createIndex({ nroDni: 1 }, { unique: true });

// -------------------------------------------------------------
// alojamiento
// -------------------------------------------------------------
db.createCollection("alojamiento", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["tipoAlojamiento", "nombre", "direccion", "idUsuario"],
    properties: {
      tipoAlojamiento: { enum: ["hotel", "particular"] },
      nombre:       { bsonType: "string" },
      descripcionA: { bsonType: "string" },
      imagenes:     { bsonType: "array", items: { bsonType: "string" } },
      direccion: {
        bsonType: "object",
        required: ["calle", "numero"],
        properties: {
          calle:  { bsonType: "string" },
          numero: { bsonType: "int" }
        }
      },
      locacion: {
        bsonType: "object",
        properties: {
          ciudad: { bsonType: "string" },
          pais:   { bsonType: "string" }
        }
      },
      cantCamas:      { bsonType: "int", minimum: 0 },
      idUsuario:      { bsonType: "int" },
      cantEstrellas:  { bsonType: "int", minimum: 1, maximum: 5 },
      tipoParticular: { enum: ["casa", "departamento", "cabaña"] },
      aptoMascotas:   { bsonType: "bool" },
      cantBanios:     { bsonType: "int", minimum: 0 },
      capacidad:      { bsonType: "int", minimum: 1 },
      precioPorNoche: { bsonType: "int", minimum: 20000 },
      habitaciones: {
        bsonType: "array",
        items: {
          bsonType: "object",
          required: ["idHabitacion", "tipoHabitacion", "precioPorNoche"],
          properties: {
            idHabitacion:   { bsonType: "int" },
            nroHabitacion:  { bsonType: "int" },
            tipoHabitacion: { enum: ["Simple", "Doble", "Suite", "Twin", "Triple", "Cuadruple"] },
            cantAmbientes:  { bsonType: "int" },
            precioPorNoche: { bsonType: "int", minimum: 20000 },
            capacidad:      { bsonType: "int", minimum: 1 }
          }
        }
      }
    }
  } },
  validationAction: "error"
});

// -------------------------------------------------------------
// mensajeria
// -------------------------------------------------------------
db.createCollection("mensajeria", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["idCliente", "idUsuarioAlojamiento", "mensajes"],
    properties: {
      idCliente:            { bsonType: "int" },
      idUsuarioAlojamiento: { bsonType: "int" },
      idReserva:            { bsonType: "int" },
      mensajes: {
        bsonType: "array",
        items: {
          bsonType: "object",
          required: ["idMensaje", "mensaje"],
          properties: {
            idMensaje: { bsonType: "int" },
            mensaje:   { bsonType: "string" }
          }
        }
      }
    }
  } },
  validationAction: "error"
});

// -------------------------------------------------------------
// reseña
// -------------------------------------------------------------
db.createCollection("reseña", {
  validator: { $jsonSchema: {
    bsonType: "object",
    required: ["tipoReseña", "idReserva", "idCliente", "idUsuarioAlojamiento", "items"],
    properties: {
      tipoReseña:           { enum: ["cliente", "alojamiento"] },
      idReserva:            { bsonType: "int" },
      idCliente:            { bsonType: "int" },
      idUsuarioAlojamiento: { bsonType: "int" },
      calificacionGeneral:  { bsonType: "int", minimum: 1, maximum: 5 },
      descripcion:          { bsonType: "string" },
      items: {
        bsonType: "array",
        items: {
          bsonType: "object",
          required: ["tipoItem", "calificacion"],
          properties: {
            idItem:       { bsonType: "int" },
            tipoItem:     { bsonType: "string" },
            calificacion: { bsonType: "int", minimum: 1, maximum: 5 },
            descripcion:  { bsonType: "string" }
          }
        }
      }
    }
  } },
  validationAction: "error"
});

// -------------------------------------------------------------
// verificamos
// -------------------------------------------------------------
print("Colecciones creadas: " + db.getCollectionNames().join(", "));
printjson(db.reserva.getIndexes());

