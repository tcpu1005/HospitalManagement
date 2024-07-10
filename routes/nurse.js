import express from "express";
import { selectSql, insertSql, updateSql, deleteSql } from "../Database/sql";

const router = express.Router();

// Display nurse dashboard
// Display nurse dashboard and handle patient search
router.get("/", async (req, res) => {
  if (req.session.user && req.session.user.Role === "NURSE") {
    try {
      const searchQuery = req.query.searchQuery;
      let treatments = [];
      let searchResults = [];

      // If there is a search query, perform the search, otherwise get treatments
      if (searchQuery) {
        searchResults = await selectSql.searchPatients(searchQuery);
      } else {
        // Assuming you have a getTreatments function that retrieves treatments for the nurse
        const nurseId = req.session.user.UserID; // UserID from the session
        treatments = await selectSql.getTreatments(nurseId);
      }

      // Render with fetched treatments and search results
      res.render("nurse", { treatments, searchResults });
    } catch (err) {
      console.error(err);
      res.status(500).send("Error retrieving data");
    }
  } else {
    res.redirect("/login");
  }
});

// Add a new treatment
router.post("/add", async (req, res) => {
  const { TreatmentDateTime, TreatmentDetails, NurseID, PatientID } = req.body;
  try {
    await insertSql.addTreatment(
      TreatmentDateTime,
      TreatmentDetails,
      NurseID,
      PatientID
    );
    res.redirect("/nurse");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error adding treatment");
  }
});

// Update treatment details
router.post("/update/:id", async (req, res) => {
  const treatmentId = req.params.id;
  const { TreatmentDateTime, TreatmentDetails, PatientID } = req.body;
  try {
    await updateSql.updateTreatment(
      treatmentId,
      TreatmentDateTime,
      TreatmentDetails,
      PatientID
    );
    res.redirect("/nurse");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error updating treatment");
  }
});

// Delete a treatment
router.get("/delete/:id", async (req, res) => {
  const treatmentId = req.params.id;
  try {
    await deleteSql.deleteTreatment(treatmentId);
    res.redirect("/nurse");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error deleting treatment");
  }
});
// Handle patient search
// router.post("/search", async (req, res) => {
//   const { searchQuery } = req.body;

//   try {
//     const searchResults = await selectSql.searchPatients(searchQuery);

//     res.render("nurse", { searchResults });
//   } catch (err) {
//     console.error(err);
//     res.status(500).send("Error searching for patients");
//   }
// });

export default router;
