# 병원 관리 시스템

## 개요
본 텀 프로젝트는 병원 관리 시스템의 데이터베이스와 웹 인터페이스를 설계하고 구현하는 것을 목표로 합니다. 이 시스템은 관리자, 의사, 간호사, 그리고 환자 페이지를 포함하여 다양한 사용자 역할에 맞춘 기능을 제공합니다. 주요 작업으로는 데이터베이스의 ERD 설계, 테이블 생성 및 정규화, 인덱스와 뷰의 구현, 데이터 삽입 스크립트 작성, 트랜잭션 관리, 그리고 세부적인 웹 페이지의 구현이 포함됩니다. 이 프로젝트는 병원 운영에 필수적인 데이터를 관리하고, 사용자가 효율적으로 데이터에 접근하고 조작할 수 있는 웹 기반 인터페이스를 목표로 합니다.

## 상세 설계 내용
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/e2355f06-b667-4d5b-8dc8-f9126dbfec85)

### 테이블 생성 및 역할

#### DEPARTMENT 테이블
- **목적:** 병원의 각 부서 정보를 담고 있습니다.
- **필드:**
  - `DepartmentID`: 부서 고유 번호 (PK, AUTO_INCREMENT).
  - `DepartmentName`: 부서의 이름 (NOT NULL).
  - `PhoneNumber`: 부서의 연락처.

#### USER 테이블
- **목적:** 시스템 사용자의 인증 정보를 관리합니다.
- **필드:**
  - `UserID`: 사용자 고유 번호 (PK, AUTO_INCREMENT).
  - `Username`: 사용자 이름.
  - `Password`: 사용자 비밀번호.
  - `Role`: 사용자 역할 ('Admin', 'Doctor', 'Nurse', 'Patient').

#### DOCTOR 테이블
- **목적:** 병원 의사들에 대한 정보를 담고 있습니다.
- **필드:**
  - `DoctorID`: 의사의 고유 번호 (PK, AUTO_INCREMENT).
  - `Name`: 의사 이름.
  - `Address`: 주소.
  - `PhoneNumber`: 전화번호.
  - `DepartmentID`: 속한 부서 번호 (FK).
  - `UserID`: 시스템 사용자 ID (FK).

#### PATIENT 테이블
- **목적:** 환자의 개인 정보를 담고 있습니다.
- **필드:**
  - `PatientID`: 환자의 고유 번호 (PK, AUTO_INCREMENT).
  - `SocialSecurityNumber`: 사회보장번호.
  - `Gender`: 성별.
  - `Address`: 주소.
  - `BloodType`: 혈액형.
  - `Height`: 키.
  - `Weight`: 몸무게.
  - `PhoneNumber`: 전화번호.
  - `UserID`: 시스템 사용자 ID (FK).

#### EXAMINATION 테이블
- **목적:** 환자의 검사 기록을 담고 있습니다.
- **필드:**
  - `ExaminationID`: 검사 기록의 고유 번호 (PK, AUTO_INCREMENT).
  - `ExaminationDateTime`: 검사 시간.
  - `ExaminationDetails`: 검사 세부 사항.
  - `DoctorID`: 담당 의사 번호 (FK).
  - `PatientID`: 환자 번호 (FK).

#### INPATIENT 테이블
- **목적:** 입원 환자의 기록을 담고 있습니다.
- **필드:**
  - `InpatientID`: 입원 기록의 고유 번호 (PK, AUTO_INCREMENT).
  - `PatientID`: 환자 번호 (FK).
  - `RoomInformation`: 병실 정보.
  - `AdmissionDateTime`: 입원 시간.
  - `DischargeDateTime`: 퇴원 시간.

#### MEDICAL_SPECIALTY 테이블
- **목적:** 병원에서 제공하는 의료 전문 분야를 나타냅니다.
- **필드:**
  - `SpecialtyID`: 전문 분야의 고유 번호 (PK, AUTO_INCREMENT).
  - `DepartmentID`: 속한 부서 번호 (FK).
  - `SpecialtyName`: 전문 분야 이름.

#### NURSE 테이블
- **목적:** 간호사에 대한 정보를 담고 있습니다.
- **필드:**
  - `NurseID`: 간호사의 고유 번호 (PK, AUTO_INCREMENT).
  - `Name`: 간호사 이름.
  - `Address`: 주소.
  - `PhoneNumber`: 전화번호.
  - `DepartmentID`: 속한 부서 번호 (FK).
  - `UserID`: 시스템 사용자 ID (FK).

#### RESERVATION 테이블
- **목적:** 환자의 예약 정보를 담고 있습니다.
- **필드:**
  - `ReservationNumber`: 예약의 고유 번호 (PK, AUTO_INCREMENT).
  - `ReservationDateTime`: 예약 날짜와 시간.
  - `DepartmentID`: 예약된 부서 번호 (FK).
  - `PatientID`: 예약한 환자 번호 (FK).

