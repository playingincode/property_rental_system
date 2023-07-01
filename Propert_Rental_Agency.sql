
(
	aadhar_id number,
	rating number,
	salary number,
	primary key(aadhar_id),
	foreign key(aadhar_id) references userdbs(aadhar_id)
);



create table customer
(
	aadhar_id number,
	rating number,
	primary key(aadhar_id),
	foreign key(aadhar_id) references userdbs(aadhar_id)
);



create table admin_dba
(
	aadhar_id number,
	primary key(aadhar_id),
	foreign key(aadhar_id) references userdbs(aadhar_id)
);



create table user_phone_no
(
	phone_no number(12),
	aadhar_id number,
	primary key(phone_no, aadhar_id),
	foreign key(aadhar_id) references userdbs(aadhar_id)
);



create table owner
(
	aadhar_id number,
	expected_rent number,
	primary key(aadhar_id),
	foreign key(aadhar_id) references customer(aadhar_id)
);



create table tenant
(
	aadhar_id number,
	maritial_status varchar2(10),
	primary key(aadhar_id),
	foreign key(aadhar_id) references customer(aadhar_id)
);



create table property
(
	property_id number,
	manager_aadhar_id number,
	owner_aadhar_id number,
	available_from date,
	available_till date,
	rent_per_month number,
	annual_hike number,
	total_area number,
	plinth_area number,
	no_of_floors number,
	construction_year number(4),
	address varchar2(500),
	primary key(property_id),
	foreign key(owner_aadhar_id) references owner(aadhar_id),
	foreign key(manager_aadhar_id) references manager(aadhar_id)
);



create table commercial
(
	property_id number,
	prebuilt_infra varchar2(200),
	type varchar2(200),
	primary key(property_id),
	foreign key(property_id) references property(property_id)
);



create table residential
(
	property_id number,
	no_of_bedrooms number, 
	type varchar2(20),
	primary key(property_id),
	foreign key(property_id) references property(property_id)
);



create table currently_rented
(
	property_id number,
	aadhar_id number,
	start_date date,
	end_date date,	
	agency_comm number,
	primary key(property_id, aadhar_id),
	foreign key(property_id) references property(property_id),
	foreign key(aadhar_id) references tenant(aadhar_id)
);



create table previously_rented
(
	property_id number,
	aadhar_id number,
	start_date date,
	end_date date,
	rent_per_month number,
	annual_hike number,
	agency_comm number,
	primary key(property_id, aadhar_id, start_date),
	foreign key(property_id) references property(property_id),
	foreign key(aadhar_id) references tenant(aadhar_id)
);







create or replace procedure InsertPropertyRecord
(
	p_id in property.property_id%type,
	m_a_id in number,
	o_a_id in property.owner_aadhar_id%type,
	from_date in property.available_from%type,
	till_date in property.available_till%type,
	rent in property.rent_per_month%type,
	hike in property.annual_hike%type,
	tot_area in property.total_area%type,
	p_area in property.plinth_area%type,
	floors in property.no_of_floors%type,
	c_year in property.construction_year%type,
	address in property.address%type
)
as
    v_id owner.aadhar_id%type;
    v_count number;
begin
    v_id := o_a_id;
    select count(*) into v_count from owner where v_id = aadhar_id;
    if v_count = 0
        then insert into owner values (o_a_id, rent);
    end if;
	insert into property values (p_id, m_a_id, o_a_id, from_date, till_date, rent, hike, tot_area, p_area, floors, c_year, address);
end;
/


create or replace procedure AuxilaryGetPropertyRecords (id in property.property_id%type) as
	v_res residential%rowtype;
	v_com commercial%rowtype;
	cursor res_cursor is select * from residential where id = property_id;
	cursor com_cursor is select * from commercial where id = property_id;
begin
	open res_cursor;
	open com_cursor;
	loop
		fetch res_cursor into v_res;
		exit when res_cursor%notfound;
		DBMS_OUTPUT.PUT_LINE(RPAD('CATEGORY',20)||': '||'RESIDENTIAL');
		DBMS_OUTPUT.PUT_LINE(RPAD('TYPE',20)||': '||v_res.type);
		DBMS_OUTPUT.PUT_LINE(RPAD('NO OF BEDROOMS',20)||': '||v_res.no_of_bedrooms);
	end loop;
	loop
		fetch com_cursor into v_com;
		exit when com_cursor%notfound;
		DBMS_OUTPUT.PUT_LINE(RPAD('CATEGORY',20)||': '||'COMMERCIAL');
		DBMS_OUTPUT.PUT_LINE(RPAD('TYPE',20)||': '||v_com.type);
		DBMS_OUTPUT.PUT_LINE(RPAD('PREBUILT INFRA',20)||': '||v_com.prebuilt_infra);
	end loop;
	close res_cursor;
	close com_cursor;
end;
/
    

