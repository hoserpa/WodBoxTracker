const MENSAJES_CONOCIDOS = {
  "Invalid login credentials": "Email o contraseña incorrectos",
  "Email not confirmed": "Debes confirmar tu email antes de acceder",
  "User already registered": "Ya existe una cuenta con este email",
  "New password should be different from the old password.":
    "La nueva contraseña debe ser distinta de la anterior",
  "Email rate limit exceeded": "Demasiados envíos. Espera antes de reintentar",
};

export function mensajeAuthError(err) {
  const msg = err?.message ?? "";
  if (MENSAJES_CONOCIDOS[msg]) return MENSAJES_CONOCIDOS[msg];
  if (/rate limit/i.test(msg))
    return "Demasiados intentos. Espera unos minutos e inténtalo de nuevo";
  if (/at least \d+ characters/i.test(msg))
    return "La contraseña no cumple los requisitos mínimos";
  return "Se ha producido un error. Inténtalo de nuevo";
}