#### TREATMENT 테이블
- **목적:** 환자의 치료 기록을 담고 있습니다.
- **필드:**
  - `TreatmentID`: 치료 기록의 고유 번호 (PK, AUTO_INCREMENT).
  - `TreatmentDateTime`: 치료 날짜와 시간.
  - `TreatmentDetails`: 치료 세부 사항.
  - `NurseID`: 담당 간호사 번호 (FK).
  - `PatientID`: 치료받은 환자 번호 (FK).

### 테이블 간 관계

#### DEPARTMENT - DOCTOR 관계
- **관계:** 1:N
- **설명:** 한 부서에 여러 명의 의사가 있을 수 있습니다. 각 의사는 고유한 DepartmentID를 외래 키로 가지고 있습니다.

#### DEPARTMENT - NURSE 관계
- **관계:** 1:N
- **설명:** 한 부서에 여러 명의 간호사가 있을 수 있습니다. 각 간호사는 고유한 DepartmentID를 외래 키로 가지고 있습니다.

#### DOCTOR - PATIENT 관계
- **관계:** N:M
- **설명:** 한 의사가 여러 환자를 담당할 수 있고, 한 환자도 여러 의사에게 진료를 받을 수 있습니다. EXAMINATION 테이블을 통해 간접적으로 연결됩니다.

#### PATIENT - EXAMINATION 관계
- **관계:** 1:N
- **설명:** 한 환자가 여러 번의 검사를 받을 수 있습니다. 각 검사는 환자 ID를 외래 키로 참조합니다.

#### DOCTOR - EXAMINATION 관계
- **관계:** 1:N
- **설명:** 한 의사가 여러 검사를 진행할 수 있습니다. 각 검사 기록은 의사 ID를 외래 키로 참조합니다.

#### NURSE - PATIENT 관계
- **관계:** N:M
- **설명:** 한 간호사가 여러 환자를 담당할 수 있고, 한 환자도 여러 간호사에게 진료를 받을 수 있습니다. EXAMINATION 테이블을 통해 간접적으로 연결됩니다.

#### NURSE - TREATMENT 관계
- **관계:** 1:N
- **설명:** 한 간호사가 여러 치료를 담당할 수 있습니다. 각 치료 기록은 간호사 ID를 외래 키로 참조합니다.

#### PATIENT - TREATMENT 관계
- **관계:** 1:N
- **설명:** 한 명의 환자가 여러 번의 치료를 받을 수 있습니다.

#### INPATIENT - PATIENT 관계
- **관계:** 1:1
- **설명:** 각 입원 기록은 하나의 환자에게만 해당합니다.

#### MEDICAL_SPECIALTY - DEPARTMENT 관계
- **관계:** 1:N
- **설명:** 각 전문 분야는 하나의 부서에만 속하며, 부서는 여러 전문 분야를 가질 수 있습니다.

#### USER - DOCTOR 관계
- **관계:** 1:1
- **설명:** 각 의사는 하나의 사용자 레코드와 연결됩니다. 이는 의사가 시스템을 사용하는 데 필요한 인증 정보를 user 테이블에서 관리합니다.

#### USER - NURSE 관계
- **관계:** 1:1
- **설명:** 각 간호사는 하나의 사용자 레코드와 연결됩니다. 이는 간호사가 시스템 접근을 위한 인증 정보를 user 테이블에서 관리합니다.

#### USER - PATIENT 관계
- **관계:** 1:1
- **설명:** 각 환자는 하나의 사용자 레코드와 연결됩니다. 이는 환자가 시스템에 접근하고 예약, 진료 기록 조회 등을 할 때 필요한 인증 정보를 user 테이블에서 관리합니다.

### 테이블 스키마 정규화

#### 1NF (첫 번째 정규형)
- **설명:** 모든 테이블이 1NF를 충족합니다. 각 테이블은 기본 키를 가지고 있으며, 모든 열 값이 원자적입니다 (반복 그룹이나 배열 없음).

#### 2NF (두 번째 정규형)
- **설명:** 2NF는 모든 비주 키 속성이 기본 키 전체에 함수적으로 종속되는 것을 요구합니다. 즉, 기본 키의 일부분에 대한 부분 종속이 없어야 합니다. 복합 기본 키를 가진 테이블은 각 필드가 전체 기본 키에 종속되어야 합니다. 모든 테이블이 2NF를 만족합니다.

#### 3NF (세 번째 정규형)
- **설명:** 3NF에서 이행적 종속이 없습니다. 모든 테이블이 3NF를 만족합니다.

#### BCNF (보이스-코드 정규형)
- **설명:** 모든 테이블에서 비주 키 속성은 오직 기본 키, 즉 슈퍼키에만 종속되어 있습니다. 따라서 BCNF를 만족합니다.

