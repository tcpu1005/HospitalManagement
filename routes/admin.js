import express from "express";
import { selectSql, insertSql, updateSql, deleteSql } from "../Database/sql";

const router = express.Router();

// Display admin dashboard with list of doctors and nurses
router.get("/", async (req, res) => {
  if (req.session.user && req.session.user.Role === "ADMIN") {
    try {
      const doctors = await selectSql.getDoctors();
      const nurses = await selectSql.getNurses();
      res.render("admin", { doctors, nurses }); // Assuming a Handlebars view named 'adminDashboard'
    } catch (err) {
      console.error(err);
      res.status(500).send("Error retrieving staff data");
    }
  } else {
    res.redirect("/");
  }
});

// Add a new doctor or nurse
router.post("/add", async (req, res) => {
  const { Name, DepartmentId, Address, PhoneNumber, Username, Password, role } =
    req.body;
  console.log(
    Name,
    DepartmentId,
    Address,
    PhoneNumber,
    Username,
    Password,
    role
  );
  try {
    await insertSql.addStaff(
      Name,
      DepartmentId,
      Address,
      PhoneNumber,
      Username,
      Password,
      role
    );
    res.redirect("/admin");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error adding staff");
  }
});

// Update doctor or nurse details
router.post("/update/:id", async (req, res) => {
  const staffId = req.params.id;
  const { role, Name, Address, PhoneNumber } = req.body;
  const updatedDetails = { Name, Address, PhoneNumber };
  console.log(staffId, role, Name, Address, PhoneNumber);

  try {
    await updateSql.updateStaff(staffId, updatedDetails, role);
    res.redirect("/admin");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error updating staff details");
  }
});

// Delete a doctor or nurse
router.get("/delete/:id", async (req, res) => {
  const staffId = req.params.id;
  const { role } = req.query;
  console.log(staffId, role);
  try {
    await deleteSql.deleteStaff(staffId, role);
    res.redirect("/admin");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error deleting staff");
  }
});

export default router;
