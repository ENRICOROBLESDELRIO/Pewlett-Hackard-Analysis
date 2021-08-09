-- Use Dictinct with Orderby to remove duplicate rows
SELECT e.emp_no, e.first_name, e.last_name, 
ti.title, ti.from_date, ti.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no, ti.to_date DESC;

-- Unique Titles 
SELECT DISTINCT ON (ret.emp_no) ret.emp_no, ret.first_name, ret.last_name, ret.title
INTO unique_titles
FROM retirement_titles as ret
ORDER BY ret.emp_no, ret.to_date DESC;

-- Employee Count / Title / Retirement 
SELECT COUNT(ut.title), ut.title
INTO retirement_titles_count
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.title) DESC;

-- Query to create a Mentorship Eligibility table that holds the employees who are eligible
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, ti.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	   AND (de.to_date = '9999-01-01')
ORDER BY (e.emp_no), e.emp_no DESC;	   

-- Mentorship program by title 
SELECT COUNT(me.title), me.title
FROM mentorship_eligibility as me
GROUP BY me.title
ORDER BY COUNT(me.title) DESC;


























