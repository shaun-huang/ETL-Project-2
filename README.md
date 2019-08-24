# **LOS ANGELES COLLISION ETL** 

by
Amairani Garcia, Christian Bourdeau, Christopher Dimmock, and Shan Huang

## PROJECT PROPOSAL

Before you start writing any code, remember that you only have one week to complete this project. View this project as a typical assignment from work. Imagine a bunch of data came in and you and your team are tasked with migrating it to a production data base.

## PROJECT DESCRIPTION:

Based on the research of traffic collisions for the City of Los Angeles from 2010 to 2019, data will be pulled and migrated to a PostgreSQL database. 

## Finding Data

- EXTRACT: LA Collision data was extracted from the following two sources: 

	- Lacity.org
	- US Census Bureau

LA City data was formatted in a CSV file, while US Census Bureau had to be hard code in a csv file from text. 

## Data Cleanup & Analysis

- TRANSFORM: Useless columns and Null values were dropped. Columns were renamed, ethnicities and genders were map. Data was aggregated into separate tables and unique ID's were created. Quickdatabasediagrams.com was used as tool to create relationship among the data and joining the tables.

- LOAD: The clean csv data was imported into PostgreSQL as this was found to be the best way to not only illustrate and connect the relationship within the data, but also to effectively pull quick information from the database for multiple business purposes. 
Eight individual table were created as described below:
	- "Victim" table, holds all the unique ID's of each of the tables. This was used to join all tables. 
	- "LAPopulation" table, contains the LA Population data extracted from the US Census Bureau. 
	- The remaining six tables: "Crash", "Area", "Coordinates", "District", "Gender", and "Ethnicity" retain all the data from the LA 	   City broken down into their own entities. 
	- Aside from the "Victim" table, the "Crash" table also holds the unique crash_id column, which displays every single collision incident occurred.
	- "LAPopulation" was separately joined with the "Ethnicity" table through the aggregated major races displayed in the US Census Bureau.

