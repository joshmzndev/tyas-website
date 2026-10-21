# TYAS website pages

Standalone pages for https://www.tyas.tyc.edu.tw, hosted at `https://portal.tyas.tyc.edu.tw/website/<page>.html` and embedded in the CMS by an iframe stub. README.md is the human guide; this file holds the rules. Open issues and decisions: REVIEW.md.

## Hard constraints
- The CMS strips `<script>` but keeps `<style>`, inline `style=""` and `<iframe>`. The stub can't run JS, so no auto-resize or fetch-and-inject. JS inside hosted pages is fine (the staff search filter in `administration.html` and `faculty.html`).
- `css/tyas.css` is the only stylesheet; site CSS doesn't reach into the iframe. Site classes (`col_*`, `d_flex`, `.more_btn`, Bootstrap, Font Awesome) don't exist. Add a rule to `tyas.css` before using a new class.
- After a layout or content change, run `tools/measure_heights.sh <page>...` and paste the output into `cms_stubs.html` (one `--h1`…`--h7` line per page). Keep `scrolling="auto"` and a visible credit line.
- `make deploy` uploads only root `*.html` (except `cms_stubs.html`), `css/`, `images/`, `pdf/`. Keep docs, tools and source material (`_originals/`) out of those folders.

## Files
- Modern pages: `accreditation` (`acc__`), `mll` (`mll__`), `mun` (`mun__`), `safeguarding` (`sfg__`), `strategic_plan` (`stp__`). `acc`/`stp` use a centered title + italic subtitle; the rest use eyebrow + two-line `h2`.
- Legacy staff pages: `administration`, `faculty` (`<html class="staff__page">` hides the frame scrollbar and pads the sides; a shared `staff__` search bar over `#articleInfo16` cards; `faculty` also has `staff__group` headings with `staff__jump` buttons that scroll the CMS page to a group, `administration` is one flat list; both pages share the same script; repeated IDs, photos from relative `images/faculty/` paths). Their CSS is copied from the live site and keeps its hex colours on purpose.
- `images/<prefix>/` for page images (relative paths). `images/faculty/` holds staff photos, one file per person named first initial + last name, lowercase (`hkan.jpg`). `images/other/` is unreferenced. `pdf/` is embedded via `<iframe src="pdf/...">`. `_originals/` holds source copy and full-size photos.

## Page rules
- Skeleton: `<!DOCTYPE html>`, `<head>` with charset, viewport, `<title>Name | Taoyuan American School</title>`, `<base target="_top" />`, `<link href="css/tyas.css" rel="stylesheet" />`. No `<style>` or `style=""`.
- In-page anchors need `target="_self"`.
- Structure: `<!-- ===== SECTION N: NAME ===== -->` → `section#prefix_name > .workframe > .wrapper` → eyebrow → two-line `h2` (`<br />`) → content. `<article>` for repeated cards, `<figure>` for images, `<details>/<summary>` for accordions.
- Naming: IDs `prefix_name`, classes `prefix__part` / `prefix__part--modifier`. Scope every rule to its prefix; never restyle bare elements.
- Markup: `<br />`, `<img ... />`, alphabetical attributes, entities (`&#39; &quot; &ndash; &middot; &amp;`), blank line between blocks, only `<li>` tab-indented, descriptive `alt`.
- CSS per page: `/* ---- Shared ---- */` → per-section blocks in page order → `/* ---- Responsive ---- */` (`@media (max-width: 1024px | 768px | 640px)`, desktop-first).

## Design tokens
- Colours (variables only): `--triadic2` headings/strong, `--triadic1` body, `--primary` accents/underlines, `--complement` small labels, `--secondary` rare big red, `--info` default, `--white`. Hairlines/muted text: `rgba(var(--info-rgb), .15 | .5)`. Other `--*-rgb` values are wrong.
- The reset forces Crimson Text 16px `--info` on `div p li a span strong h2-h6…`, so nothing inherits: set font-family, size and colour on every text class, and give `strong`/`em` inside larger text `font-size: inherit; line-height: inherit`. Lists have no bullets.
- Font: `'Crimson Text', serif` (Noto Sans TC for Chinese).
- Type: eyebrow 14px/600/oblique/uppercase/ls 3px `--complement` · `h2` `clamp(46px,5vw,72px)` 600 uppercase lh 110% mb 48 `--triadic2`, and `clamp(26px,9vw,46px)` at ≤640 so long words don't break · card title 28px or `clamp(32px,3vw,46px)` 600 · lead `clamp(20px,1.6vw,26px)` lh 170% ls .5px max-width 720 `--triadic1` · card body 18px lh 160–165% · caption 15px 600 oblique uppercase muted. `strong` in lead text: 700, `--triadic2`, 2px `--primary` underline, offset 4px.
- Spacing only 4 6 8 10 12 16 20 24 32 40 48 56 80. Section padding `6vw 0`; card grid gap 40, two-column gap 80, card padding 48.
- Flat: no shadows, fills (including hover) or rounded boxes; 1px hairlines. Hover = colour change. Images get leaf corners (`0 0 130px 0`, `130px 0 0 0`, `130px 0 130px 0`) alternating between neighbours, 60px at ≤640. Figures: `overflow:hidden; margin:0`, aspect-ratio wide 16/7 (4/3 mobile), pair 4/3, portrait 3/4; hover `scale(1.03)` over .6s.

## Content rules
- "Taoyuan American School (TYAS)" on first mention, "TYAS" after. Expand each acronym once. `<strong>` for proper nouns/achievements, `<em>` for quoted themes. Voice: formal and warm.
- Accreditation: candidacy with **ACS WASC and CIS**, not full accreditation. Never "accredited" or "CIS member".
- Contact: phone +886-3-341-1890, fax +886-3-215-1079. Applications: `/article-Process.html`.