### 인덱스 생성
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/2529cb1c-e6cb-4a04-8844-9d633997d698)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/6f505cd3-43e5-4ede-8767-6037897c1758)

#### 카디널리티가 높은 속성 후보 선정
- **테이블:** examination, reservation, treatment, patient, inpatient, user
- **선정 이유:** 이 테이블들은 데이터가 많이 발생하고 자주 조회되기 때문에 선정되었습니다.

#### 조회가 빈번한 속성 후보 선택
- **테이블:** examination, treatment
- **선정 이유:** 자주 조회되는 테이블로 인덱스를 생성하여 검색 성능을 향상시킵니다.

### VIEW 생성

#### ExaminationSummary 뷰
- **목적:** 환자의 검사 정보를 종합적으로 조회
- **구조:**
  - 환자 이름(PatientName)
  - 검사 날짜 및 시간(ExaminationDateTime)
  - 검사 세부 사항(ExaminationDetails)
  - 검사를 담당한 부서 이름(DepartmentName)
- **SQL 쿼리:**
```sql
CREATE VIEW ExaminationSummary AS
SELECT 
    p.Name AS PatientName,
    e.ExaminationDateTime,
    e.ExaminationDetails,
    d.DepartmentName
FROM 
    examination e
JOIN 
    patient p ON e.PatientID = p.PatientID
JOIN 
    doctor doc ON e.DoctorID = doc.DoctorID
JOIN 
    department d ON doc.DepartmentID = d.DepartmentID;


#### TreatmentSummary 뷰
- **목적:** 간호사에 의해 수행된 치료 정보를 종합적으로 조회
- **구조:**
  - 간호사 이름(NurseName)
  - 환자 이름(PatientName)
  - 치료 날짜 및 시간(TreatmentDateTime)
  - 치료 세부 사항(TreatmentDetails)
  - 치료가 이루어진 부서 이름(DepartmentName)
- **SQL 쿼리:**
```sql
CREATE VIEW TreatmentSummary AS
SELECT 
    n.Name AS NurseName,
    p.Name AS PatientName,
    t.TreatmentDateTime,
    t.TreatmentDetails,
    d.DepartmentName
FROM 
    treatment t
JOIN 
    nurse n ON t.NurseID = n.NurseID
JOIN 
    patient p ON t.PatientID = p.PatientID
JOIN 
    department d ON n.DepartmentID = d.DepartmentID;
```

이러한 뷰는 복잡한 조인 쿼리를 간소화하여 사용자가 데이터베이스에서 필요한 정보를 더 쉽고 빠르게 검색할 수 있게 도와줍니다. ExaminationSummary와 TreatmentSummary 뷰는 특히 관리자, 의사, 간호사 등이 환자의 검사 및 치료 정보를 효율적으로 관리하고 조회하는 데 유용하게 사용될 수 있습니다.

### 트랜잭션 설계
병원 시스템에서 환자의 예약 과정을 원활하고 안정적으로 관리하기 위해 트랜잭션 관리의 네 가지 주요 속성(원자성, 일관성, 격리성, 영속성)을 활용하는 것이 목표입니다.

- **원자성(Atomicity):** 예약 과정에서 발생할 수 있는 모든 작업은 완전히 수행되거나 전혀 수행되지 않아야 합니다. 이를 위해 MySQL의 트랜잭션 관리 기능을 사용하여, 예약 과정 중 오류가 발생하면 모든 변경 사항을 롤백합니다.
- **일관성(Consistency):** 예약 과정이 성공적으로 완료되면 데이터베이스는 항상 일관된 상태를 유지해야 합니다. 예약 데이터가 삽입되면 관련 테이블의 무결성이 유지되어야 합니다.
- **격리성(Isolation):** 동시에 여러 환자가 예약을 시도할 때, 한 트랜잭션이 다른 트랜잭션의 작업에 영향을 주지 않아야 합니다. 이를 위해 SELECT ... FOR UPDATE 문을 사용하여 예약 시간과 부서에 대한 기존 예약을 잠그고, 다른 트랜잭션이 해당 데이터에 접근하지 못하도록 합니다.
- **영속성(Durability):** 트랜잭션이 성공적으로 커밋되면, 그 결과는 데이터베이스에 영구적으로 반영되어야 합니다. 시스템이나 데이터베이스에 문제가 발생해도, 예약 정보는 안전하게 유지되어야 합니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/af2fbad9-819f-48b2-bd30-8e66dc00a64d)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/d88ca91c-9ca1-4943-8f8b-0fa873ce3075)

```javascript
// 트랜잭션 시작
const connection = await promisePool.getConnection();
await connection.beginTransaction();

// 기존 예약 확인
const existingReservationQuery = `
  SELECT * FROM reservation
  WHERE ReservationDateTime = ? AND DepartmentID = ?
`;
const [existingReservations] = await connection.query(
  existingReservationQuery,
  [ReservationDateTime, DepartmentID]
);

