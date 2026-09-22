-- ============================================================
-- CSE 340: setup.sql
-- Recreates the full database schema and sample data for the
-- Organizations / Service Projects / Categories application.
-- Run this entire file in the pgAdmin Query Tool to rebuild
-- the database from scratch.
-- ============================================================

-- Drop tables if they already exist (in reverse dependency order)
DROP TABLE IF EXISTS project_category;
DROP TABLE IF EXISTS project;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS organization;

-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Project Table
-- Each project belongs to exactly one organization (1:N)
-- ========================================
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(150) NOT NULL,
    project_date DATE NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES organization (organization_id)
);

-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- ========================================
-- Project_Category Junction Table
-- Resolves the many-to-many relationship between
-- projects and categories
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    PRIMARY KEY (project_id, category_id),
    FOREIGN KEY (project_id) REFERENCES project (project_id),
    FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- Insert sample data: Categories
-- ========================================
INSERT INTO category (name)
VALUES
('Construction & Infrastructure'),
('Food & Sustainability'),
('Community Outreach');

-- ========================================
-- Insert sample data: Projects
-- (5 projects for each of the 3 organizations)
-- ========================================

-- BrightFuture Builders projects (organization_id = 1)
INSERT INTO project (organization_id, title, description, location, project_date)
VALUES
(1, 'Community Playground Build', 'Construct a new playground for the Eastside neighborhood park.', 'Eastside Park', '2026-03-14'),
(1, 'Senior Center Roof Repair', 'Repair and reinforce the roof of the downtown senior center.', 'Downtown Senior Center', '2026-04-02'),
(1, 'Accessible Ramp Installation', 'Install wheelchair-accessible ramps at three community buildings.', 'Various Community Buildings', '2026-04-20'),
(1, 'Food Bank Warehouse Renovation', 'Renovate storage space to expand food bank capacity.', 'Riverside Food Bank', '2026-05-10'),
(1, 'Neighborhood Sidewalk Repair', 'Repair cracked and unsafe sidewalks in a low-income neighborhood.', 'Maple Street District', '2026-06-01');

-- GreenHarvest Growers projects (organization_id = 2)
INSERT INTO project (organization_id, title, description, location, project_date)
VALUES
(2, 'Community Garden Expansion', 'Expand the community garden with 20 new raised beds.', 'Willow Community Garden', '2026-03-22'),
(2, 'Urban Farming Workshop Series', 'Host a series of workshops teaching urban farming basics.', 'GreenHarvest Learning Center', '2026-04-05'),
(2, 'School Garden Program', 'Build and maintain a teaching garden at a local elementary school.', 'Lincoln Elementary School', '2026-04-18'),
(2, 'Composting Initiative', 'Set up neighborhood composting stations to reduce food waste.', 'Multiple Neighborhood Sites', '2026-05-02'),
(2, 'Farmers Market Support', 'Provide volunteer support and produce donations to the local farmers market.', 'Downtown Farmers Market', '2026-05-16');

-- UnityServe Volunteers projects (organization_id = 3)
INSERT INTO project (organization_id, title, description, location, project_date)
VALUES
(3, 'Winter Coat Drive', 'Collect and distribute winter coats to families in need.', 'UnityServe Distribution Center', '2026-01-15'),
(3, 'Homeless Shelter Meal Program', 'Prepare and serve meals at the local homeless shelter.', 'Hope Street Shelter', '2026-02-10'),
(3, 'Volunteer Tutoring Program', 'Coordinate volunteer tutors for at-risk youth.', 'Community Learning Center', '2026-03-05'),
(3, 'Park Cleanup Day', 'Organize a community-wide park and trail cleanup event.', 'Cedar Ridge Park', '2026-04-25'),
(3, 'Holiday Toy Drive', 'Collect and distribute toys to families during the holiday season.', 'UnityServe Distribution Center', '2026-11-20');

-- ========================================
-- Insert sample data: Project_Category associations
-- ========================================
INSERT INTO project_category (project_id, category_id)
VALUES
-- BrightFuture Builders projects -> Construction & Infrastructure (1)
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1),
-- Food Bank Warehouse Renovation also relates to Community Outreach
(4, 3),

-- GreenHarvest Growers projects -> Food & Sustainability (2)
(6, 2), (7, 2), (8, 2), (9, 2), (10, 2),
-- School Garden Program also relates to Community Outreach
(8, 3),

-- UnityServe Volunteers projects -> Community Outreach (3)
(11, 3), (12, 3), (13, 3), (14, 3), (15, 3);