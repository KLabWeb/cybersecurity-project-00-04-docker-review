# Cybersecurity Portfolio

Everything I'm producing from my [application security study plan](https://github.com/KLabWeb/cybersecurity-study-plan) (sans notes) — from the FastAPI refresher app, to exploitation logs, to lab write-ups, to custom Semgrep rules, to a full security assessment and threat model — as I transition from full-stack web development into application security (AppSec) engineering.

AppSec portfolios are built differently from software-engineering ones. What carries weight is documented offensive work: vulnerability write-ups, lab solutions, and threat models that show I can find a flaw, understand why it exists, exploit it, and explain the fix. Work here is organized by study-plan phase and grows as I move through it.

## Completed

- Phase 0 — [**Docker Review — Containerized Uvicorn + FastAPI**](https://github.com/KLabWeb/cybersecurity-portfolio/tree/master/Phase%2000/00-04%20Docker%20Review%20-%20Containerized%20Uvicorn%20%2B%20FastAPI) — review of docker via containerization of a Uvicorn served FastAPI app, end-to-end, with a hardened Dockerfile (non-root user, minimal image), Docker Compose, and image/volume/network management across the full container lifecycle

## In Progress


## Planned

**Phase 0 — Foundations**
- FastAPI refresher app — a small app built from the official docs, reused as the local lab throughout the plan

**Phase I — AppSec Intro**
- First offensive lab environment and initial WebGoat exploitation

**Phase II — Web & Network Foundations**
- Authentication audit checklist, written from scratch
- Published write-up — a LinkedIn article on JWT vulnerabilities

**Phase III — Core Vulnerability Classes**
- PortSwigger labs across the core classes — injection, XSS, CSRF / SSRF / XXE, access control & business logic, deserialization / file upload / path traversal, API security, and web LLM attacks
- OWASP Top 10 write-up series — an exploitation log per class (what the vulnerability was, how I exploited it, how to fix it)

**Phase IV — Security Testing & Tooling**
- BSCP preparation labs and exam-ready proof-of-concept exploit logs *(culminates in the Burp Suite Certified Practitioner exam)*
- Custom SAST rules (Semgrep / Bandit)
- Tooling practice — secrets scanning, DAST (OWASP ZAP), dependency scanning (Snyk), out-of-band exploitation
- Full security assessment of OWASP Juice Shop
- A secured LLM-backed API

**Phase V — Cloud Security (AWS)**
- flaws.cloud and flaws2.cloud lab write-ups (attacker and defender paths)

**Phase VI — Secure Code Review & Threat Modeling**
- Documented security review of a real open-source Python application (scope, methodology, findings)
- A STRIDE threat model for a realistic system

## Related

- [Study Plan](https://github.com/KLabWeb/cybersecurity-study-plan) — the full curriculum
- [Study Notes](https://github.com/KLabWeb/cybersecurity-notes) — what I'm learning as I work through it
- [Study Tracker](https://github.com/KLabWeb/cybersecurity-study-tracker) — what I'm doing, for how long, and when