// 중복 예약 확인 및 처리
if (existingReservations.length > 0) {
  await connection.rollback();
  connection.release();
  return res.status(400).send("This time slot is already reserved.");
}

// 예약 추가
const addReservationQuery = `
  INSERT INTO reservation (ReservationDateTime, DepartmentID, PatientID)
  VALUES (?, ?, ?)
`;
await connection.query(addReservationQuery, [
  ReservationDateTime, DepartmentID, PatientID
]);

// 트랜잭션 커밋
await connection.commit();
connection.release();
```

## 웹페이지 생성 (.hbs + .js)

### SQL.js 설계

```javascript
import mysql from "mysql2";

// Database connection
const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  database: "hospitalmanagement",
  password: "minji0715@",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

const promisePool = pool.promise();
export { promisePool };

// SELECT queries
export const selectSql = {
  getUserByUsername: async (username) => {
    const [rows] = await promisePool.query(
      `SELECT * FROM user WHERE Username = ?`,
      [username]
    );
    return rows[0];
  },
  getDoctors: async () => {
    const [rows] = await promisePool.query(`SELECT * FROM doctor`);
    return rows;
  },
  getNurses: async () => {
    const [rows] = await promisePool.query(`SELECT * FROM nurse`);
    return rows;
  },
  getExaminations: async (userId) => {
    const doctorQuery = `SELECT DoctorID FROM doctor WHERE UserID = ?`;
    const [doctorRows] = await promisePool.query(doctorQuery, [userId]);
    if (doctorRows.length === 0) {
      throw new Error("No doctor found with the given user ID.");
    }
    const doctorId = doctorRows[0].DoctorID;
    const examinationQuery = `SELECT * FROM examination WHERE DoctorID = ?`;
    const [examinationRows] = await promisePool.query(examinationQuery, [
      doctorId,
    ]);
    return examinationRows;
  },
  getTreatments: async (userId) => {
    const nurseQuery = `SELECT NurseID FROM nurse WHERE UserID = ?`;
    const [nurseRows] = await promisePool.query(nurseQuery, [userId]);
    if (nurseRows.length === 0) {
      throw new Error("No nurse found with the given user ID.");
    }
    const nurseId = nurseRows[0].NurseID;
    const treatmentQuery = `SELECT * FROM treatment WHERE NurseID = ?`;
    const [treatmentRows] = await promisePool.query(treatmentQuery, [nurseId]);
    return treatmentRows;
  },
  searchPatients: async (query) => {
    const searchQuery = `
        SELECT * FROM patient
        WHERE Name LIKE CONCAT('%', ?, '%') OR PatientID LIKE CONCAT('%', ?, '%')
    `;
    const [rows] = await promisePool.query(searchQuery, [query, query]);
    return rows;
  },
  getReservationsByPatient: async (userId) => {
    const query = `
        SELECT r.ReservationNumber, r.ReservationDateTime, r.DepartmentID, d.DepartmentName 
        FROM reservation r 
        JOIN department d ON r.DepartmentID = d.DepartmentID 
        WHERE r.PatientID = (SELECT PatientID FROM patient WHERE UserID = ?);
    `;
    const [rows] = await promisePool.query(query, [userId]);
    return rows;
  },
};

// INSERT queries
export const insertSql = {
  addStaff: async (
    name,
    departmentId,
    address,
    phoneNumber,
    username,
    password,
    role
  ) => {
    const userQuery = `INSERT INTO user (Username, Password, Role) VALUES (?, ?, ?)`;
    const [userResult] = await promisePool.query(userQuery, [
      username,
      password,
      role,
    ]);
    const userId = userResult.insertId;
    const staffTable = role === "DOCTOR" ? "doctor" : "nurse";
    const staffQuery = `INSERT INTO ${staffTable} (Name, DepartmentID, Address, PhoneNumber, UserID) VALUES (?, ?, ?, ?, ?)`;
    await promisePool.query(staffQuery, [
      name,
      departmentId,
      address,
      phoneNumber,
      userId,
    ]);
  },
  addExamination: async (
    ExaminationDateTime,
    ExaminationDetails,
    DoctorID,
    PatientID
  ) => {
    const query = `INSERT INTO examination (ExaminationDateTime, ExaminationDetails, DoctorID, PatientID) VALUES (?, ?, ?, ?)`;
    await promisePool.query(query, [
      ExaminationDateTime,
      ExaminationDetails,
      DoctorID,
      PatientID,
    ]);
  },
  addTreatment: async (
    TreatmentDateTime,
    TreatmentDetails,
    NurseID,
    PatientID
  ) => {
    const query = `INSERT INTO treatment (TreatmentDateTime, TreatmentDetails, NurseID, PatientID) VALUES (?, ?, ?, ?)`;
    await promisePool.query(query, [
      TreatmentDateTime,
      TreatmentDetails,
      NurseID,
      PatientID,
    ]);
  },
  makeReservation: async

 (ReservationDateTime, DepartmentID, userId) => {
    const patientQuery = `SELECT PatientID FROM patient WHERE UserID = ?`;
    const [patientRows] = await promisePool.query(patientQuery, [userId]);
    if (patientRows.length === 0) {
      throw new Error("No patient found with the given user ID.");
    }
    const patientId = patientRows[0].PatientID;
    const reservationQuery = `INSERT INTO reservation (ReservationDateTime, DepartmentID, PatientID) VALUES (?, ?, ?)`;
    await promisePool.query(reservationQuery, [
      ReservationDateTime,
      DepartmentID,
      patientId,
    ]);
  },
};

