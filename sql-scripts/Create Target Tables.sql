-- A: Create the target table

CREATE TABLE biography (
	[athlete_id] int,
	[name] nvarchar(4000),
	[sex] nvarchar(4000),
	[born] nvarchar(4000),
	[country] nvarchar(4000),
	[noc] nvarchar(4000)
	)
WITH
(
    DISTRIBUTION = HASH([athlete_id]),
    CLUSTERED COLUMNSTORE INDEX
    --HEAP
)
GO

CREATE TABLE eventDetails (
	[edition] nvarchar(4000),
	[editionYear] nvarchar(4000),
	[edition_id] smallint,
	[noc] nvarchar(4000),
	[sport] nvarchar(4000),
	[event] nvarchar(4000),
	[gender] nvarchar(4000),
	[result_id] int,
	[athlete] nvarchar(4000),
	[athlete_id] int,
	[pos] nvarchar(4000),
	[medal] nvarchar(4000),
	[isTeamSport] bit
	) 
WITH
(
    DISTRIBUTION = HASH([athlete_id]),
    CLUSTERED COLUMNSTORE INDEX
    --HEAP
)
GO

CREATE TABLE countryProfiles (
	[noc] nvarchar(4000),
	[country] nvarchar(4000)
	)
WITH
(
    DISTRIBUTION = HASH(noc),
	CLUSTERED COLUMNSTORE INDEX
    --HEAP
)
GO

CREATE TABLE gamesSummary (
	[edition] nvarchar(4000),
	[edition_id] nvarchar(4000),
	[edition_url] nvarchar(4000),
	[editionYear] nvarchar(4000),
	[city] nvarchar(4000),
	[country_flag_url] nvarchar(4000),
	[noc] nvarchar(4000),
	[start_date] nvarchar(4000),
	[end_date] nvarchar(4000),
	[isHeld] nvarchar(4000)
	)
WITH
(
    DISTRIBUTION = HASH([edition_id]),
    CLUSTERED COLUMNSTORE INDEX
    --HEAP
)
GO

CREATE TABLE medalTallyHistory (
	[edition] nvarchar(4000),
	[edition_id] smallint,
	[editionYear] smallint,
	[country] nvarchar(4000),
	[noc] nvarchar(4000),
	[gold] smallint,
	[silver] smallint,
	[bronze] smallint,
	[total] smallint
	)
WITH
(
    DISTRIBUTION = HASH([edition_id]),
    CLUSTERED COLUMNSTORE INDEX
    --HEAP
)
GO