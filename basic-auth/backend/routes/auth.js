var express = require("express");
var router = express.Router();

/* POST Auth returns HTTP 200*/
router.post("/", function (req, res) {
  const authHeader = req.headers.authorization || "";
  const [user, pass] = Buffer.from(authHeader.split(" ")[1] || "", "base64")
    .toString()
    .split(":");

  if (user === "test" && pass === "pass") {
    return res.status(200).json({ message: "Authenticated" });
  } else {
    res.set("WWW-Authenticate", 'Basic realm="Restricted"');
    return res.sendStatus(401);
  }
});

module.exports = router;