export const updateSql = {
  updateStaff: async (staffId, updatedDetails, role) => {
    const staffTable = role === "DOCTOR" ? "doctor" : "nurse";
    const staffIdColumn = role === "DOCTOR" ? "DoctorID" : "NurseID";
    const updateStaffQuery = `
        UPDATE ${staffTable}
        SET Name = ?, Address = ?, PhoneNumber = ?
        WHERE ${staffIdColumn} = ?;
      `;
    await promisePool.query(updateStaffQuery, [
      updatedDetails.Name,
      updatedDetails.Address,
      updatedDetails.PhoneNumber,
      staffId,
    ]);
    if (updatedDetails.Username || updatedDetails.Password) {
      const getUserQuery = `SELECT UserID FROM ${staffTable} WHERE ${staffIdColumn} = ?`;
      const [userRows] = await promisePool.query(getUserQuery, [staffId]);
      if (userRows.length === 0) {
        throw new Error("No user found with the given staff ID.");
      }
      const userId = userRows[0].UserID;
      const updateUserQuery = `
          UPDATE user
          SET Username = ?, Password = ?
          WHERE UserID = ?;
        `;
      await promisePool.query(updateUserQuery, [
        updatedDetails.Username,
        updatedDetails.Password,
        userId,
      ]);
    }
  },
  updateExamination: async (
    examinationId,
    ExaminationDateTime,
    ExaminationDetails,
    PatientID
  ) => {
    const query = `UPDATE examination SET ExaminationDateTime = ?, ExaminationDetails = ?, PatientID = ? WHERE ExaminationID = ?`;
    await promisePool.query(query, [
      ExaminationDateTime,
      ExaminationDetails,
      PatientID,
      examinationId,
    ]);
  },
  updateTreatment: async (
    treatmentId,
    TreatmentDateTime,
    TreatmentDetails,
    PatientID
  ) => {
    const query = `UPDATE treatment SET TreatmentDateTime = ?, TreatmentDetails = ?, PatientID = ? WHERE TreatmentID = ?`;
    await promisePool.query(query, [
      TreatmentDateTime,
      TreatmentDetails,
      PatientID,
      treatmentId,
    ]);
  },
};

export const deleteSql = {
  deleteStaff: async (staffId, role) => {
    const staffTable = role === "DOCTOR" ? "doctor" : "nurse";
    const staffIdColumn = role === "DOCTOR" ? "DoctorID" : "NurseID";
    const selectQuery = `SELECT UserID FROM ${staffTable} WHERE ${staffIdColumn} = ?`;
    const [userRows] = await promisePool.query(selectQuery, [staffId]);
    if (userRows.length === 0) {
      throw new Error("No user found with the given staff ID.");
    }
    const userId = userRows[0].UserID;
    const deleteStaffQuery = `DELETE FROM ${staffTable} WHERE ${staffIdColumn} = ?`;
    await promisePool.query(deleteStaffQuery, [staffId]);
    const deleteUserQuery = "DELETE FROM user WHERE UserID = ?";
    await promisePool.query(deleteUserQuery, [userId]);
  },
  deleteExamination: async (examinationId) => {
    const query = `DELETE FROM examination WHERE ExaminationID = ?`;
    await promisePool.query(query, [examinationId]);
  },
  deleteTreatment: async (treatmentId) => {
    const query = `DELETE FROM treatment WHERE TreatmentID = ?`;
    await promisePool.query(query, [treatmentId]);
  },
  cancelReservation: async (reservationId) => {
    const query = `DELETE FROM reservation WHERE ReservationNumber = ?`;
    await promisePool.query(query, [reservationId]);
  },
};
```

### Index.js 설계

```javascript
import express from "express";
import logger from "morgan";
import path from "path";
import expressSession from "express-session";
import loginRouter from "../routes/login";
import adminRouter from "../routes/admin";
import doctorRouter from "../routes/doctor";
import nurseRouter from "../routes/nurse";
import patientRouter from "../routes/patient";

const PORT = 3000;

const app = express();

