/*
=============================================================================
DDL Script: Create Bronze Tables
=============================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping existing tables
  if they already exist.
  Run this script to re-define DDL structure of 'bronze' Tables
=============================================================================
*/

IF OBJECT_ID ('bronze.Traffic' , 'U') IS NOT NULL
	DROP TABLE bronze.Traffic;
CREATE TABLE bronze.Traffic (
	count_point_id INT,
    road_name VARCHAR(10),
    region_id TINYINT,
    local_authority_id SMALLINT,
    direction_of_travel CHAR(1),
    hour TINYINT,
    pedal_cycles INT,
    two_wheeled_motor_vehicles INT,
    cars INT,
    buses INT,
    LGVs INT,
    HGVs_2_rigid_axle INT,
    HGVs_3_rigid_axle INT,
    HGVs_4_rigid_axle INT,
    HGVs_4_articulated_axle INT,
    HGVs_5_articulated_axle INT,
    HGVs_6_articulated_axle INT,
    all_HGVs INT,
    all_motor_vehicles INT
);

IF OBJECT_ID ('bronze.LocalAuthority' , 'U') IS NOT NULL
	DROP TABLE bronze.LocalAuthority;
CREATE TABLE bronze.LocalAuthority (
    local_authority_id INT,
    local_authority_name VARCHAR(50),
    local_authority_code VARCHAR(50)
);

IF OBJECT_ID ('bronze.Location' , 'U') IS NOT NULL
	DROP TABLE bronze.Location;
CREATE TABLE bronze.Location (
    easting INT,
    northing INT,
    latitude FLOAT,
    longitude FLOAT,
    region_id INT,
    local_authority_id INT
);

IF OBJECT_ID ('bronze.Region' , 'U') IS NOT NULL
	DROP TABLE bronze.Region;
CREATE TABLE bronze.Region(
    region_id  INT,
    region_name VARCHAR(60),
    region_ons_code VARCHAR(50)
);

IF OBJECT_ID ('bronze.Road' , 'U') IS NOT NULL
	DROP TABLE bronze.Road;
CREATE TABLE bronze.Road(
    road_name VARCHAR(15),
    road_category CHAR(2),
    road_type VARCHAR(20),
    start_junction_road_name VARCHAR(100),
    end_junction_road_name VARCHAR(100),
    link_length_km VARCHAR(50)
);

IF OBJECT_ID ('bronze.Date' , 'U') IS NOT NULL
	DROP TABLE bronze.Date;
CREATE TABLE bronze.Date(
    count_date VARCHAR(50),
    day TINYINT,
    month TINYINT,
    year SMALLINT
);
