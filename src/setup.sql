-- Reset: drop in dependency order so re-running is always safe
DROP TABLE IF EXISTS project_category CASCADE;
DROP TABLE IF EXISTS project CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS organization CASCADE;

-- Organizations
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

INSERT INTO organization (name, description, contact_email, logo_filename) VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- Projects
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    project_date DATE NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES organization(organization_id) ON DELETE CASCADE
);

INSERT INTO project (organization_id, title, description, location, project_date) VALUES
(1, 'Park Cleanup Day', 'Volunteers pick up litter and plant flowers.', 'Riverside Park', '2026-12-05'),
(1, 'Neighborhood Food Drive', 'Collect and sort canned goods for local families.', 'Community Center', '2026-12-12'),
(1, 'Winter Coat Giveaway', 'Distribute donated coats to those in need.', 'First Street Church', '2026-12-19'),
(1, 'Senior Center Visit', 'Spend an afternoon playing games with residents.', 'Maple Senior Living', '2027-01-09'),
(1, 'Community Garden Build', 'Build raised beds for a shared garden.', 'Elm Street Lot', '2027-01-23'),
(2, 'Homework Help Night', 'Tutor local students in math and reading.', 'Public Library', '2026-12-08'),
(2, 'Book Donation Drive', 'Collect books for the school library.', 'Lincoln Elementary', '2026-12-15'),
(2, 'Career Day Mentoring', 'Share career advice with high school students.', 'Central High School', '2027-01-14'),
(2, 'Coding Workshop', 'Teach beginner coding to teens.', 'Tech Hub', '2027-01-28'),
(2, 'Scholarship Fundraiser', 'Raise funds for local scholarships.', 'Town Hall', '2027-02-06'),
(3, 'Shelter Meal Service', 'Prepare and serve dinner at the shelter.', 'Hope Shelter', '2026-12-10'),
(3, 'Pet Adoption Event', 'Help showcase animals ready for adoption.', 'Main Street Plaza', '2026-12-20'),
(3, 'Beach Cleanup', 'Remove trash and debris from the shoreline.', 'Sunset Beach', '2027-01-16'),
(3, 'Blood Drive', 'Assist donors and staff during check-in.', 'City Hospital', '2027-02-01'),
(3, 'Home Repair Saturday', 'Make small repairs for elderly homeowners.', 'Various Locations', '2027-02-13');

-- Categories
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO category (name) VALUES
('Environmental'),
('Education'),
('Community Support'),
('Health');

-- Project <-> Category link table
CREATE TABLE project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    FOREIGN KEY (project_id) REFERENCES project(project_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

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
JOIN category c ON c.name = v.category_name;