create or replace procedure GetPropertyRecords (id in owner.aadhar_id%type) as
	
	cursor prop_cursor is select *  from property where owner_aadhar_id = id;
begin
	DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	DBMS_OUTPUT.PUT_LINE('PROPERTY INFORMATION');
    DBMS_OUTPUT.PUT_LINE(LPAD('-' ,40, '-'));
	for l_idx in prop_cursor
	loop
		DBMS_OUTPUT.PUT_LINE(RPAD('PROPERTY ID',20)||': '||l_idx.property_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('MANAGER ID',20)||': '||l_idx.manager_aadhar_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('AVAILABLE FROM',20)||': '||l_idx.available_from);
		DBMS_OUTPUT.PUT_LINE(RPAD('AVAILABLE TILL',20)||': '||l_idx.available_till);
		DBMS_OUTPUT.PUT_LINE(RPAD('RENT PER MONTH',20)||': '||l_idx.rent_per_month);
		DBMS_OUTPUT.PUT_LINE(RPAD('ANNUAL HIKE',20)||': '||l_idx.annual_hike);
		DBMS_OUTPUT.PUT_LINE(RPAD('TOTAL AREA',20)||': '||l_idx.total_area);
		DBMS_OUTPUT.PUT_LINE(RPAD('PLINTH AREA',20)||': '||l_idx.plinth_area);
		DBMS_OUTPUT.PUT_LINE(RPAD('NUMBER OF FLOORS',20)||': '||l_idx.no_of_floors);
		DBMS_OUTPUT.PUT_LINE(RPAD('CONSTRUCTION YEAR',20)||': '||l_idx.construction_year);
		AuxilaryGetPropertyRecords(l_idx.property_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('ADDRESS',20)||': '||l_idx.address);
		DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	end loop;
end;
/






create or replace procedure GetTenantDetails (id in property.property_id%type) as
	v_phone user_phone_no.phone_no%type;
	v_mstatus tenant.maritial_status%type;
	v_user userdbs%rowtype;
	v_rating customer.rating%type;
	cursor ten_cursor is select * from userdbs where aadhar_id in (select aadhar_id from currently_rented where property_id = id);
	cursor phone_cursor is select u_pno.phone_no from user_phone_no u_pno where u_pno.aadhar_id in (select aadhar_id from currently_rented where property_id = id);
	cursor mstatus_cursor is select t.maritial_status from tenant t where t.aadhar_id in (select aadhar_id from currently_rented where property_id = id);
	cursor rating_cursor is select c.rating from customer c where c.aadhar_id in (select aadhar_id from currently_rented where property_id = id);
begin
	DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	DBMS_OUTPUT.PUT_LINE('PROPERTY INFORMATION');
	DBMS_OUTPUT.PUT_LINE(LPAD('-' ,40, '-'));
	open ten_cursor;
	open phone_cursor;
	open mstatus_cursor;
	open rating_cursor;
	loop
		fetch ten_cursor into v_user;
		fetch phone_cursor into v_phone;
		fetch mstatus_cursor into v_mstatus;
		fetch rating_cursor into v_rating;
		exit when ten_cursor%notfound or phone_cursor%notfound or mstatus_cursor%notfound or rating_cursor%notfound;
		DBMS_OUTPUT.PUT_LINE(RPAD('AADHAR ID',20)||': '||v_user.aadhar_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('NAME',20)||': '||v_user.name);
		DBMS_OUTPUT.PUT_LINE(RPAD('AGE',20)||': '||v_user.age);
		DBMS_OUTPUT.PUT_LINE(RPAD('GENDER',20)||': '||v_user.gender);
		DBMS_OUTPUT.PUT_LINE(RPAD('MARITIAL STATUS',20)||': '||v_mstatus);
		DBMS_OUTPUT.PUT_LINE(RPAD('PHONE NO',20)||': '||v_phone);
		DBMS_OUTPUT.PUT_LINE(RPAD('DOOR NO',20)||': '||v_user.door_no);
		DBMS_OUTPUT.PUT_LINE(RPAD('CITY',20)||': '||v_user.city);
		DBMS_OUTPUT.PUT_LINE(RPAD('STATE',20)||': '||v_user.state);
		DBMS_OUTPUT.PUT_LINE(RPAD('PIN CODE',20)||': '||v_user.pin_code);
		DBMS_OUTPUT.PUT_LINE(RPAD('RATING',20)||': '||v_rating);
	end loop;
	close ten_cursor;
	close phone_cursor;
	close mstatus_cursor;
	close rating_cursor;
end;
/



