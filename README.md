Proyecto 3: Diseño de un controlador de motor paso a paso
===
En este proyecto diseñaremos un circuito controlador para un motor paso a paso, basado en una máquina de estados finitos, y comprobaremos su funcionamiento mediante un emulador de motor. A continuación realizaremos un rediseño del juego de luces del Proyecto 1 utilizando máquinas de estados y le añadiremos funcionalidad adicional para control de velocidad mediante los botones de la placa de evaluación.

Tabla de Estados
---
| `Estado` | `A`   | `B`   | `C` | `D` | `INH1` | `INH2` |
|----------|-------|-------|-----|-----|--------|--------|
| `1`      | `0`   | `1`   | `0` | `1` | `1`    | `1`    |
| `2`      | `0`   | `0`   | `1` | `1` | `0`    | `1`    |
| `3`      | `1`   | `0`   | `0` | `1` | `1`    | `1`    |
| `4`      | `1`   | `0`   | `0` | `0` | `1`    | `0`    |
| `5`      | `1`   | `0`   | `1` | `0` | `1`    | `1`    |
| `6`      | `0`   | `0`   | `1` | `0` | `0`    | `1`    |
| `7`      | `0`   | `1`   | `1` | `0` | `1`    | `1`    |
| `8`      | `0`   | `1`   | `0` | `0` | `1`    | `0`    |
