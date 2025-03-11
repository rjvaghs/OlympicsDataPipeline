source(output(
		athlete_id as integer,
		name as string,
		sex as string,
		born as string,
		height as short,
		weight as short,
		country as string,
		country_noc as string,
		description as string,
		special_notes as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> athleteBiography
source(output(
		edition as string,
		edition_id as short,
		country_noc as string,
		sport as string,
		event as string,
		result_id as integer,
		athlete as string,
		athlete_id as integer,
		pos as string,
		medal as string,
		isTeamSport as boolean
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> athleteEventDetails
source(output(
		noc as string,
		country as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> countryProfiles
source(output(
		edition as string,
		edition_id as string,
		edition_url as string,
		year as string,
		city as string,
		country_flag_url as string,
		country_noc as string,
		start_date as string,
		end_date as string,
		competition_date as string,
		isHeld as string
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> gamesSummary
source(output(
		edition as string,
		edition_id as short,
		year as short,
		country as string,
		country_noc as string,
		gold as short,
		silver as short,
		bronze as short,
		total as short
	),
	allowSchemaDrift: true,
	validateSchema: false,
	ignoreNoFilesFound: false) ~> medalTallyHistory
athleteBiography derive(born = regexExtract(born,`(\d\d\d\d)$`)) ~> bornColumnTransformation
athleteEventDetails derive(editionYear = regexExtract(edition, `^(\d\d\d\d)`),
		edition = regexExtract(edition, `(\w+\sOlympics)$`),
		gender = regexExtract(event, `\s(\w+)$`),
		event = regexExtract(event, `^(.*),\s\w+$`)) ~> splitEditionAndEventCol
splitEditionAndEventCol select(mapColumn(
		edition,
		editionYear,
		edition_id,
		noc = country_noc,
		sport,
		event,
		gender,
		result_id,
		athlete,
		athlete_id,
		pos,
		medal,
		isTeamSport
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> rearrangeLocationColumns
gamesSummary derive(edition = regexExtract(edition, `\s(\w+\sOlympics)$`)) ~> editionColumnTransformationGamesSummary
editionColumnTransformationGamesSummary select(mapColumn(
		edition,
		edition_id,
		edition_url,
		editionYear = year,
		city,
		country_flag_url,
		noc = country_noc,
		start_date,
		end_date,
		isHeld
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> renamingColumnsGamesSummary
medalTallyHistory derive(edition = regexExtract(edition, `\s(\w+\sOlympics)$`)) ~> editionColumnTransformationMedalTally
editionColumnTransformationMedalTally select(mapColumn(
		edition,
		edition_id,
		editionYear = year,
		country,
		noc = country_noc,
		gold,
		silver,
		bronze,
		total
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> renamingColumnsMedalTally
bornColumnTransformation select(mapColumn(
		athlete_id,
		name,
		sex,
		born,
		height,
		weight,
		country,
		noc = country_noc
	),
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> renameColum
renameColum, countryProfiles lookup(renameColum@noc == countryProfiles@noc,
	multiple: true,
	broadcast: 'auto')~> countryLookup
countryLookup sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true,
	mapColumn(
		athlete_id,
		name,
		sex,
		born,
		height,
		weight,
		country = countryProfiles@country,
		noc = renameColum@noc,
		noc = countryProfiles@noc,
		country = countryProfiles@country
	)) ~> athleteBiographySink
rearrangeLocationColumns sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> athleteEventDetailsSink
countryProfiles sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> countryProfilesSink
renamingColumnsGamesSummary sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> gamesSummarySink
renamingColumnsMedalTally sink(allowSchemaDrift: true,
	validateSchema: false,
	format: 'parquet',
	umask: 0022,
	preCommands: [],
	postCommands: [],
	skipDuplicateMapInputs: true,
	skipDuplicateMapOutputs: true) ~> medalTallyHistorySink