app.use(express.static(path.join(__dirname, "/public")));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(
  expressSession({
    secret: "hospital_management_secret",
    resave: true,
    saveUninitialized: true,
  })
);

app.set("views", path.join(__dirname, "../views"));
app.set("view engine", "hbs");

app.use(logger("dev"));

app.use("/", loginRouter);
app.use("/admin", adminRouter);
app.use("/doctor", doctorRouter);
app.use("/nurse", nurseRouter);
app.use("/patient", patientRouter);

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
```

### Login.js 및 Login.hbs 설계

#### Login.js

```javascript
import express from "express";
import { selectSql } from "../Database/sql";

const router = express.Router();

router.get("/", (req, res) => {
  res.render("login");
});

router.post("/", async (req, res) => {
  const userdata = req.body;
  try {
    const user = await selectSql.getUserByUsername(userdata.username);
    if (
      user.Username === userdata.username &&
      user.Password === userdata.password
    ) {
      req.session.user = { UserID: user.UserID, Role: user.Role };
      switch (user.Role) {
        case "ADMIN":
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
```

#### Login.hbs

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <style>
        body {
            height: 75vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #f5f5f5;
        }
        .frame {
            border-radius: 15px;
            border: 1px solid #757575;
            padding: 20px;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 350px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        input, .btn {
            font-size: 16px;
            padding: 10px;
            margin: 10px 0;
        }
        .btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="frame">
        <h1>Login</h1>
        <form method="post" action='/'>
            <input name="username" type="text" required placeholder="Username">
            <input name='password' type="password" required placeholder="Password">
            <button class='btn' type="submit">Login</button>
        </form>
    </div>
</body>
</html>
```

## 실행 화면

### 관리자 페이지

#### 의사 정보 입력
관리자 `admin1` | 비밀번호 `123` | 역할 `ADMIN`으로 로그인한 화면입니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/5ce22ae4-3bff-4b34-be03-b10dd1983ee6)

- Add staff Member에 데이터 값을 입력한 뒤 Add staff 버튼을 누릅니다.
- 버튼을 누르면 맨 밑에 새로 입력한 의사 데이터가 생성된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/ee40fd75-06f7-4bd0-bc13-a7da38573c8e)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/bd91bb17-ee31-4317-a1e5-ac85409dfe0e)

#### 의사 정보 수정
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/fe1262f5-3348-4901-8124-237fdcc84be2)

- 기존 의사 데이터의 이름을 변경하고, 주소와 전화번호를 수정한 뒤 Edit 버튼을 눌러 수정합니다.
- 정상적으로 의사 정보가 수정된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/4726e152-18fe-4c7d-85a9-d808fa246d17)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/f4356996-f225-4002-96f9-b46f20b6e572)

#### 의사 정보 삭제
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/7f170887-3fec-4472-b085-928df70fb412)

- 의사 목록에서 특정 의사를 선택하여 Delete 버튼을 눌러 삭제합니다.
- 정상적으로 의사 정보가 삭제된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/4558dc46-23c9-4b4d-9ad6-b216e0c05629)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/074032e5-28e1-442b-b0c0-fde82f89e5cb)

#### 간호사 정보 입력
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/0d372e4c-ebb1-4946-b90b-5af03041ffd1)

- Add staff member에서 Nurse로 변경 후 데이터를 입력한 뒤 Add staff 버튼을 눌러 간호사 정보를 추가합니다.
- 맨 밑에 새로 입력한 간호사 데이터가 생성된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/91a95cbc-dd5e-4381-a333-844b0db36c26)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/e8b7b2b4-c535-4cfc-9911-1362d5887b7c)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/b1cd500d-2c50-4589-927a-485da1399c66)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/fc42f6a9-fed7-425e-a09f-47e9068655dc)

#### 간호사 정보 수정
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/0ad58481-3c41-4588-aebb-ee5d6797197e)

- 기존 간호사 데이터의 이름을 변경하고, 주소와 전화번호를 수정한 뒤 Edit 버튼을 눌러 수정합니다.
- 정상적으로 간호사 정보가 수정된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/94278f77-4f45-47a2-8e49-c523436e2e9a)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/1b9f3818-c937-4577-9346-68f07165dbee)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/f4413012-fb8d-42f9-8250-472f0bcf064f)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/ecb02cc2-65a0-4911-b48b-bb99a206f747)

#### 간호사 정보 삭제
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/68feb722-302e-487c-b51d-fa6a4dd931d8)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/964e04a4-bde9-4fd1-b9d7-fc2890143e96)

- 간호사 목록에서 특정 간호사를 선택하여 Delete 버튼을 눌러 삭제합니다.
- 정상적으로 간호사 정보가 삭제된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/15855c8e-e559-4fac-94a0-ee210a03e7d6)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/ed530369-fba5-4158-8446-3b9845bd4b1c)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/c46dc8c6-8091-4745-acd3-a3a523086f85)

### 직원(의사) 페이지

