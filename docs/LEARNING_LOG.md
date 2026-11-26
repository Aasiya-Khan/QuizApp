# Learning Log

## S1-01 · Create Maven project (25 Nov)
- **Did:** created a Maven project with pom.xml, src folders and Main.java.
- **Why:** Maven gives a standard folder layout and manages libraries via pom.xml.
- **Learned:** package name must match the folder path; target/ holds compiled .class files and is not committed.

## S1-02 · Database schema (26 Nov)
- **Did:** wrote sql/schema.sql with quizzes, questions, students, attempts.
- **Why:** one file rebuilds the same database anywhere.
- **Learned:**
  - Why drop questions before quizzes? questions point to quizzes through the FK. MySQL won't delete a parent while children still point to it, so children go first.
  - What happens if quiz 1 is deleted? Its questions are deleted automatically, because of ON DELETE CASCADE on the foreign key.
  - What does MySQL do with 'E'? It refuses the insert with an error, because of the CHECK (correct_option IN ('A','B','C','D')) rule.

## S1-03 · Seed data (26 Nov)
- **Did:** wrote sql/seed.sql with 3 students, 3 quizzes and their questions.
- **Why:** "seed" = starter data to test with. In the core version this file is the teacher's "create test" screen. Layer: database (teacher admin).
- **Notes:** times use NOW() so they're always relative to today, which gives three test cases:
  - quiz 1 open (all week, so I can test any evening)
  - quiz 2 opens tomorrow
  - quiz 3 already closed
- **Learned:** _(your words)_

## S1-04 · Results query (26 Nov)
- **Did:** wrote sql/results.sql, which JOINs attempts with students and quizzes.
- **Why:** in the core version this file is the teacher's results screen (FR-02). attempts only stores IDs; a JOIN looks up the matching name and title, like matching locker numbers across notebooks.
- **Notes:**
  - `attempts a`: a is an alias, so I can write a.score instead of attempts.score.
  - `JOIN students s ON s.student_id = a.student_id`: for each attempt, find the student with the matching ID and put their columns on the same row. The second JOIN does the same for the quiz title.
  - `ORDER BY q.title, a.score DESC`: group by test, highest score first (DESC = descending).
- **Learned:**
  - In Duplicate entry '1-S101', 1 is quiz_id and S101 is student_id. MySQL shows the pair that already exists: student S101 has already attempted quiz 1.
  - Without the JOIN, the teacher sees only IDs, like S102 | 1 | 3 | 3, instead of "Sara | Java Basics | 3/3". The JOIN looks up the name and title using those IDs.

## S1-05 · Dependencies: MySQL driver + JUnit (26 Nov)
- **Did:** added mysql-connector-j and junit-jupiter to pom.xml.
- **Why:** Java can't talk to MySQL alone; it needs a driver (a translator library), MySQL Connector/J. JUnit is the testing library for Sprint 2's rule tests. Layer: none yet, toolbox setup.
- **Notes:** a dependency is a library the project depends on; I list it in the pom and Maven downloads it.
- **Learned:** _(your words: what a dependency is, and why JUnit has test scope)_

## S1-06 · DBConnection + db.properties (26 Nov)
- **Did:** created db.properties (git-ignored) and util/DBConnection; Main prints "Connected! Quizzes in database: 3".
- **Why:** db.properties is the address card for the storeroom (where it is, which door, and the key). DBConnection is the storeroom key: every DAO (clerk) asks it for a connection before running SQL. Layer: util (shared by all DAOs). Host and port are separate on purpose: in Sprint 3 the student's Server IP box just replaces db.host.
- **Notes:**
  - `Properties` is Java's built-in reader for key=value files.
  - `getResourceAsStream("/db.properties")` opens the file from resources; it returns null if missing, so we throw a clear error instead of a confusing one later.
  - `try ( … )` = try-with-resources: Java closes the file automatically, even if an error happens.
  - `RuntimeException` means "stop the app with this message".
  - The url is e.g. jdbc:mysql://localhost:3306/quizapp; `jdbc:mysql://` means "use the MySQL driver".
  - `DriverManager.getConnection(url, user, password)` asks the driver to open the door and returns a `Connection`, an open line to MySQL.
  - `static` means I can call DBConnection.getConnection() without creating an object.
  - `throws SQLException` means "this can fail (wrong password, MySQL off), and whoever calls me must handle it".
- **Learned:** _(your words: what db.properties is, why it's git-ignored, and what getConnection() returns)_

## Spike · LAN feasibility test (26 Nov)
- **Did:** served a file from my Mac over my phone hotspot (mobile data off); opened it on my phone.
- **Why:** prove devices can talk without internet before building LAN mode.
- **Learned:** LAN ≠ internet; same network required; Mac firewall blocked Python until allowed.

## Concept · How a LAN works without internet
- **LAN (Local Area Network):** devices in one place connected through one router
  (here: my phone's hotspot). **Internet** = connecting that LAN to the outside world.
- **Wi-Fi = radio.** Devices talk by radio to the router, like walkie-talkies; no internet needed for that.
- **IP address:** the router gives each device a number (via DHCP),
  e.g. Mac = 10.100.225.103. Like house numbers on a street.
- **Packets:** data is sent in small "envelopes" labelled *from IP → to IP : port*.
  The router delivers envelopes for devices in the room directly.
  Only envelopes for outside addresses need the internet.
- **Port:** a numbered "door" on a device for one program.
  8000 = Python test server, 3306 = MySQL. The IP picks the house, the port picks the door.
- **Firewall:** a guard on the Mac that can refuse incoming connections.
  It turned away the phone's requests to Python until I turned it off for the test.
- **Real-world examples:** Mini Militia over hotspot, Minecraft "Open to LAN",
  printing to a home Wi-Fi printer when the internet is down, shop billing systems.
- **For QuizApp:** student apps send SQL in packets to my Mac's IP on port 3306;
  MySQL answers back the same way, all inside the hotspot.
- **Viva one-liner:** "The hotspot acts as a router. Devices get local IP addresses and exchange packets directly. The internet is only needed for addresses outside the network, so MySQL on port 3306 is reachable offline."