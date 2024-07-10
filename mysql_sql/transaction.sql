-- 트랜잭션 시작
START TRANSACTION;

-- 예약을 위한 변수 설정
SET @PatientID = 1; -- 환자 ID 설정
SET @DepartmentID = 1; -- 부서 ID 설정
SET @ReservationDateTime = '2023-12-16 11:52:00'; -- 예약 날짜 및 시간 설정

-- 기존 예약 확인
SELECT * FROM reservation
WHERE ReservationDateTime = @ReservationDateTime AND DepartmentID = @DepartmentID
FOR UPDATE;

-- 중복 예약 확인 결과에 따른 처리
-- 새 예약을 추가합니다.
INSERT INTO reservation (ReservationDateTime, DepartmentID, PatientID)
SELECT @ReservationDateTime, @DepartmentID, @PatientID
FROM DUAL
WHERE NOT EXISTS (
    SELECT 1 FROM reservation
    WHERE ReservationDateTime = @ReservationDateTime AND DepartmentID = @DepartmentID
);

-- 영향받은 행 수 확인
SET @affected_rows = ROW_COUNT();

-- 트랜잭션 커밋 또는 롤백
IF @affected_rows > 0 THEN
    -- 예약 성공
    COMMIT;
    SELECT 'Reservation successful!' AS Message;
ELSE
    -- 중복 예약 존재
    ROLLBACK;
    SELECT 'This time slot is already reserved.' AS Message;
END IF;
