SELECT * FROM hr_project.hiring_clean_final;
USE hr_project;

-- Recruitment Funnel Analysis

-- 1. Candidate count by status
SELECT status, COUNT(*) AS total_candidates
FROM hiring_clean_final
GROUP BY status;

-- 2. Candidates by source
SELECT source, COUNT(*) AS total_candidates
FROM hiring_clean_final
GROUP BY source
ORDER BY total_candidates DESC;

-- 3. Candidates by experience level
SELECT experience_level, COUNT(*) AS total_candidates
FROM hiring_clean_final
GROUP BY experience_level;

-- 4. Avg time from application to interview
SELECT 
AVG(DATEDIFF(
    STR_TO_DATE(interview_date, '%Y-%m-%d'),
    STR_TO_DATE(application_date, '%Y-%m-%d')
)) AS avg_interview_time_days
FROM hiring_clean_final
WHERE interview_date IS NOT NULL
AND application_date IS NOT NULL;

-- 5. Avg time from interview to offer
SELECT 
AVG(DATEDIFF(
    STR_TO_DATE(offer_date, '%Y-%m-%d'),
    STR_TO_DATE(interview_date, '%Y-%m-%d')
)) AS avg_offer_time_days
FROM hiring_clean_final
WHERE offer_date IS NOT NULL
AND interview_date IS NOT NULL;

-- 6. Monthly application trend
SELECT 
DATE_FORMAT(STR_TO_DATE(application_date, '%Y-%m-%d'), '%Y-%m') AS month,
COUNT(*) AS total_applications
FROM hiring_clean_final
WHERE application_date IS NOT NULL
GROUP BY month
ORDER BY month;

-- 7. Candidate status distribution by source
SELECT 
source,
status,
COUNT(*) AS candidate_count
FROM hiring_clean_final
GROUP BY source, status
ORDER BY source, candidate_count DESC;