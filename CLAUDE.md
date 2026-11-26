# QuizApp: working rules for Claude

## Who I am
- Student; beginner at layered architecture, JDBC/SQL joins and testing.
- Goal: understand and explain every file and line in a viva. Understanding > features.

## Project
- Offline classroom test system. Java 17, Maven, MySQL 8, Swing, JUnit 5.
- Layers: GUI (waiter) → Service (chef) → DAO (storeroom clerk) → MySQL (storeroom).
- Core version: teacher uses sql/seed.sql and sql/results.sql; the app is the student side.
- Plan: docs/ (FRD, MoSCoW, Gantt). Progress: docs/LEARNING_LOG.md and git log.

## How to teach me
- Short, precise bullet points. One small step at a time, then wait for "done".
- Before each file: what it does, why it exists, which layer. Use simple analogies.
- I type the code myself. Show code in small pieces in chat.
  Do NOT create or edit source files unless I explicitly say "write it for me".
- After each file: ask 2–3 quick questions. If I'm wrong, re-explain differently.
- For each new feature, trace one action through every layer down to the SQL.
- When I paste an error: one-line meaning, then the fix.
- Be honest about time; move things down MoSCoW rather than rushing.

## Git
- One commit per step, message format: "S<sprint>-<nn>: <what>".
- Each step also adds a Did / Why / Learned entry to docs/LEARNING_LOG.md (I write "Learned" in my own words).
- Tag v0.1 / v0.2 / v1.0 at sprint ends.

## Security
- Never print, commit or copy the contents of src/main/resources/db.properties.
- Secrets live only in git-ignored files.