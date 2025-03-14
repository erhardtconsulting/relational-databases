# Citation Guide for Database History Files

This guide shows how to update references in your markdown files using MyST MD citation syntax.

All references are stored in `docs/references.bib` as BibTex.

## MyST MD Citation Syntax

To cite a reference in your text, use the following syntax:

```
{cite}`citation_key`
```

Then add your key to `docs/references.bib` as BibTex.

For example:
- `{cite}`dataversity_history`` will render as a citation to the DATAVERSITY source
- `{cite}`twobithistory_ims`` will render as a citation to the Two-Bit History article

This will automatically generate a formatted bibliography from all cited references in your document.