# Manifests

Manifests enumerate texts to be processed by the corpus kit. Each manifest is a CSV file with the following **required columns**, all in lowercase:

| column        | description                                                     |
|---------------|-----------------------------------------------------------------|
| `path`        | Relative path to the text file on disk.                         |
| `title`       | Title of the work.                                              |
| `author`      | Author of the work.                                             |
| `translator`  | Translator of the work (use `N/A` if not applicable).           |
| `year`        | Year the work was originally published.                         |
| `language`    | Language of the text using ISO 639-1 codes (e.g. `en`, `fr`).   |
| `license_raw` | License description exactly as provided by the source.          |
| `license_norm`| Normalized license tag (e.g. `pd`, `cc-by-4.0`).                |
| `source_url`  | URL where the text was obtained.                                |

Use the helper script `scripts/validate_manifest.py` to ensure manifests contain all
required fields before ingestion:

```bash
python scripts/validate_manifest.py manifests/your_manifest.csv
```
