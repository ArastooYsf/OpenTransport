# Security Policy

OpenTransport is an offline-first, bundled-data mobile app. It does not
currently handle accounts, payments, or personal user data, which keeps the
realistic attack surface small — but we still take reports seriously,
especially anything involving:

- A malicious or malformed transit data file that could crash the app or
  execute unexpected code when parsed.
- Supply-chain issues in a dependency (`pubspec.lock`).
- Anything in a future networking/sync layer (`data/remote/`) that could leak
  data or allow a man-in-the-middle to inject fake transit data.

## Reporting a Vulnerability

Please **do not** open a public GitHub issue for security reports.

Instead, use GitHub's private reporting for this repository:
**Security tab → "Report a vulnerability"**
(or directly: `https://github.com/ArastooYsf/OpenTransport/security/advisories/new`).

Include:

- A description of the issue and its potential impact.
- Steps to reproduce, or a minimal example (a crafted `.json` data file, if
  relevant).
- The app version / commit hash you tested against.

We aim to acknowledge reports within a few days. Since this is a
volunteer-run open-source project, please be patient with response times —
and thank you for helping keep it safe for the people who rely on it to get
around.

## Supported Versions

This project is pre-1.0 and does not yet have a formal support/backport
policy. Security fixes land on the `main` branch; please always test against
the latest commit before reporting.
