from faker import Faker
import random

# Initialize Faker instance
fake = Faker()

def generate_sql_insert_examinations(num_records):
    for _ in range(num_records):
        examination_datetime = fake.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S')
        examination_details = fake.sentence(nb_words=10).replace("'", "\\'")
        doctor_id = random.randint(1, 10)  # Assuming there are 10 doctors
        patient_id = random.randint(1, 100)  # Assuming there are 100 patients
        sql_statement = f"INSERT INTO `examination` (`ExaminationDateTime`, `ExaminationDetails`, `DoctorID`, `PatientID`) VALUES ('{examination_datetime}', '{examination_details}', {doctor_id}, {patient_id});"
        print(sql_statement)

# Demonstration with 5 records for brevity
generate_sql_insert_examinations(100000)
