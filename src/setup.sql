INSERT INTO category (name) VALUES
('Environmental'),
('Education'),
('Community Support'),
('Health')
ON CONFLICT (name) DO NOTHING;

INSERT INTO project_category (project_id, category_id)
SELECT p.project_id, c.category_id
FROM (VALUES
    ('Park Cleanup Day', 'Environmental'),
    ('Neighborhood Food Drive', 'Community Support'),
    ('Winter Coat Giveaway', 'Community Support'),
    ('Senior Center Visit', 'Community Support'),
    ('Senior Center Visit', 'Health'),
    ('Community Garden Build', 'Environmental'),
    ('Community Garden Build', 'Community Support'),
    ('Homework Help Night', 'Education'),
    ('Book Donation Drive', 'Education'),
    ('Career Day Mentoring', 'Education'),
    ('Coding Workshop', 'Education'),
    ('Scholarship Fundraiser', 'Education'),
    ('Scholarship Fundraiser', 'Community Support'),
    ('Shelter Meal Service', 'Community Support'),
    ('Pet Adoption Event', 'Community Support'),
    ('Beach Cleanup', 'Environmental'),
    ('Blood Drive', 'Health'),
    ('Home Repair Saturday', 'Community Support')
) AS v(project_title, category_name)
JOIN project p ON p.title = v.project_title
JOIN category c ON c.name = v.category_name
ON CONFLICT DO NOTHING;

SELECT p.title, c.name
FROM project p
JOIN project_category pc ON p.project_id = pc.project_id
JOIN category c ON pc.category_id = c.category_id
ORDER BY p.title;