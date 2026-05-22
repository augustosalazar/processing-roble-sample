import com.uninorte.roble.processing.*;

//contract_flutterdemo_ebabe79ab0

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

Roble roble;

void setup() {

  size(400, 400);

  println("=================================");
  println("ROBLe PRODUCT CRUD TEST");
  println("=================================");

  roble = new Roble("contract_flutterdemo_ebabe79ab0");

  try {

    // =====================================================
    // LOGIN
    // =====================================================

    println("\n1. LOGIN");

    roble.login(
      "a@a.com",
      "ThePassword!1"
    );

    println("Login successful");

    // =====================================================
    // LIST PRODUCTS
    // =====================================================

    println("\n2. INITIAL PRODUCTS");

    JsonArray initialProducts =
      roble.read("Product");

    printProducts(initialProducts);
    
    

    // =====================================================
    // CREATE PRODUCT
    // =====================================================

    println("\n3. CREATING PRODUCT");

    JsonObject newProduct =
      new JsonObject();

    newProduct.addProperty(
      "name",
      "Keyboard"
    );

    newProduct.addProperty(
      "description",
      "Mechanical keyboard"
    );

    newProduct.addProperty(
      "quantity",
      15
    );

    roble.insert(
      "Product",
      newProduct
    );

    println("Product created");

    // =====================================================
    // LIST AGAIN
    // =====================================================

    println("\n4. PRODUCTS AFTER INSERT");

    JsonArray afterInsert =
      roble.read("Product");

    printProducts(afterInsert);

    // =====================================================
    // GET LAST PRODUCT ID
    // =====================================================

    JsonObject lastProduct =
      afterInsert
      .get(afterInsert.size() - 1)
      .getAsJsonObject();

    String productId =
      lastProduct
      .get("_id")
      .getAsString();

    println("\nSelected product id:");
    println(productId);

    // =====================================================
    // UPDATE PRODUCT
    // =====================================================

    println("\n5. UPDATING PRODUCT");

    JsonObject updates =
      new JsonObject();

    updates.addProperty(
      "name",
      "Gaming Keyboard"
    );

    updates.addProperty(
      "description",
      "RGB mechanical keyboard"
    );

    updates.addProperty(
      "quantity",
      30
    );

    roble.update(
      "Product",
      productId,
      updates
    );

    println("Product updated");

    // =====================================================
    // LIST AGAIN
    // =====================================================

    println("\n6. PRODUCTS AFTER UPDATE");

    JsonArray afterUpdate =
      roble.read("Product");

    printProducts(afterUpdate);

    // =====================================================
    // DELETE PRODUCT
    // =====================================================

    println("\n7. DELETING PRODUCT");

    roble.delete(
      "Product",
      productId
    );

    println("Product deleted");

    // =====================================================
    // FINAL LIST
    // =====================================================

    println("\n8. FINAL PRODUCTS");

    JsonArray finalProducts =
      roble.read("Product");

    printProducts(finalProducts);

    println("\n=================================");
    println("CRUD TEST FINISHED");
    println("=================================");
  }
  catch(Exception e) {

    println("\nERROR:");
    println(e.getMessage());

    e.printStackTrace();
  }

  noLoop();
}

void printProducts(JsonArray products) {

  println("---------------------------------");

  println("Total products: " + products.size());

  println("---------------------------------");

  for (int i = 0; i < products.size(); i++) {

    JsonObject product =
      products.get(i).getAsJsonObject();

    String id =
      product.has("_id")
      ? product.get("_id").getAsString()
      : "NO_ID";

    String name =
      product.has("name")
      ? product.get("name").getAsString()
      : "";

    String description =
      product.has("description")
      ? product.get("description").getAsString()
      : "";

    long quantity =
      product.has("quantity")
      ? product.get("quantity").getAsLong()
      : 0;

    println("ID: " + id);

    println("NAME: " + name);

    println("DESCRIPTION: " + description);

    println("QUANTITY: " + quantity);

    println("---------------------------------");
  }
}
