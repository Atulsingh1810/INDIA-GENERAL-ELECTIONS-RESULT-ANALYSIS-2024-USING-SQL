
DROP TABLE IF EXISTS constituencywise_details;

CREATE TABLE constituencywise_details
(
    S_N INT,
	Candidate VARCHAR(100),
	Party     VARCHAR(100),
	EVM_Votes INT,
	Postal_Votes INT,
	Total_Votes INT,
	of_Votes FLOAT,
	Constituency_ID  VARCHAR(50)
);

SELECT * FROM constituencywise_details

DROP TABLE IF EXISTS constituencywise_results;
CREATE TABLE constituencywise_results
(
    S_No INT,
	Parliament_Constituency VARCHAR(100) Primary Key,
	Constituency_Name   VARCHAR(100),
	Winning_Candidate VARCHAR(150),
    Total_Votes INT,
	Margin      INT,
	Constituency_ID  VARCHAR(50),
	Party_ID    INT
);

SELECT * FROM constituencywise_results


DROP TABLE IF EXISTS partywise_results;
CREATE TABLE partywise_results
(
   Party VARCHAR(150),
   Won   INT,
   Party_ID INT Primary Key  
);

SELECT * FROM partywise_results


CREATE TABLE statewise_results
(
    Constituency VARCHAR(100),
    Const_No   INT,
	Parliament_Constituency VARCHAR(100) Primary Key,
	Leading_Candidate VARCHAR(150),
	Trailing_Candidate  VARCHAR(100)  NULL,
	Margin   INT,
	Status  VARCHAR(100),
	State_ID VARCHAR(100),
	State VARCHAR(100)
);

SELECT * FROM statewise_results

  CREATE TABLE states
  (
     STATE_ID VARCHAR(50) Primary Key,
	 State VARCHAR(50)
  )

SELECT * FROM states


--PROBLEM STATEMENT
--1. TOTAL SEATS


 SELECT 
 DISTINCT COUNT(Parliament_Constituency) as Total_Seats
 FROM constituencywise_results

	
--2. WHAT ARE THE TOTAL NUMBER OF SEATS AVAILABLE FOR ELECTION IN EACH STATE

     SELECT
	 s.state AS State_name,
	 COUNT(cr.parliament_constituency) AS Total_Seats
	 FROM
	 constituencywise_results cr
	 INNER JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
	 INNER JOIN states s ON sr.State_ID = s.State_ID
	 GROUP BY s.state
	 
--3. TOTAL SEATS WON BY NDA ALLIANCE

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
                'Janata Dal (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
                'Janata Dal (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN Won
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_results

--4. SEATS WON BY NDA ALLIANCE PARTIES
    
	SELECT 
    party as Party_Name,
    won as Seats_Won
    FROM 
    partywise_results
    WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC

        
--5. TOTAL SEATS WON BY I.N.D.I.A. ALLIANCE

       
          
		  
		  SELECT 
           SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN Won
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
        FROM 
        partywise_results

--6. SEATS WON BY I.N.D.I.A. ALLIANCE PARTIES

SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_results
WHERE 
    party IN (
        'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
    )
ORDER BY Seats_Won DESC



--7. ADD NEW COLUMN FIELD IN TABLE PARTYWISE_RESULT TO GET THE PARTY ALLIANCE AS NDA, I.N.D.I.A. AND  OTHERS

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);


--I.N.D.I.A Allianz

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

--NDA Allianz

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

--OTHER

UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;


--8. WHICH PARTY ALLIANCE(NDA, I.N.D.I.A., OR OTHER) WON THE MOST SEATS ACROSS ALL STATES?


SELECT 
 party_alliance,
 SUM(won)
 FROM partywise_results
 GROUP BY party_alliance

-- 9. WINNING CANDIDATE'S NAME, THIER PARTY NAME, TOTAL VOTES, AND THE MARGIN OF VICTORY FOR A SPECIFIC STATE AND
--     CONSTITUENCY?

           SELECT 
		   cr.Winning_Candidate,
		   pr.party,
		   pr.party_alliance,
		   cr.total_votes,
		   cr.margin,
		   s.state,
		   cr.Constituency_Name
		   FROM
		   constituencywise_results cr INNER JOIN partywise_results pr ON cr.party_id = pr.party_id
		   INNER JOIN  statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
		   INNER JOIN states s ON sr.state_id = s.state_id
		   WHERE cr.Constituency_Name = 'BARAMATI'


