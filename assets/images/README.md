# Logos institucionales

Coloca aquí los dos logos que aparecen en la pantalla de login.
La pantalla `login_view.dart` ya hace referencia a estos nombres exactos:

| Archivo               | Descripción                                |
|-----------------------|--------------------------------------------|
| `logo_tecnm.png`      | Logo del Tecnológico Nacional de México    |
| `logo_itt.png`        | Logo del Instituto Tecnológico de Toluca   |

## Recomendaciones (apartado 4.2 del MPF — Lineamientos de tamaño y peso)

- Formato: PNG con fondo transparente.
- Resolución mínima: 256×256 px.
- Peso máximo: 100 KB cada uno.
- Si necesitas variantes para densidades altas, usa subcarpetas `2.0x/` y `3.0x/`
  con el mismo nombre de archivo (sistema de variantes nativo de Flutter).

> Mientras los archivos no existan, la pantalla mostrará un placeholder visual
> con borde discontinuo en su lugar (NO se rompe la UI).
