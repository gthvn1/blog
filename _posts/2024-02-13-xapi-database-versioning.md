---
title: "XAPI Database versioning"
categories:
  - Blog
tags:
  - xen
---

# XAPI Database versioning

---

# Agenda

1. General remarks
  1. Loading the DB
  1. Checking version and Data Model
  1. Upgrade of DB
1. How versioning works?
  1. New release
  1. Issue when adding *set_https_only*
  1. Removing a field
  1. Exceptions

---

# General remarks
## Loading the database

- When XAPI starts it first tries to load the database in memory from `/var/lib/xcp/state.db`.
  - Configured in `/etc/xensource/db.conf`
  - Master only
    - `ocaml/xapi/xapi.ml:start_database_engine`
  - It uses the schema provided by the data model to check the consistency of the DB.
    - `ocaml/xapi/xapi.ml:populate_db`
      - get the reference schema from `ocaml/idl/datamodel_schema.ml:of_datamodel`

---

# General remarks
## Checking datamodel

- If a field is missing in the schema, XAPI generates an error.
  - A removed field MUST exist in the model and marked as *REMOVED*.
```sh
xapi: [error||0 ||backtrace] Raised Db_exn.DBCache_NotFound("missing column", "host", "https_only")
```

---

# General remarks
## Upgrade of DB

- Once loaded in memory XAPI compares version of the loaded DB and its builtin version
  - If builtin version is greater = `upgrade`
  - If builtin version is equal = `nothing to do`
  - If builtin version is lower = `error` because downgrade is not allowed

- `upgrade` is done according to a set of rules related to fields that needs to be upgraded.
  - checks rules in `ocaml/xapi/xapi_db_upgrade.ml`

---

# Versioning

- Database versioning is done in `datamodel_common.ml`.
- It consists of a *major* (schema_major_vsn) and a *minor* (schema_minor_vsn) version serial number.
- Major is not used (it's a reminiscence of old times).
- When a field is modified (add/remove/change) you need to bump schema version.
  - bumps is not needed when adding functions, only when adding fields.

---

# Versioning
## New release
- When a new release is introduced the minor VSN is incremented to the next hundred.
  - This leave gap for potential hot fixes.
- As minor VSN is updated for new version, you also need to update *<release_name>_schema_minor_vsn* to keep track of the last release.

- If schema version is bumped you also need to update *last_known_schema_hash* that is used for testing (see in the *ocaml/idl/schematest.ml*).
  - To get the new hash you need to run make test and you will receive the correct hash in the error message.

---

# Versioning
## Issue when adding *set_https_only* feature

- We added *set_https_only* feature in our 8.2 release
- This feature introduce a new field *https_only* in the DB to keep track of it
- When upgrading to 8.3 that doesn't have this field:
  - XAPI loads the file `/var/lib/xcp/state.db`
  - Check that *https_only* is in the current schema
    - It doesn't exist => XAPI is broken
- To fix this, when introducing a new field we must also add it to all following releases

---

# Versioning
## Removing a field

- A field is removed by setting its `lifecycle` property to **Removed**
```ocaml
let license_apply =
  call ~name:"license_apply" ~in_oss_since:None
    ~lifecycle:
      [
        (Published, rel_rio, "Apply a new license to a host")
      ; (Deprecated, rel_clearwater, "Dummy transition")
      ; (Removed, rel_clearwater, "Free licenses no longer handled by xapi")
      ]
```
- Don't really remove it otherwise you will break XAPI.

---

# Versioning
## Exceptions

- Rules were not always followed:
  - There is a jump from 711 to 751 introduced by commit a94ce5b
- Also notice that *Yangtze* is just an upgrade of *Stockholm*.
  - => As it is not a major release there is no gaps.

---

Thank you!
