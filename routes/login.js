import express from "express";
import { selectSql } from "../Database/sql";

const router = express.Router();

// Display login page
router.get("/", (req, res) => {
  res.render("login");
});

// Handle login post request
router.post("/", async (req, res) => {
  const userdata = req.body;
  console.log(userdata.username);

  try {
    const user = await selectSql.getUserByUsername(userdata.username);
    console.log("durl", user);
    if (
      user.Username === userdata.username &&
      user.Password === userdata.password
    ) {
      console.log("로그인 성공");
      req.session.user = { UserID: user.UserID, Role: user.Role };

      switch (user.Role) {
        case "ADMIN":
          console.log("관리자 로그인 성공");
          res.redirect("/admin");
          break;
        case "DOCTOR":
          res.redirect("/doctor");
          break;
        case "NURSE":
          res.redirect("/nurse");
          break;
        case "PATIENT":
          res.redirect("/patient");
          break;
        default:
          res.redirect("/");
      }
    } else {
      res.send(
        `<script>alert('Login failed! Incorrect credentials.'); location.href='/';</script>`
      );
    }
  } catch (error) {
    console.error("Login error: ", error);
    res.status(500).send("Internal Server Error");
  }
});

export default router;
