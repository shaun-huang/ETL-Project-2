ALTER TABLE "Victim"
	ADD COLUMN crash_id SERIAL
	REFERENCES "Crash" (id);