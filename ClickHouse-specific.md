## Working with Marksman and multiple repos

In order to keep the docs close to the source-code at ClickHouse
most of the reference (SQL syntax, etc.) docs are in the repo
where the code is.  This gives us heartburn when building the
docs with Docusaurus as the files need to be combined.  In the
`.gitignore` file for the docs repo all of the dirs copied over
from the ClickHouse repo are marked to be ignored; this causes the 
wonderful Marksman LSP to ignore the reference docs, and marks
any links to the reference docs invalid.

The Marksman author came up with a great workaround, as `.ignore` gets
processed after `.gitignore`, I negate the ignore in `.ignore` and 
the reference docs are now eligible for linking.
```
# This is to reverse the .gitignore in the ClickHouse-docs repo, as
# the marksman LSP ignores dirs in the .gitignore when checking
# for links for markdown files.  This file (.ignore) gets processed
# after .gitignore, so the negation (`!`) of the path fixes the issue
# created by copying the files into the clickhouse-docs directory
# structure

# place at root dir of the markdown project, for example:
# $GITHUB/clickhouse-docs/.ignore

!docs/en/development
!docs/en/engines
!docs/en/getting-started
!docs/en/interfaces
!docs/en/operations
!docs/en/sql-reference
docs/ru
docs/zh
docs/_clients
```

## Configuring Marksman

Maybe not needed, but I am not sure.  I think that `.mdx` files
may now be considered Markdown, I should check. I don't like table of
contents to be created, so this is disabled.

```
# Place at root directory of the markdown project, for example:
# $GITHUB/clickhouse-docs/.marksman.toml
[core]
markdown.file_extensions = ["md", "mdx"]
text_sync = "full"

[code_action]
toc.enable = false # Enable/disable "Table of Contents" code action
```
