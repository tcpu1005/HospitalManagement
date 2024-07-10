import express from "express";
import { promisePool } from "../Database/sql"; // 이렇게 promisePool을 가져옵니다.
import { selectSql, insertSql, deleteSql } from "../Database/sql";

const router = express.Router();

// Display patient dashboard with reservations
router.get("/", async (req, res) => {
  if (req.session.user && req.session.user.Role === "PATIENT") {
    try {
      const userId = req.session.user.UserID; // UserID from the session
      const reservations = await selectSql.getReservationsByPatient(userId);
      console.log(userId);
      res.render("patient", { reservations }); // Render with fetched reservations
    } catch (err) {
      console.error(err);
      res.status(500).send("Error retrieving reservation data");
    }
  } else {
    res.redirect("/login");
  }
});

// // Handle new reservation
// router.post("/reserve", async (req, res) => {
//   const { ReservationDateTime, DepartmentID } = req.body;
//   const userId = req.session.user.UserID;
//   try {
//     await insertSql.makeReservation(ReservationDateTime, DepartmentID, userId);
//     res.redirect("/patient");
//   } catch (err) {
//     console.error(err);
//     res.status(500).send("Error making reservation");
//   }
// });

// Cancel a reservation
router.post("/cancel/:id", async (req, res) => {
  const reservationId = req.params.id;
  try {
    await deleteSql.cancelReservation(reservationId);
    res.redirect("/patient");
  } catch (err) {
    console.error(err);
    res.status(500).send("Error cancelling reservation");
  }
});

router.post("/reserve", async (req, res) => {
  const { ReservationDateTime, DepartmentID, PatientID } = req.body;
  console.log(ReservationDateTime, DepartmentID, PatientID);
  // 데이터베이스 연결을 가져옵니다.
  const connection = await promisePool.getConnection();

  try {
    // 트랜잭션을 시작합니다.
    await connection.beginTransaction();

    // 기존에 같은 시간과 부서에 대한 예약이 있는지 확인합니다.
    const existingReservationQuery = `
          SELECT * FROM reservation
          WHERE ReservationDateTime = ? AND DepartmentID = ?
        `;
    const [existingReservations] = await connection.query(
      existingReservationQuery,
      [ReservationDateTime, DepartmentID]
    );

    if (existingReservations.length > 0) {
      // 이미 예약이 존재한다면 롤백을 수행하고 오류 메시지를 반환합니다.
      await connection.rollback();
      connection.release();
      return res.status(400).send("This time slot is already reserved.");
    }

    // 새 예약을 추가합니다.
    const addReservationQuery = `
          INSERT INTO reservation (ReservationDateTime, DepartmentID, PatientID)
          VALUES (?, ?, ?)
        `;
    console.log(addReservationQuery); // 올바른 변수 이름으로 변경
    await connection.query(addReservationQuery, [
      ReservationDateTime,
      DepartmentID,
      PatientID,
    ]);

    // 트랜잭션을 커밋합니다.
    await connection.commit();
    connection.release();

    console.log("Transaction commit success");
  } catch (error) {
    // 오류가 발생하면 롤백을 수행합니다.
    await connection.rollback();
    connection.release();

    // 오류 메시지를 반환합니다.
    res.status(500).send("An error occurred while making the reservation.");
  }
});

export default router;