create or replace procedure CreateNewUser
(   
	us_name in userdbs.user_name%type,
	pass in userdbs.password%type,
	id in userdbs.aadhar_id%type,
	name in userdbs.name%type,
	age in userdbs.age%type,
	gender in userdbs.gender%type,
	phone in user_phone_no.phone_no%type,
	door in userdbs.door_no%type,
	city in userdbs.city%type,
	state in userdbs.state%type,
	pin in userdbs.pin_code%type,
	type in varchar2
)
as
begin
	insert into userdbs values (id, name, age, gender, pin, door, city, state,us_name, pass);
	insert into user_phone_no values (phone, id);
	if type = 'CUSTOMER'
		then insert into customer values (id, null);
	elsif type = 'MANAGER'
		then insert into manager values (id, null, null);
	end if;
end;
/



create or replace procedure SearchPropertyForRent (area in varchar2) as
	l_idx property%rowtype;
	cursor prop_cursor is select * from property p where p.address like ('%'||area||'%') and p.property_id not in 
	(select cr.property_id from currently_rented cr) ;
begin
	DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	DBMS_OUTPUT.PUT_LINE('PROPERTY INFORMATION');
	DBMS_OUTPUT.PUT_LINE(LPAD('-' ,40, '-'));
	for l_idx in prop_cursor
	loop
		DBMS_OUTPUT.PUT_LINE(RPAD('PROPERTY ID',20)||': '||l_idx.property_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('MANAGER ID',20)||': '||l_idx.manager_aadhar_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('AVAILABLE FROM',20)||': '||l_idx.available_from);
		DBMS_OUTPUT.PUT_LINE(RPAD('AVAILABLE TILL',20)||': '||l_idx.available_till);
		DBMS_OUTPUT.PUT_LINE(RPAD('RENT PER MONTH',20)||': '||l_idx.rent_per_month);
		DBMS_OUTPUT.PUT_LINE(RPAD('ANNUAL HIKE',20)||': '||l_idx.annual_hike);
		DBMS_OUTPUT.PUT_LINE(RPAD('TOTAL AREA',20)||': '||l_idx.total_area);
		DBMS_OUTPUT.PUT_LINE(RPAD('PLINTH AREA',20)||': '||l_idx.plinth_area);
		DBMS_OUTPUT.PUT_LINE(RPAD('NUMBER OF FLOORS',20)||': '||l_idx.no_of_floors);
		DBMS_OUTPUT.PUT_LINE(RPAD('CONSTRUCTION YEAR',20)||': '||l_idx.construction_year);
		AuxilaryGetPropertyRecords(l_idx.property_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('ADDRESS',20)||': '||l_idx.address);
		DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	end loop;
end;
/

create or replace procedure GetRentHistory (id in property.property_id%type) as
v_rented previously_rented%rowtype;
cursor rented_cursor is select * from previously_rented where previously_rented.property_id = id;
begin
	DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	DBMS_OUTPUT.PUT_LINE('PROPERTY INFORMATION');
	DBMS_OUTPUT.PUT_LINE(LPAD('-' ,40, '-'));
	for l_idx in rented_cursor
	loop
		DBMS_OUTPUT.PUT_LINE(RPAD('PROPERTY ID',20)||': '||l_idx.property_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('TENANT ID',20)||': '||l_idx.aadhar_id);
		DBMS_OUTPUT.PUT_LINE(RPAD('RENTED FROM',20)||': '||l_idx.start_date);
		DBMS_OUTPUT.PUT_LINE(RPAD('RENTED TILL',20)||': '||l_idx.end_date);
		DBMS_OUTPUT.PUT_LINE(RPAD('RENT PER MONTH',20)||': '||l_idx.rent_per_month);
		DBMS_OUTPUT.PUT_LINE(RPAD('ANNUAL HIKE',20)||': '||l_idx.annual_hike);
		DBMS_OUTPUT.PUT_LINE(RPAD('AGENCY COMMISSION',20)||': '||l_idx.agency_comm);
		DBMS_OUTPUT.PUT_LINE(LPAD('-',40,'-'));
	end loop;
end;
/
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


-- select * from userdbs;
-- select * from manager;
-- select * from customer;
-- select * from admin_dba;
-- select * from user_phone_no;
-- select * from owner;
-- select * from tenant;
-- select * from property;
-- select * from commercial;
-- select * from residential;
-- select * from currently_rented;
-- select * from previously_rented;

-- --procedures--
-- EXEC InsertPropertyRecord(4,123456789012,234567890123,TO_DATE('01/05/2022','DD/MM/YYYY'), TO_DATE('01/09/2023','DD/MM/YYYY'),2000,0.09,1300,900,4,2011,'01 ,BAKERS STREET,WASHINGTON DC,USA');
-- select * from property; 
-- exec GetPropertyRecords(234567890123);
-- exec GetTenantDetails(1);
-- exec createnewuser('danej','password234',21023456789,'dane james',20,'M',9090909090,5,'rome','Lazio',967123,'CUSTOMER');
-- select * from userdbs;
-- exec SearchPropertyForRent('Delhi');
-- exec getrenthistory(1);