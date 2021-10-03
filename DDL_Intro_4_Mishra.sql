
CREATE TABLE Team 
(
teamNumber Integer NOT NULL, 
teamName VARCHAR(50) NOT NULL, 
CONSTRAINT PK_Team PRIMARY KEY(teamNumber)  
)

CREATE TABLE Cyclist 
(
cyclistNumber INTEGER NOT NULL,
familyname VARCHAR(50) NOT NULL,
givenName VARCHAR(50) NOT NULL,
teamNumber INTEGER NOT NULL, 
CONSTRAINT PK_Cyclist PRIMARY KEY(cyclistNumber),
CONSTRAINT FK_Team_Cyclist FOREIGN KEY (teamNumber) REFERENCES Team(teamNumber) 
)

INSERT INTO Team(teamNumber, teamName) VALUES 
(1, 'abc'), 
(2, 'bcd') 


INSERT INTO Cyclist(cyclistNumber, familyname, givenName, teamNumber) VALUES
(12, 'Mishra', 'Suraj', 2), 
(23, 'Solo', 'Mariia', 2), 
(34, 'Remes', 'Alpo', 1)

INSERT INTO Cyclist(cyclistNumber, familyname, givenName, teamNumber) VALUES
(42, 'Suraj', 'Smith', 2)  


SELECT teamName FROM Team ORDER BY  teamName

SELECT familyName, givenName FROM Cyclist

SELECT familyName, givenName, teamName
	FROM Team JOIN Cyclist On (Team.teamNumber = Cyclist.teamNumber) 




