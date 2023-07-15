USE lab5;

/* 1. �������� ������� �����. */
ALTER TABLE booking
ADD CONSTRAINT fk_booking_id_client
FOREIGN KEY (id_client) REFERENCES client(id_client)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room
ADD CONSTRAINT fk_room_id_hotel
FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room
ADD CONSTRAINT fk_room_id_room_category
FOREIGN KEY (id_room_category) REFERENCES room_category(id_room_category)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room_in_booking
ADD CONSTRAINT fk_room_in_booking_id_booking
FOREIGN KEY (id_booking) REFERENCES booking(id_booking)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE room_in_booking
ADD CONSTRAINT fk_room_in_booking_id_room
FOREIGN KEY (id_room) REFERENCES room(id_room)
ON UPDATE CASCADE ON DELETE CASCADE;

/* 2. ������ ���������� � �������� ��������� �������, ����������� � ������� ��������� ����� �� 1 ������ 2019�. */
SELECT client.name, client.phone FROM client
INNER JOIN booking ON client.id_client = booking.id_client
INNER JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking 
	AND room_in_booking.checkin_date <= '2019-04-01' AND '2019-04-01' < room_in_booking.checkout_date
INNER JOIN room ON room_in_booking.id_room = room.id_room
INNER JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = '������'
INNER JOIN room_category ON room.id_room_category = room_category.id_room_category 
	AND room_category.name = '����';

/* 3. ���� ������ ��������� ������� ���� �������� �� 22 ������. */
-- ���� ����� ������� �� ��� ������������ - �� ��������
SELECT DISTINCT hotel.name AS hotel_name, room.number AS number, room_category.name AS category, room.price AS price FROM room
LEFT JOIN room_in_booking ON room.id_room = room_in_booking.id_room 
	AND NOT (room_in_booking.checkin_date <= '2019-04-22' AND '2019-04-22' < room_in_booking.checkout_date)
INNER JOIN hotel ON room.id_hotel =  hotel.id_hotel
INNER JOIN room_category ON room.id_room_category = room_category.id_room_category;

/* 4. ���� ���������� ����������� � ��������� ������� �� 23 ����� �� ������ ��������� ������� */
SELECT room_category.name AS category_name, COUNT(client.id_client) AS residents_amount FROM client
INNER JOIN booking ON client.id_client = booking.id_client
INNER JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking AND room_in_booking.checkin_date <= '2019-03-23'
	AND '2019-03-23' < room_in_booking.checkout_date
INNER JOIN room ON room_in_booking.id_room = room.id_room
INNER JOIN room_category ON room.id_room_category = room_category.id_room_category
INNER JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = '������'
GROUP BY room_category.name;

/* 5. ���� ������ ��������� ����������� �������� �� ���� �������� ��������� �������,
   ��������� � ������ � ��������� ���� ������. */
SELECT client.name, room.number, MAX(room_in_booking.checkout_date) AS checkout_date FROM client
INNER JOIN booking ON client.id_client = booking.id_client
INNER JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking 
	AND MONTH(room_in_booking.checkout_date) = 4
INNER JOIN room ON room_in_booking.id_room = room.id_room
INNER JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = '������'
GROUP BY client.name, room.number;

/* 6. �������� �� 2 ��� ���� ���������� � ��������� ������� ���� �������� ������
   ��������� �������, ������� ���������� 10 ���. */
UPDATE room_in_booking
SET room_in_booking.checkout_date = DATEADD(DAY, 2, room_in_booking.checkout_date) FROM booking
INNER JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking 
	AND room_in_booking.checkin_date = '2019-05-10'
INNER JOIN room ON room_in_booking.id_room = room.id_room
INNER JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = '������'
INNER JOIN room_category ON room.id_room_category = room_category.id_room_category 
	AND room_category.name = '������';

SELECT client.name AS client_name, room_in_booking.checkout_date AS checkout_date FROM client
INNER JOIN booking ON client.id_client = booking.id_client
INNER JOIN room_in_booking ON booking.id_booking = room_in_booking.id_booking
	AND room_in_booking.checkin_date = '2019-05-10'
INNER JOIN room ON room_in_booking.id_room = room.id_room
INNER JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = '������'
INNER JOIN room_category ON room.id_room_category = room_category.id_room_category 
	AND room_category.name = '������';

/* 7. ����� ��� "��������������" �������� ����������. ���������� ���������: ��
   ����� ���� ������������ ���� ����� �� ���� ���� ��������� ���, �.�. ������
   ���������� ���������� �������� � ���� �����. ������ � �������
   room_in_booking � id_room_in_booking = 5 � 2154 �������� ��������
   ������������� ���������, ������� ���������� �����. �������������� ������
   ������� ������ ��������� ���������� � ���� ������������� �������. */
SELECT * FROM room_in_booking room_in_booking_1
INNER JOIN room_in_booking room_in_booking_2 ON room_in_booking_1.id_room = room_in_booking_2.id_room
WHERE room_in_booking_1.id_room_in_booking <> room_in_booking_2.id_room_in_booking
AND room_in_booking_1.checkin_date <= room_in_booking_2.checkin_date
AND room_in_booking_1.checkout_date > room_in_booking_2.checkout_date;

/* 8. ������� ������������ � ����������. */
BEGIN TRAN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
DECLARE @id_client INT = 9;
DECLARE @checkin_date DATE = '2022-04-22', @checkout_date DATE = '2022-05-22';
DECLARE @hotel_name VARCHAR(255) = '������', @room_number INT = 69;

INSERT INTO booking (id_client, booking_date)
VALUES (@id_client, GETDATE());

DECLARE @id_booking INT = (SELECT TOP(1) id_booking FROM booking
ORDER BY booking_date DESC);

DECLARE @id_room INT = (SELECT TOP(1) room.id_room FROM room
INNER JOIN hotel ON room.id_hotel = hotel.id_hotel AND hotel.name = @hotel_name
WHERE room.number = @room_number);

INSERT INTO room_in_booking (id_booking, id_room, checkin_date, checkout_date)
VALUES (SCOPE_IDENTITY(), @id_room, @checkin_date, @checkout_date);
COMMIT TRAN;

/* 9. �������� ����������� ������� ��� ���� ������. */
CREATE NONCLUSTERED INDEX ix_booking_id_client ON booking
(
	id_client ASC
)

CREATE NONCLUSTERED INDEX ix_room_in_booking_id_booking ON room_in_booking
(
	id_booking ASC
)

CREATE NONCLUSTERED INDEX ix_room_in_booking_id_room ON room_in_booking
(
	id_room ASC
)

CREATE NONCLUSTERED INDEX ix_room_id_hotel ON room
(
	id_hotel ASC
)

CREATE NONCLUSTERED INDEX ix_room_id_room_category ON room
(
	id_room_category ASC
)