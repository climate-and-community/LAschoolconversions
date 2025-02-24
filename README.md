# Analysis and data visuals for LA school conversions project

### "Teacher rent burden"

`starting-salaries-rent-burden.R` pulls median gross rents for LA city (Census designated place) from ACS 5-Year Estimates for 2018-2023 (B25064_001) and compares them to LA Unified School District starting teacher salaries.

#### Salary data

We used salary tables from the [LAUSD Human Resources Division](https://www.lausd.org/page/4045) website. We used the L tables for teachers with Alternative Certification Salaries. Due to nationwide teacher shortages, most districts aren't able to recruit fully certified teachers any more, so they recruit "preparation" teachers with alternative credentials who take additional classes at night to get their full credentials while working full time. We took the lowest salary from L tables for school years starting 2018-2023 and manually compiled those in a [Google Sheet](https://docs.google.com/spreadsheets/d/11G4uKbqWofdGmR5c6yxZmzIrXMTDFqQPIu55Biwerj8/edit?usp=sharing) and downloaded as a CSV: `salary data - l-tables.csv`. We compared the beginning of the school year to rents for the same year, e.g. starting salaries in July-December 2023 of the 2023-2024 school year were compared to median gross rents in 2023.

### "Developable" school-owned land

For their report [Education Workforce Housing in California: Developing the 21st Century Campus](https://live-citiesplusschools.pantheon.berkeley.edu/wp-content/uploads/Report-Education-Workforce-Housing-in-CaliforniaCCS-cityLAB-Terner-Center2022-1.pdf), Center for Cities + Schools, cityLAB, and Terner Center for Housing Innovation assessed the extent of land owned by Local Education Agencies (LEAs) in California that could potentially be used to develop workforce housing. Details of their methodology are available in the appendix of their report. They found that in Los Angeles County, there are 8,123 potentially developable acres of land owned by LEAs and 99% of those are in areas where the median asking rent is unaffordable to teachers at the lowest scheduled salary.

We used QGIS to create a reference map for LA County and LAUSD and styled it in Adobe Illustrator. Those files are in the `/gis` folder.
