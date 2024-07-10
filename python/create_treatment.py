from faker import Faker
import random

# Initialize Faker instance
fake = Faker()

def generate_sql_insert_treatments(num_records):
    for _ in range(num_records):
        treatment_datetime = fake.date_time_this_decade().strftime('%Y-%m-%d %H:%M:%S')
        treatment_details = fake.sentence(nb_words=10).replace("'", "\\'")
        nurse_id = random.randint(1, 20)  # Assuming there are 20 nurses
        patient_id = random.randint(1, 100)  # Assuming there are 100 patients
        sql_statement = f"INSERT INTO `treatment` (`TreatmentDateTime`, `TreatmentDetails`, `NurseID`, `PatientID`) VALUES ('{treatment_datetime}', '{treatment_details}', {nurse_id}, {patient_id});"
        print(sql_statement)

# Demonstration with 5 records for brevity
generate_sql_insert_treatments(100000)
