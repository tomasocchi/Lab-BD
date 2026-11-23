const I = (n) => NumberInt(n)

// transaccion compromiso exitoso
const sesion = db.getMongo().startSession()
const bd = sesion.getDatabase("faibnb")
sesion.startTransaction({ readConcern: { level: "snapshot" }, writeConcern: { w: "majority" } })
try {
  bd.reserva.insertOne(
    { _id: I(1014), codigo: "R0014", tipoReserva: "particular", idCliente: I(3), idAlojamiento: I(104),
      fechaInicio: new Date("2027-02-01"), fechaFin: new Date("2027-02-05"),
      cantPersonas: I(2), precioTotal: I(200000), estado: "Pendiente",
      historialEstados: [
        { estado: "Pendiente", fechaEstado: new Date() } ] })

  bd.usuario.updateOne({ _id: I(3) }, { $set: { direccion: "Belgrano 450" } })
  sesion.commitTransaction()
  print("Transacción confirmada")
} catch (e) {
  sesion.abortTransaction()
  print("Transacción abortada: " + e.message)
} finally {
  sesion.endSession()
}

// transaccion con rollback
const sesion2 = db.getMongo().startSession()
const bd2 = sesion2.getDatabase("faibnb")
sesion2.startTransaction({ readConcern: { level: "snapshot" }, writeConcern: { w: "majority" } })
try {
  bd2.reserva.insertOne(
    { _id: I(1015), codigo: "R0015", tipoReserva: "particular", idCliente: I(3), idAlojamiento: I(104),
      fechaInicio: new Date("2027-04-01"), fechaFin: new Date("2027-04-05"),
      cantPersonas: I(2), precioTotal: I(200000), estado: "Pendiente",
      historialEstados: [ { estado: "Pendiente", fechaEstado: new Date() } ] })
  bd2.usuario.updateOne({ _id: I(3) }, { $set: { tipoUsuario: "invitado" } })
  sesion2.commitTransaction()
  print("Transacción confirmada")
} catch (e) {
  sesion2.abortTransaction()
  print("Transacción abortada: " + e.message)
} finally {
  sesion2.endSession()
}
