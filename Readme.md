# Roble + Processing

Este proyecto muestra cómo usar la librería de Roble en Processing para:

* Autenticarse
* Leer datos
* Crear datos
* Actualizar datos
* Eliminar datos

usando una tabla llamada `Product`.

---

# 1. Instalar la librería

## Paso 1

Copie el archivo:

```text
roble.jar
```

dentro de la carpeta:

```text
simpleRobleExample/code/
```

La estructura debe quedar así:

```text
simpleRobleExample/
├── simpleRobleExample.pde
└── code/
    └── roble.jar
```

---

## Paso 2

Reinicie Processing.

---

## Paso 3

Importe la librería:

```java
import com.uninorte.roble.processing.*;
```

---

# 2. Crear una conexión con Roble

Primero se crea un objeto `Roble`.

```java
Roble roble;
```

Luego se inicializa:

```java
roble = new Roble(
  "ADD_YOUR_PROJECT_ID_HERE"
);
```

El texto:

```text
ADD_YOUR_PROJECT_ID_HERE
```

es el identificador del proyecto en Roble.

---

# 3. Autenticación

Para usar la base de datos es necesario iniciar sesión.

```java
roble.login(
  "ADD_YOUR_EMAIL_HERE",
  "ADD_YOUR_PASSWORD_HERE"
);
```

Si el correo y la contraseña son correctos:

* el usuario queda autenticado
* la librería guarda automáticamente el token
* las siguientes peticiones ya estarán autorizadas

---

# 4. Leer datos (READ)

Para leer la tabla `Product`:

```java
JsonArray products =
  roble.read("Product");
```

La variable `products` contiene una lista de productos.

---

## Recorrer productos

```java
for (int i = 0; i < products.size(); i++) {

  JsonObject product =
    products.get(i).getAsJsonObject();

  println(
    product.get("name").getAsString()
  );
}
```

---

# 5. Crear datos (CREATE)

Para crear un producto:

```java
JsonObject product =
  new JsonObject();

product.addProperty(
  "name",
  "Keyboard"
);

product.addProperty(
  "description",
  "Mechanical keyboard"
);

product.addProperty(
  "quantity",
  10
);

roble.insert(
  "Product",
  product
);
```

---

# 6. Actualizar datos (UPDATE)

Primero necesitamos el `_id` del producto.

```java
String id =
  product.get("_id").getAsString();
```

Luego creamos los cambios:

```java
JsonObject updates =
  new JsonObject();

updates.addProperty(
  "name",
  "Gaming Keyboard"
);

updates.addProperty(
  "description",
  "RGB keyboard"
);

updates.addProperty(
  "quantity",
  20
);
```

Finalmente actualizamos:

```java
roble.update(
  "Product",
  id,
  updates
);
```

---

# 7. Eliminar datos (DELETE)

Para eliminar un producto:

```java
roble.delete(
  "Product",
  id
);
```

---

# 8. Estructura de la tabla Product

La tabla utilizada tiene esta estructura:

| Campo       | Tipo   |
| ----------- | ------ |
| _id         | texto  |
| name        | texto  |
| description | texto  |
| quantity    | número |

---

# 9. Qué hace el ejemplo visual

El ejemplo visual incluido permite:

* iniciar sesión automáticamente
* visualizar productos
* crear productos con botones
* actualizar productos
* eliminar productos
* mostrar mensajes de estado

Todo usando Processing.

---

# 10. Conceptos importantes

## JsonObject

Representa un objeto JSON.

Ejemplo:

```json
{
  "name": "Keyboard",
  "quantity": 10
}
```

---

## JsonArray

Representa una lista de objetos JSON.

Ejemplo:

```json
[
  {
    "name": "Keyboard"
  },
  {
    "name": "Mouse"
  }
]
```

---

# 11. Resumen

Con Roble y Processing puedes:

* conectarte a una API
* autenticar usuarios
* trabajar con bases de datos
* crear aplicaciones visuales
* hacer CRUD completo desde Java

sin necesidad de programar servidores.