#### 검사 정보 입력
의사 `jennifer84` | 비밀번호 `123` | 역할 `DOCTOR`로 로그인한 화면입니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/c679f520-f7e5-488f-9ec5-b7b1b80c585d)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/ca8a56e0-c7f9-47a5-899a-0bd924a37a0f)

- 검사 날짜와 시간을 선택한 후 검사 세부사항을 입력하고 본인의 DoctorID와 환자의 PatientID를 입력한 뒤 Add Examination 버튼을 눌러 저장합니다.
- 새로운 검사 데이터가 생성된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/2a4af452-4716-42b9-a4e2-a69b71df6c48)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/b2503896-479d-4634-a03c-7e3a7e06a9b5)

#### 검사 정보 수정
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/759336ae-56c0-43ea-ad17-a943f9522da5)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/27546a88-0902-44a3-84bf-d506160e33cd)

- 기존 검사 데이터를 수정한 후 Edit 버튼을 눌러 변경합니다.
- 정상적으로 검사 정보가 수정된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/d9e4413e-7e80-46f7-89d4-962846ba7645)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/6139cbb3-2f7a-4789-ac5d-805f4f8eff1b)

#### 검사 정보 삭제
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/4b5411b3-5da8-4936-a672-6411bb50a3c4)

- 검사 목록에서 특정 검사를 선택하여 Delete 버튼을 눌러 삭제합니다.
- 정상적으로 검사 정보가 삭제된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/d87fce58-da5d-4a74-b415-ee05999b3312)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/a5108494-9ab1-4323-828c-4974571fe0ae)

#### 환자 검색
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/8adf400e-8ca7-4ee1-8967-e34d62fef969)

- 환자 이름이나 ID로 환자 정보를 검색합니다.
- 검색 결과가 테이블 형태로 표시됩니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/b3bf6972-2560-4de1-8c6b-850e5dfc15ea)

### 직원(간호사) 페이지

#### 치료 정보 입력
간호사 `rowlandashley` | 비밀번호 `123` | 역할 `NURSE`로 로그인한 화면입니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/e1221cd9-f05d-42bb-9201-4caf0c4ddc48)

- 치료 날짜와 시간을 선택한 후 치료 세부사항을 입력하고 본인의 NurseID와 환자의 PatientID를 입력한 뒤 Add Treatment 버튼을 눌러 저장합니다.
- 새로운 치료 데이터가 생성된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/4358e90e-4af6-4b0f-b6e1-8b191b36f17f)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/39645eab-140e-4110-9729-ae41406d4f5f)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/22847cfa-90e5-4228-946e-e6ade506cb36)

#### 치료 정보 수정
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/0658b7a2-4cdf-4c8c-bd1c-c2980fe96b45)

- 기존 치료 데이터를 수정한 후 Edit 버튼을 눌러 변경합니다.
- 정상적으로 치료 정보가 수정된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/3d41f79e-1013-4ace-a31e-d3fa726530b2)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/ec519bfa-171e-4056-b3a3-3f62d43d6563)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/39a889dd-1162-4d5f-9864-8bc011574218)

#### 치료 정보 삭제
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/0a6816bf-579f-44cd-a29c-051315dcc73a)

- 치료 목록에서 특정 치료를 선택하여 Delete 버튼을 눌러 삭제합니다.
- 정상적으로 치료 정보가 삭제된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/92d94939-6e57-48d8-a577-f17b7d6a023a)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/b93f1eb5-55b8-4bf3-8df0-ac3fb767038a)

#### 환자 검색
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/94717286-0ef3-417d-971a-e441a9ed400e)

- 환자 이름이나 ID로 환자 정보를 검색합니다.
- 검색 결과가 테이블 형태로 표시됩니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/0e3c1aee-b91a-4092-9799-e06c8a634505)

### 환자 페이지

#### 예약하기
환자 `whitealexandria` | 비밀번호 `123` | 역할 `PATIENT`으로 로그인한 화면입니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/e87d21f6-fbf4-4e13-bf40-c78b98029f0f)

- 예약 날짜와 시간을 선택하고 부서 ID를 입력한 뒤 예약 버튼을 클릭하여 예약합니다.
- 새로운 예약 데이터가 생성된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/5caa3af1-d922-4318-8da3-cb5ebf77767f)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/58843b85-87d7-48be-82b1-038d9072eeec)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/d47de0fe-a94c-4d67-aad0-e51d1a167a92)

#### 예약 조회
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/d0caba5d-45e5-47b0-89da-2fd2b1bc1801)

- 로그인하면 해당 환자의 예약 목록이 표시됩니다.

#### 예약 취소
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/7caf0d3d-e639-4251-8c36-ace3e8d7ae47)

