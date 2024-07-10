import express from "express";
import logger from "morgan";
import path from "path";
import expressSession from "express-session";
import loginRouter from "../routes/login";
import adminRouter from "../routes/admin"; // For admin operations
import doctorRouter from "../routes/doctor"; // For staff (Doctor and Nurse) operations
import nurseRouter from "../routes/nurse";
import patientRouter from "../routes/patient"; // For patient operations

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

// Setting up routes for different user roles
app.use("/", loginRouter);
app.use("/admin", adminRouter); // Admin route for managing doctors and nurses
app.use("/doctor", doctorRouter); // Staff route for managing examinations and treatments
app.use("/nurse", nurseRouter); // Staff route for managing examinations and treatments
app.use("/patient", patientRouter); // Patient route for managing reservations

app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});
