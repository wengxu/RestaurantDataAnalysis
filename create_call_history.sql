CREATE TABLE call_history (
    call_type varchar (25),
    name varchar (50),
    num varchar (40) NOT NULL, 
    call_time timestamp NOT NULL, 
    length varchar (10) NOT NULL, 
    PRIMARY KEY (num, call_time)
);