-- 10. WHAT IS THE DISTRIBUTION OF EVM VOTES VERSUS POSTAL VOTES FOR CANDIDATES IN A SPECIFIC CONSTITUENCY?


		  SELECT
		  cd.EVM_Votes,
		  cd.Postal_Votes,
		  cd.Total_Votes,
		  cd.Candidate,
		  cr.Constituency_Name
		  FROM constituencywise_results cr JOIN constituencywise_details cd
		  ON cr.Constituency_ID = cd.Constituency_ID
		  WHERE cr.Constituency_Name = 'ALLAHABAD'
		  
		  
-- 11. WHICH PARTIES WON THE MOST SEATS IN S STATE, AND HOW MANY SEATS DID EACH PARTY WIN?

SELECT 
      s.state,
	  pr.Party_alliance
FROM 
    constituencywise_results cr
JOIN 
    partywise_results pr ON cr.Party_ID = pr.Party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s ON sr.State_ID = s.State_ID
WHERE 
    s.state = 'Uttar Pradesh'


-- 12. WHAT IS THE TOTAL NUMBER OF SEATS WON BY EACH PARTY ALLIANCE (NDA, I.N.D.I.A, AND OTHER) IN EACH STATE FOR THE INDIA ELECTIONS 2024 ?

SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
    s.State
ORDER BY 
    s.State;


-- 13. WHICH CANDIDATE RECEIVED THE HIGHEST NUMBER OF EVM VOTES IN EACH CONSTITUENCY (TOP 10)?

SELECT 
    cr.Constituency_Name,
    cd.Constituency_ID,
    cd.Candidate,
    cd.EVM_Votes
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE 
    cd.EVM_Votes = (
        SELECT MAX(cd1.EVM_Votes)
        FROM constituencywise_details cd1
        WHERE cd1.Constituency_ID = cd.Constituency_ID
    )
ORDER BY 
    cd.EVM_Votes DESC
LIMIT 10;

-- 14. WHICH CANDIDATE WON AND WHICH CANDIDATE WAS THE RUNNER-UP IN EACH CONSTITUENCY OF STATE FOR THE 2024 ELECTIONS?

 WITH RankedCandidates AS (
 SELECT 
        cd.Constituency_ID,
        cd.Candidate,
        cd.Party,
        cd.EVM_Votes,
        cd.Postal_Votes,
        cd.EVM_Votes + cd.Postal_Votes AS Total_Votes,
        ROW_NUMBER() OVER (PARTITION BY cd.Constituency_ID ORDER BY cd.EVM_Votes + cd.Postal_Votes DESC) AS VoteRank
    FROM 
        constituencywise_details cd
    JOIN 
        constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN 
        statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN 
        states s ON sr.State_ID = s.State_ID
    WHERE 
        s.State = 'Maharashtra'
)

SELECT 
    cr.Constituency_Name,
    MAX(CASE WHEN rc.VoteRank = 1 THEN rc.Candidate END) AS Winning_Candidate,
    MAX(CASE WHEN rc.VoteRank = 2 THEN rc.Candidate END) AS Runnerup_Candidate
FROM 
    RankedCandidates rc
JOIN 
    constituencywise_results cr ON rc.Constituency_ID = cr.Constituency_ID
GROUP BY 
    cr.Constituency_Name
ORDER BY 
    cr.Constituency_Name;


-- 15. FOR THE STATE OF MAHARASHTRA, WHAT ARE THE TOTAL NUMBER OF SEATS, TOTAL NUMBER OF CANDIDATES, TOTAL NUMBER OF PARTIES, TOTAL VOTES (INCLUDING EVM AND POSTAL), AND THE BREAKDOWN OF EVM AND POSTAL VOTES?


SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT pr.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
JOIN 
    partywise_results pr ON cr.Party_ID = pr.Party_ID
WHERE 
    s.State = 'Maharashtra';


