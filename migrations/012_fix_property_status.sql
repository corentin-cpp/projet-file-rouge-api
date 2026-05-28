-- Migration 012: Fix invalid property status values
-- Maps 'published'/'draft' (invalid) to valid constraint values
UPDATE properties
SET status = 'available'
WHERE status NOT IN ('available', 'under_offer', 'sold', 'rented', 'withdrawn');
