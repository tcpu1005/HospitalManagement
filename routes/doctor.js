import express from "express";
import { selectSql, insertSql, updateSql, deleteSql } from "../Database/sql";

const router = express.Router();

// Display doctor dashboard
router.get("/", async (req, res) => {
  if (req.session.user && req.session.user.Role === "DOCTOR") {
    try {
      const userId = req.session.user.UserID; // UserID from the session
      let examinations = [];
      let searchResults = [];
      const searchQuery = req.query.searchQuery; // Retrieve search query from request

      if (searchQuery) {
        // If there's a search query, perform the search
        searchResults = await selectSql.searchPatients(searchQuery);
      } else {
        // Otherwise, retrieve the doctor's examinations
        examinations = await selectSql.getExaminations(userId);
      }

      res.render("doctor", { examinations, searchResults, searchQuery }); // Render with fetched data and search results
    } catch (err) {
      console.error(err);
      res.status(500).send("Error retrieving data");
    }
  } else {
    res.redirect("/login");
  }
});

// Add a new examination
router.post("/add", async (req, res) => {
  const { ExaminationDateTime, ExaminationDetails, DoctorID, PatientID } =
    req.body;
  try {
    await insertSql.addExamination(
      ExaminationDateTime,
      ExaminationDetails,
      DoctorID,
      PatientID
    );
    res.redirect("/doctor");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error adding examination");
  }
});

// Update examination details
router.post("/update/:id", async (req, res) => {
  const examinationId = req.params.id;

  const { ExaminationDateTime, ExaminationDetails, PatientID } = req.body;
  try {
    await updateSql.updateExamination(
      examinationId,
      ExaminationDateTime,
      ExaminationDetails,
      PatientID
    );
    res.redirect("/doctor");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error updating examination");
  }
});

// Delete an examination
router.get("/delete/:id", async (req, res) => {
  const examinationId = req.params.id;
  try {
    await deleteSql.deleteExamination(examinationId);
    res.redirect("/doctor");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error deleting examination");
  }
});

export default router;
