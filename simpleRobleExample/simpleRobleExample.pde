
import com.uninorte.roble.processing.*;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

Roble roble;

String status = "Disconnected";

JsonArray products = new JsonArray();

String currentProductId = "";

void setup() {

  size(900, 700);

  textFont(createFont("Arial", 16));

  // ==========================================
  // INITIALIZE ROBLE
  // ==========================================

  roble = new Roble(
    "ROBLE_PROJECT_HERE"
  );

  login();

  refreshProducts();
}

void draw() {

  background(245);

  fill(20);
  textSize(28);
  text("Roble Product CRUD", 40, 50);

  textSize(14);
  fill(60);
  text("Status: " + status, 40, 80);

  drawButtons();

  drawProducts();
}

// =====================================================
// LOGIN
// =====================================================

void login() {

  try {

    roble.login(
      "a@a.com",
      "ThePassword!1"
    );

    status = "Logged in successfully";
  }
  catch(Exception e) {

    status = "LOGIN ERROR: " + e.getMessage();

    e.printStackTrace();
  }
}

// =====================================================
// BUTTONS
// =====================================================

void drawButtons() {

  drawButton(40, 120, 180, 50, "Refresh Products");

  drawButton(240, 120, 180, 50, "Add Product");

  drawButton(440, 120, 180, 50, "Update First");

  drawButton(640, 120, 180, 50, "Delete First");
}

void drawButton(
  int x,
  int y,
  int w,
  int h,
  String label
) {

  fill(40, 120, 220);
  stroke(0);

  rect(x, y, w, h, 10);

  fill(255);
  textAlign(CENTER, CENTER);
  text(label, x + w / 2, y + h / 2);

  textAlign(LEFT, BASELINE);
}

// =====================================================
// PRODUCTS
// =====================================================

void drawProducts() {

  fill(20);
  textSize(20);

  text("Products", 40, 230);

  int y = 270;

  for (int i = 0; i < products.size(); i++) {

    JsonObject product =
      products.get(i).getAsJsonObject();

    String id = getString(product, "_id");
    String name = getString(product, "name");
    String description = getString(product, "description");
    String quantity = getString(product, "quantity");

    fill(255);
    stroke(200);

    rect(40, y - 30, 800, 90, 10);

    fill(20);
    textSize(16);

    text("ID: " + id, 60, y);
    text("Name: " + name, 60, y + 25);
    text("Description: " + description, 320, y + 25);
    text("Quantity: " + quantity, 700, y + 25);

    y += 110;
  }
}

// =====================================================
// MOUSE INTERACTION
// =====================================================

void mousePressed() {

  // REFRESH
  if (inside(40, 120, 180, 50)) {

    refreshProducts();
  }

  // ADD
  else if (inside(240, 120, 180, 50)) {

    addProduct();
  }

  // UPDATE
  else if (inside(440, 120, 180, 50)) {

    updateFirstProduct();
  }

  // DELETE
  else if (inside(640, 120, 180, 50)) {

    deleteFirstProduct();
  }
}

boolean inside(
  int x,
  int y,
  int w,
  int h
) {

  return mouseX >= x
    && mouseX <= x + w
    && mouseY >= y
    && mouseY <= y + h;
}

// =====================================================
// REFRESH PRODUCTS
// =====================================================

void refreshProducts() {

  try {

    products = roble.read("Product");

    status = "Loaded " + products.size() + " products";
  }
  catch(Exception e) {

    status = "READ ERROR: " + e.getMessage();

    e.printStackTrace();
  }
}

// =====================================================
// ADD PRODUCT
// =====================================================

void addProduct() {

  try {

    JsonObject product = new JsonObject();

    product.addProperty(
      "name",
      "Keyboard " + millis()
    );

    product.addProperty(
      "description",
      "Mechanical keyboard"
    );

    product.addProperty(
      "quantity",
      int(random(1, 100))
    );

    roble.insert(
      "Product",
      product
    );

    status = "Product created";

    refreshProducts();
  }
  catch(Exception e) {

    status = "INSERT ERROR: " + e.getMessage();

    e.printStackTrace();
  }
}

// =====================================================
// UPDATE FIRST PRODUCT
// =====================================================

void updateFirstProduct() {

  try {

    if (products.size() == 0) {

      status = "No products to update";

      return;
    }

    JsonObject first =
      products.get(0).getAsJsonObject();

    String id =
      first.get("_id").getAsString();

    JsonObject updates =
      new JsonObject();

    updates.addProperty(
      "name",
      "UPDATED PRODUCT"
    );

    updates.addProperty(
      "description",
      "Updated from Processing"
    );

    updates.addProperty(
      "quantity",
      999
    );

    roble.update(
      "Product",
      id,
      updates
    );

    status = "Product updated";

    refreshProducts();
  }
  catch(Exception e) {

    status = "UPDATE ERROR: " + e.getMessage();

    e.printStackTrace();
  }
}

// =====================================================
// DELETE FIRST PRODUCT
// =====================================================

void deleteFirstProduct() {

  try {

    if (products.size() == 0) {

      status = "No products to delete";

      return;
    }

    JsonObject first =
      products.get(0).getAsJsonObject();

    String id =
      first.get("_id").getAsString();

    roble.delete(
      "Product",
      id
    );

    status = "Product deleted";

    refreshProducts();
  }
  catch(Exception e) {

    status = "DELETE ERROR: " + e.getMessage();

    e.printStackTrace();
  }
}

// =====================================================
// UTILS
// =====================================================

String getString(
  JsonObject obj,
  String key
) {

  if (!obj.has(key)) {
    return "";
  }

  return obj.get(key).getAsString();
}
