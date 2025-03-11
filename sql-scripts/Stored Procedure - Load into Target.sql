CREATE PROCEDURE Load_Into_Target
AS
BEGIN
    -- Insert new records
    INSERT INTO biography
    SELECT athlete_id, name, sex, born, country, noc FROM stgbiography;

    INSERT INTO eventDetails
    SELECT edition, editionYear, edition_id, noc, sport, event, gender, result_id, athlete, athlete_id, pos, medal, isTeamSport FROM stgeventDetails;

    INSERT INTO countryProfiles
    SELECT noc, country FROM stgcountryProfiles;

    INSERT INTO gamesSummary
    SELECT edition, edition_id, edition_url, editionYear, city, country_flag_url, noc, start_date, end_date, isHeld FROM stggamesSummary;

    INSERT INTO medalTallyHistory 
    SELECT edition, edition_id, editionYear, country, noc, gold, silver, bronze, total FROM stgmedalTallyHistory;

    -- Delete processed data from staging
    TRUNCATE TABLE stgbiography;
    TRUNCATE TABLE stgeventDetails;
    TRUNCATE TABLE stgcountryProfiles;
    TRUNCATE TABLE stggamesSummary;
    TRUNCATE TABLE stgmedalTallyHistory;
END
