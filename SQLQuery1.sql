SELECT * FROM [bank loan database]

SELECT COUNT(id) AS Total_Loan_Applications FROM [bank loan database]

SELECT COUNT(id) AS PMTD_Total_Loan_Applications FROM [bank loan database]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- (MTD-PMTD)/PMTD
--mencari total funded amount (dana yg digunakan untuk pinjaman)
SELECT SUM(loan_amount) AS PMTD_Total_Funded_Amount FROM [bank loan database]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- mencari total fund yg dibayar
SELECT SUM(total_payment) AS PMTD_Total_Amount_Received FROM [bank loan database]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- menghitung rata2 suku bunga dan perbandingan dengan periode sebelumnya
SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_Rate FROM [bank loan database]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- menghitung rasio hutang terhadap  pendapatan
SELECT ROUND(AVG(dti), 4) * 100 AS PMTD_Avg_DTI FROM [bank loan database]
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- good loan vs bad loan
-- melihat persentase orang yg good loan
SELECT loan_status FROM  [bank loan database]
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' Or loan_status = 'Current' THEN id END) * 100)
	/
	COUNT(id) AS Good_loan_percentage
FROM [bank loan database]

-- jumlah orang yg good loan
SELECT COUNT(id) AS Good_bank_loan FROM [bank loan database]
WHERE loan_status = 'Fully Paid' Or loan_status = 'Current'

-- total dana yang dipinjam oleh nasabah yg good loan
SELECT SUM(loan_amount) AS Good_loan_funded_amount FROM [bank loan database]
WHERE loan_status = 'Fully Paid' Or loan_status = 'Current'

-- total dana yang dibayarkan oleh peminjam
SELECT SUM(total_payment) AS Good_loan_received_amount FROM [bank loan database]
WHERE loan_status = 'Fully Paid' Or loan_status = 'Current'

-- bad loan
-- melihat persentase orang yg bad loan
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) /
	COUNT(id) AS Bad_loan_percentage
FROM [bank loan database]

-- jumlah orang yang bad loan
SELECT COUNT(id) AS Bad_bank_loan FROM [bank loan database]
WHERE loan_status = 'Charged Off'


-- total dana yang dipinjam oleh nasabah yg good loan
SELECT COUNT(id) AS bad_loan_applications FROM [bank loan database]
WHERE loan_status = 'Charged Off'


-- total dana yang dipinjam oleh nasabah yg good loan
SELECT SUM(loan_amount) AS Bad_loan_funded_amount FROM [bank loan database]
WHERE loan_status = 'Charged Off'

-- total dana yang dibayarkan oleh peminjam
SELECT SUM(total_payment) AS Bad_loan_received_amount FROM [bank loan database]
WHERE loan_status = 'Charged Off'

-- DASHBORD 2
SELECT 
      loan_status,
	  COUNT(id) AS Total_Loan_Application,
	  SUM(total_payment) AS Total_Amount_Received,
	  SUM(loan_amount) AS Total_Funded_Amount,
	  AVG(int_rate * 100) AS Interest_Rate,
	  AVG(dti * 100) AS DTI
   FROM
       [bank loan database]
   GROUP BY
       loan_status


SELECT 
      loan_status,
	  SUM(total_payment) AS MTD_Total_Amount_Received,
	  SUM(loan_amount) AS MTD_Total_Funded_Amount
   FROM
       [bank loan database]
   WHERE MONTH(issue_date) = 12
   GROUP BY
       loan_status


-- Monthly Trends by Issue Date(Line Chart):

SELECT
     MONTH(issue_date) AS Month_Number,
     DATENAME(MONTH, issue_date) AS Month_Name,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM  [bank loan database]
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date) 

-- Regional Analysis by State

SELECT
     address_state,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM  [bank loan database]
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC

-- Loan Term Analysis
SELECT
     term,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM  [bank loan database]
GROUP BY term
ORDER BY term 


-- Employee Length Analysis
SELECT
     emp_length,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM  [bank loan database]
GROUP BY emp_length
ORDER BY emp_length 

-- Loan Purpose Breakdown
SELECT
     purpose,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM  [bank loan database]
GROUP BY purpose
ORDER BY COUNT(id) desc

-- Home Ownership Analysis

SELECT
     home_ownership,
	 COUNT(id) AS Total_Loan_Applications,
	 SUM(loan_amount) AS Total_Funded_Amount,
	 SUM(total_payment) AS Total_Amount_Received
FROM  [bank loan database]
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY COUNT(id) desc


-- DASHBORD 3