- 예약 목록에서 특정 예약을 선택하여 Cancel Reservation 버튼을 눌러 예약을 취소합니다.
- 정상적으로 예약 정보가 삭제된 것을 확인할 수 있습니다.
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/d232ce09-7b6e-4f97-ab18-25af31c90b71)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/53d9a25f-2ae5-45e3-bf37-d8330c60bc25)

### INDEX 실행화면

#### 인덱스 생성 전
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/ca3448a9-7711-4ae3-8cf8-e4f4173089e0)

- 인덱스 생성 전의 데이터베이스 상태를 확인합니다.

#### 인덱스 생성 후
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/2c77304d-2749-415d-ae3b-9262ba30d11e)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/b7c39654-6481-4214-b973-01e72a7121a9)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/f5d6f7ec-6eb4-466d-ab89-54606159e237)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/5bb78997-5868-4d4f-9a2e-b9ca559b3dc7)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/fafbe71b-c828-4604-b7dc-d2ed85163240)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/e5db7eae-2d23-4f45-a771-3c93f831ba92)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/39fe4e75-b147-4e9c-83e7-0ea1093dde53)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/affd57b4-ab2f-453a-886b-fed1855a330b)

- 인덱스 생성 후의 데이터베이스 상태를 확인합니다.
- 인덱스를 생성하여 데이터 검색 속도가 향상된 것을 확인할 수 있습니다.

### VIEW 실행화면

#### ExaminationSummary 뷰
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/8a4245c6-2375-4f3f-894c-0b178d4b1b68)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/e2c8c793-71a2-41a2-8199-19a35c49e0ea)
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/59282001-d176-4fad-b961-fbbea401bb5a)

- 환자의 검사 정보를 종합적으로 조회할 수 있는 뷰를 생성하고 실행합니다.

#### TreatmentSummary 뷰
![image](https://github.com/tcpu1005/HospitalManagement/assets/106582928/77185ec2-ffd5-49d4-994f-dccd2f00fc72)

- 간호사에 의해 수행된 치료 정보를 종합적으로 조회할 수 있는 뷰를 생성하고 실행합니다.

### 트랜잭션 실행화면

#### 커밋 성공

- 트랜잭션이 성공적으로 커밋된 결과를 확인합니다.

#### 커밋 실패 후 롤백
- 트랜잭션이 실패하여 롤백된 결과를 확인합니다.

## 결론
이 텀 프로젝트를 통해 데이터베이스 설계의 핵심 원칙과 실제 응용 프로그램 구현에 필요한 기술을 심도 있게 학습하였습니다. ERD 설계에서부터 테이블의 정규화, 인덱스와 뷰의 구현, 데이터 삽입, 그리고 트랜잭션 관리에 이르기까지, 이 프로젝트는 복잡한 데이터베이스 시스템의 설계 및 구현 과정에 대한 깊은 이해를 제공합니다. 또한, 웹 인터페이스의 구현을 통해 사용자 친화적인 환경을 조성하며, 실제 병원 관리 시스템의 요구 사항을 충족하는 실용적인 솔루션을 제공합니다. 프로젝트의 완성은 이론과 실습의 결합을 통해 효과적인 학습 경험을 제공하며, 데이터베이스 설계 및 개발에 대한 실력을 한층 더 향상시켰습니다.
- **ERD 및 데이터베이스 설계:** 병원 시스템의 복잡한 데이터 관계를 효과적으로 모델링하는 ERD를 설계하여, 데이터 무결성과 일관성을 보장하는 강력한 데이터베이스 구조를 구축했습니다.
- **데이터베이스 정규화와 인덱스 최적화:** 데이터 중복을 최소화하고 쿼리 성능을 극대화하기 위해 테이블을 적절한 정규형으로 정규화하고, 인덱스를 신중하게 구현했습니다. 이를 통해 데이터 검색 속도와 시스템의 전반적인 효율성을 향상시켰습니다.
- **트랜잭션 관리 및 데이터 무결성 보장:** 복잡한 데이터베이스 작업을 위한 트랜잭션 관리를 통해 시스템의 데이터 무결성을 보장했습니다. 이는 데이터 일관성 유지 및 복구 메커니즘에서 중요한 역할을 합니다.
- **웹 인터페이스 구현:** 사용자 친화적인 웹 인터페이스를 통해 관리자, 의사, 간호사, 환자 등 다양한 사용자가 시스템과 효과적으로 상호작용할 수 있도록 했습니다. 이는 Handlebars 템플릿과 Express.js를 활용하여 구현되었습니다.
- **보안 및 접근 제어:** 사용자 권한에 따른 접근 제어를 통해 시스템의 보안을 강화했습니다. 이는 세션 관리와 역할 기반의 접근 제어 로직을 통해 구현되었습니다.
- **응용 프로그램의 실제 요구사항 대응:** 환자의 예약 시스템, 의료진의 검사 및 치료 기록 관리 등 병원 시스템의 핵심 요구사항을 충실히 반영했습니다.
```
