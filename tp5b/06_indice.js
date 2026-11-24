db = db.getSiblingDB("faibnb");

const limite = new Date();
limite.setFullYear(limite.getFullYear() - 1);
const filtro = { estado: "Cancelada", fechaInicio: { $lte: limite } };

function etapas(p) {
  return p.inputStage ? p.stage + " > " + etapas(p.inputStage) : p.stage;
}

function resumen(titulo) {
  const e = db.reserva.find(filtro).explain("executionStats");
  const s = e.executionStats;
  print("=== " + titulo + " ===");
  print("Plan: " + etapas(e.queryPlanner.winningPlan));
  print("Claves examinadas:     " + s.totalKeysExamined);
  print("Documentos examinados: " + s.totalDocsExamined);
  print("Documentos devueltos:  " + s.nReturned);
  print("Tiempo (ms):           " + s.executionTimeMillis);
}

resumen("ANTES del índice");

db.reserva.createIndex({ estado: 1, fechaInicio: 1 });

resumen("DESPUES del índice");

printjson(db.reserva.getIndexes().map(i => i.name));