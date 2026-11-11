import db from './db.js';

const getAllProjects = async () => {
    const query = `
        SELECT
            p.project_id,
            p.title,
            p.description,
            p.location,
            p.project_date,
            TO_CHAR(p.project_date, 'Mon DD, YYYY') AS formatted_date,
            o.organization_id,
            o.name AS organization_name
        FROM project p
        JOIN organization o ON p.organization_id = o.organization_id
        ORDER BY p.project_date;
    `;
    const result = await db.query(query);
    return result.rows;
};

export { getAllProjects };