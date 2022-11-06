SELECT travels.Branch.id, travels.Branch.branch_name
FROM
    travels.Branch,
    travels.Trip
WHERE travels.Trip.branch_id = travels.Branch.id
    AND travels.Trip.startdate - travels.Trip.cancelationdate <= INTERVAL '3 days'
GROUP BY travels.Trip.branch_id
ORDER BY COUNT(*)
LIMIT 3;
