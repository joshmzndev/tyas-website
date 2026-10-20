# TYAS website pages

Content pages for the Taoyuan American School (TYAS) website, https://www.tyas.tyc.edu.tw.

The school's CMS is hard to edit and removes any JavaScript, so these pages are written here as plain HTML files instead. They are hosted on the school's portal server at `https://portal.tyas.tyc.edu.tw/website/<page>.html`, and each CMS page shows one of them in an iframe.

## What's in the repo

| Path | What it is |
|---|---|
| `accreditation.html`, `mll.html`, `mun.html`, `safeguarding.html`, `strategic_plan.html` | Content pages in the current design. Copy one of these when you start a new page. |
| `administration.html`, `faculty.html` | Staff directory pages in the older CMS layout. Their photos are hosted on the CMS. |
| `css/tyas.css` | The one stylesheet for every page. |
| `images/`, `pdf/` | Images and PDFs used by the pages, in one folder per page (e.g. `images/mll/`). `images/faculty/` holds staff photos waiting to be uploaded to the CMS, one per person, named first initial + last name in lowercase (e.g. `eteng.jpg`). No page uses them directly, and no page uses `images/other/` either. |
| `_originals/` | Source material: the original copy documents and full-size photos the pages were built from. Not uploaded. |
| `cms_stubs.html` | The snippet to paste into a CMS page, plus the iframe heights for each page. Not uploaded. |
| `deploy.sh` | Uploads the pages, CSS, images and PDFs to the portal server. |
| `tools/` | `measure_heights.sh` works out the iframe heights for `cms_stubs.html`. |
| `Makefile` | `make serve` starts a local preview at http://localhost:8000/. |
| `CLAUDE.md` | The detailed coding and design rules, written for AI assistants. |
| `REVIEW.md` | Open issues that need a person to decide or act. |

## Editing a page

1. Edit the `.html` file. Put all styling in `css/tyas.css`, inside that page's block (each page has its own class prefix, such as `mun__` for the MUN page).
2. Run `make serve` and open the page at http://localhost:8000/ to check it. Check a narrow phone-sized window too.
3. If the page got noticeably longer or shorter, update its iframe heights (see below).
4. Run `./deploy.sh` to upload.

## Adding a page to the CMS

1. Build the page as above and deploy it.
2. Run `tools/measure_heights.sh <page>` (without `.html`). It needs Google Chrome and an internet connection, for the fonts.
3. Copy the snippet from `cms_stubs.html` into the CMS page's HTML source view. Fill in the page file name, a title and the height line the tool printed. Add that line to the list in `cms_stubs.html` too.

### Why the heights are fixed

The CMS strips `<script>`, so the iframe can't grow to fit its page. Instead, the snippet sets a fixed height for each of seven screen-width ranges. The heights are measured with all accordions closed, plus 40px. If a visitor opens an accordion, the frame scrolls inside. The faculty page has tabs of very different lengths, so it gets a scrolling window that is 85% of the screen height.

The small credit line under each iframe must stay readable. Search engines treat hidden links as spam.

## Design in brief

- **Colours:** dark blues for headings and text, a red for small labels, and a brighter blue for accents. All are CSS variables in `tyas.css`.
- **Font:** Crimson Text.
- **Layout:** each section has a small red uppercase label, a large two-line uppercase heading, then the content. On phones the heading shrinks so long words like "MULTILINGUAL" fit on one line.
- **Style:** flat, with no shadows or filled boxes, only thin grey divider lines. Buttons and links change colour on hover. Photos have one large rounded "leaf" corner, alternating between neighbouring photos.

## Writing style

- Write "Taoyuan American School (TYAS)" the first time, then "TYAS".
- Spell out each acronym the first time it appears.
- **Accreditation:** TYAS is a *candidate* with ACS WASC and CIS. Never call the school "accredited" or a "CIS member".
- **Contact:** phone +886-3-341-1890, fax +886-3-215-1079. Applications go through `/article-Process.html`.

## Still to do

MUN program and university acceptances · staff photo uploads · putting the new safeguarding page live · athletics · Christmas video. See REVIEW.md for details.
