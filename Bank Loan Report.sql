select * from bank_loan_data

-- Total Loan Application

select count(id) as total_loan_application from bank_loan_data

select count(id) as MTD_total_loan_application from bank_loan_data
where MONTH(issue_date) = 12 and year(issue_date) = 2021

select count(id) as PMTD_total_loan_application from bank_loan_data
where MONTH(issue_date) = 11 and year(issue_date) = 2021

-- to calculate MOM(%inc. or %dec. in application no.)  we have to make a calculation of - (MTD-PMTD/PMTD)

-- Total Funded Amount

select sum(loan_amount) as total_loan_amount from bank_loan_data

select sum(loan_amount) as MTD_total_loan_amount from bank_loan_data
where month(issue_date)  = 12 and year(issue_date) = 2021

select sum(loan_amount) as PMTD_total_loan_amount from bank_loan_data
where month(issue_date)  = 11 and year(issue_date) = 2021

-- Total Amount Recieved

select sum(total_payment) as total_amount_recieved from bank_loan_data

select sum(total_payment) as MTD_total_amount_recieved from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select sum(total_payment) as PMTD_total_amount_recieved from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

-- Average Interest Rate

select round(avg(int_rate),4)*100 as average_interage_rate from bank_loan_data

select round(avg(int_rate),4)*100 as MTD_average_interage_rate from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select round(avg(int_rate),4)*100 as PMTD_average_interage_rate from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021

-- Average Date to Income Ration(DTI)

select round(avg(dti)* 100,2) as Avg_DTI from bank_loan_data

select round(avg(dti)* 100,2) as MTD_Avg_DTI from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021

select round(avg(dti)* 100,2) as PMTD_Avg_DTI from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021 

-- Good Loan And Bad Loan KPI's
-- Good Loan
-- Good Loan Application Percentage

select
	(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
			/
			count(id) as Good_Loan_Percentage
from bank_loan_data

-- Good Loan Applications

select count(Id) as Good_Loan_Application from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current' 

-- Good Loan Funded Amount 

select sum(loan_amount) as Good_Loan_Funded_Amount from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Good Loan Amount Recieved 

select sum(total_payment) as Good_Loan_Amount_Recieved from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'

-- Bad Loan
-- Bad Loan Percentage

select (count(case when loan_status = 'Charged Off' then id end)*100.0)/
		count(id) as Bad_Loan_Percentage
		from bank_loan_data

-- Bad Loan Application

select count(id) as Bad_Loan_Application from bank_loan_data
where loan_status = 'Charged Off'

-- Bad Loan Funded Amount

select sum(loan_amount) as Bad_Loan_Funded_Amount from bank_loan_data
WHERE loan_status = 'Charged Off'

-- Bad Loan Amount Recieved

select sum(total_payment) as Bad_Loan_Amount_Recieved from bank_loan_data
where loan_status = 'Charged Off'


-- Loan Status

select 
		loan_status,
		count(id) as total_loan_applications,
		sum(total_payment) as total_loan_amount_receieved,
		sum(loan_amount) as total_loan_amount_funded,
		avg(int_rate*100) as interest_rate,
		avg(dti*100) as DTI
		from bank_loan_data
		group by loan_status

select loan_status,
	sum(total_payment) as MTD_Total_Amount_Recieved,
	sum(loan_amount) as MTD_Loan_Amount_Given
from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021
group by loan_status


-- Bank loan Report
-- Month

SELECT 
	MONTH(issue_date) AS Month_Number, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


-- State

select address_state as States,
		count(id) as Total_Loan_Applications,
		sum(loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by address_state
order by count(id) desc


--Term

SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY term
ORDER BY count(id) desc


-- Employee Length

select emp_length,
		count(id) as Total_Loan_Applications,
		sum(loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by emp_length
order by count(id) desc


--Purpose

select purpose,
		count(id) as Total_Loan_Applications,
		sum(loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by purpose
order by count(id) desc


-- Home Ownership

select home_ownership,
		count(id) as Total_Loan_Applications,
		sum(loan_amount) as Total_Funded_Amount,
		sum(total_payment) as Total_Amount_Recieved
from bank_loan_data
group by home_ownership
order by count(id) desc

