# Trac ticket attachments

The files attached to tickets in the retired OpenModelica Trac
(`trac.openmodelica.org/OpenModelica`), kept here so the migrated GitHub issues
in [OpenModelica/OpenModelica](https://github.com/OpenModelica/OpenModelica/issues)
can link to them once Trac is gone. Trac ticket `N` is GitHub issue `#N`.

## Layout

- `ticket/<N>/<filename>`: the attachments of ticket `N`, as they were stored
  on the Trac server.
- `index.csv`: one row per attachment recorded in the Trac database, with the
  columns `ticket`, `filename`, `path`, `size`, `date` (UTC), `author`,
  `description` and `status`.

`status` is one of:

| status | meaning |
|---|---|
| `ok` | the file matches what Trac recorded |
| `size-differs` | the file is present, but its size differs from the Trac record (line endings were converted on the server) |
| `upload-failed` | the upload failed in Trac; the stored file is only an error stub |
| `missing` | Trac recorded the attachment, but the file was no longer on the server (`path` is empty) |

A file name that is not valid on Windows was changed (`filename` keeps the
original, `path` is the file in this repository). Author e-mail addresses
were left out.
