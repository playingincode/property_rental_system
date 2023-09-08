INSERT INTO userdbs VALUES (123456789012, 'John Doe', 25, 'M', 560001, 123, 'Bangalore', 'Karnataka', 'johndoe', 'password123');
INSERT INTO userdbs VALUES (234567890123, 'Jane Smith', 32, 'F', 110001, 456, 'New Delhi', 'Delhi', 'janesmith', 'password456');
INSERT INTO userdbs VALUES (345678901234, 'Bob Johnson', 45, 'M', 600001, 789, 'Chennai', 'Tamil Nadu', 'bobjohnson', 'password789');
INSERT INTO userdbs VALUES (456789012345, 'Alice Brown', 28, 'F', 700001, 1011, 'Kolkata', 'West Bengal', 'alicebrown', 'password1011');
INSERT INTO userdbs VALUES (456789012349, 'Alica crown', 28, 'F', 700001, 1011, 'lucknow', 'UttarPradesh', 'alicacrown', 'password1012');
-- manager table
INSERT INTO manager VALUES (123456789012, 4.5, 50000);
INSERT INTO manager VALUES (345678901234, 3.2, 45000);

-- customer table
INSERT INTO customer VALUES (234567890123, 4.8);
INSERT INTO customer VALUES (456789012345, 3.9);
INSERT INTO customer VALUES (123456789012,4.0);
INSERT INTO customer VALUES(345678901234,5.0);

-- admin_dba table
INSERT INTO admin_dba VALUES (456789012349);

-- user_phone_no table
INSERT INTO user_phone_no VALUES (1234567890, 123456789012);
INSERT INTO user_phone_no VALUES (2345678901, 234567890123);
INSERT INTO user_phone_no VALUES (3456789012, 345678901234);
INSERT INTO user_phone_no VALUES (4567890123, 456789012345);

-- owner table
INSERT INTO owner VALUES (234567890123, 15000);
INSERT INTO owner VALUES (456789012345, 22000);

-- tenant table
INSERT INTO tenant VALUES (123456789012, 'Married');
INSERT INTO tenant VALUES (345678901234, 'Single');

-- property table
INSERT INTO property VALUES (1, 345678901234, 234567890123, TO_DATE('01/05/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY'), 12000, 0.03, 1200, 800, 5, 2015, '123 Main St, Bangalore, Karnataka');
INSERT INTO property VALUES (2, 345678901234, 234567890123, TO_DATE('01/06/2023', 'DD/MM/YYYY'), TO_DATE('30/11/2023', 'DD/MM/YYYY'), 15000, 0.05, 1500, 900, 4, 2012, '456 Park Ave, New Delhi, Delhi');
INSERT INTO property VALUES (3, 123456789012, 456789012345, TO_DATE('01/07/2023', 'DD/MM/YYYY'), TO_DATE('31/12/2023', 'DD/MM/YYYY'), 10000, 0.02, 1000, 700, 3, 2010, '789 1st St, Chennai, Tamil Nadu');

INSERT INTO COMMERCIAL VALUES(1,'SOFA,FRIDGE,RACKS','SHOP');
INSERT INTO COMMERCIAL VALUES(2,'PROJECTOR,ROUND TABLE,CHAIRS','HALL');

INSERT INTO RESIDENTIAL VALUES(3,3,'3BHK');



INSERT INTO currently_rented (property_id, aadhar_id, start_date, end_date, agency_comm)
VALUES(1, 123456789012, TO_DATE('01/01/2022','DD/MM/YYYY'), TO_DATE('01/01/2023','DD/MM/YYYY'), 2000);


INSERT INTO currently_rented (property_id, aadhar_id, start_date, end_date, agency_comm)
VALUES  (3, 345678901234,  TO_DATE('01/02/2023','DD/MM/YYYY'),  TO_DATE('01/02/2024','DD/MM/YYYY'), 2500);


INSERT INTO previously_rented(property_id, aadhar_id, start_date, end_date, rent_per_month, annual_hike, agency_comm)values(1, 123456789012,  TO_DATE('26/03/2016','DD/MM/YYYY'),  TO_DATE('28/04/2016','DD/MM/YYYY'), 15000, 0.05, 0.02);
INSERT INTO previously_rented(property_id, aadhar_id, start_date, end_date, rent_per_month, annual_hike, agency_comm)values(1, 345678901234,  TO_DATE('01/03/2017','DD/MM/YYYY'),  TO_DATE('02/05/2018','DD/MM/YYYY'), 17000, 0.05, 0.02);
INSERT INTO previously_rented(property_id, aadhar_id, start_date, end_date, rent_per_month, annual_hike, agency_comm)values(2, 123456789012,  TO_DATE('01/04/2018','DD/MM/YYYY'),  TO_DATE('01/07/2018','DD/MM/YYYY'), 20000, 0.03, 0.01);
INSERT INTO previously_rented(property_id, aadhar_id, start_date, end_date, rent_per_month, annual_hike, agency_comm)values(2, 345678901234,  TO_DATE('01/08/2019','DD/MM/YYYY'),  TO_DATE('10/10/2020','DD/MM/YYYY'), 22000, 0.03, 0.01);

