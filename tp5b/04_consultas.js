// 1. consulta con fecha relativa
const limite = new Date()
limite.setFullYear(limite.getFullYear() - 1)
db.reserva.find(
  { estado: "Cancelada", fechaInicio: { $lte: limite } },
  { _id: 1, codigo: 1, estado: 1, fechaInicio: 1 })

// 2. consulta con varios criterios
db.usuario.find(
  {
    "nombreCompleto.nombre": { $regex: "^M" },
    fechaNacimiento: { $lt: new Date("2000-01-01") },
    tipoUsuario: "cliente"
  },
  { _id: 0, nombreCompleto: 1, fechaNacimiento: 1, tipoUsuario: 1 }
)

// 3. borrado acotado
const inicioSemana = new Date()
inicioSemana.setHours(0, 0, 0, 0)
inicioSemana.setDate(inicioSemana.getDate() - ((inicioSemana.getDay() + 6) % 7))
const finSemana = new Date(inicioSemana)
finSemana.setDate(finSemana.getDate() + 7)

db.reserva.countDocuments()
// para contar cuantas cumplen el filtro
db.reserva.countDocuments({ tipoReserva: "hotel", fechaInicio: { $gte: inicioSemana, $lt: finSemana } })

db.reserva.deleteOne({ tipoReserva: "hotel", fechaInicio: { $gte: inicioSemana, $lt: finSemana } })

db.reserva.countDocuments()

db.reserva.deleteOne({ tipoReserva: "hotel", fechaInicio: { $gte: inicioSemana, $lt: finSemana } })

// 4. modificacion
db.usuario.updateOne({ _id: 4 }, { $set: { direccion: "Mitre 1250" } })

// 5. consulta sobre dos colecciones
db.reserva.aggregate([
  { $match: { estado: "Confirmada" } },
  { $lookup: { from: "usuario", localField: "idCliente", foreignField: "_id", as: "cliente" } },
  { $unwind: "$cliente" },
  { $project: { _id: 0, codigo: 1, fechaInicio: 1,
                nombre: "$cliente.nombreCompleto.nombre",
                apellido: "$cliente.nombreCompleto.apellido" } }
])
