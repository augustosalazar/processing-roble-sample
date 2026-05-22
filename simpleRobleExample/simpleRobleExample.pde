import com.uninorte.roble.processing.*;


Roble roble;

void setup() {

  size(400, 400);

  println("Starting Roble test...");

  roble = new Roble("contract_flutterdemo_ebabe79ab0");

  try {

    boolean success = roble.login(
      "a@a.com",
      "ThePassword!1"
    );

    println("Login success: " + success);

    println("Access token:");
    println(roble.getAccessToken());

    println("Refresh token:");
    println(roble.getRefreshToken());

    println("User id:");
    println(roble.getUserId());

  }
  catch(Exception e) {

    println("ERROR:");
    println(e.getMessage());

    e.printStackTrace();
  }
}
